import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt

"""
0 - up
1 - down
2 - left
3 - right
"""

class PolicyIteration():
    # initialization approach
    def __init__(self, gamma, grid, transition_matrices, state_to_coordinates, coordinates_to_states):
        self.gamma = gamma
        self.grid = grid
        self.policies = []

        self.policy = np.full(shape = self.grid.shape, fill_value = "right")

        # set borders as obstacles
        self.policy[:, 0] = "o"
        self.policy[:, 9] = "o"
        self.policy[0, :] = "o"
        self.policy[9, :] = "o"

        # make obstacles
        self.policy[7, 3:7] = "o"
        self.policy[2:6, 4] = "o"
        self.policy[2, 5] = "o"
        self.policy[4:6, 7] = "o"

        self.policy[8, 8] = "goal"

        self.policies.append(self.policy.copy()) # add the initial policy
        
        self.J = np.zeros(shape = self.grid.shape)

        # set borders as obstacles
        self.J[:, 0] = -100
        self.J[:, 9] = -100
        self.J[0, :] = -100
        self.J[9, :] = -100

        # make obstacles
        self.J[7, 3:7] = -100
        self.J[2:6, 4] = -100
        self.J[2, 5] = -100
        self.J[4:6, 7] = -100

        self.J[8, 8] = 10
        self.y_shape = grid.shape[0]
        self.x_shape = grid.shape[1]
        self.num_states = self.x_shape * self.y_shape
        self.transition_matrices = transition_matrices
        self.state_to_coordinates = state_to_coordinates
        self.coordinates_to_states = coordinates_to_states
        self.distances = self.create_q_matrix(goal_coordinates = (8, 1), states_to_coord = self.state_to_coordinates)
        self.max_iterations = 100
        self.J_values = []
        self.J_values.append(self.J.copy())
        self.actions = ["right", "left", "up", "down"]
        self.has_state_changed = False


    def policy_iteration(self):

        for _ in range(self.max_iterations):
            self.has_state_changed = False

            # calculate the cost of the current policy        
            J_new = self.update_J()
            self.J = J_new

            # update policy
            self.update_policy()
            self.policies.append(self.policy.copy())
            self.J_values.append(J_new)


            # break if none of the states changed
            if not self.has_state_changed:
                break
        
            print(f"Iteration: {_}\nStates changed: {self.has_state_changed}")


    def create_q_matrix(self, goal_coordinates, states_to_coord): # just use the euclidean distance from point to goal
        shape_y, shape_x = self.grid.shape
        target_x, target_y = goal_coordinates

        q_matrix = np.zeros(shape = self.grid.shape)

        state_num = shape_x * shape_y

        for state_id in range(state_num): # loop through each state
            state_coord = states_to_coord[state_id]

            x, y = state_coord

            diff_x = target_x - x
            diff_y = target_y - y

            dist = np.sqrt(np.power(diff_x, 2) + np.power(diff_y, 2))

            q_matrix[shape_y - 1 - y, x] = dist

        return q_matrix
    
    def update_policy(self):
        
        # # loop through all the states
        for state_idx in range(self.num_states):
            x_coord, y_coord = self.state_to_coordinates[state_idx]
            y_index = self.y_shape - 1 - y_coord
            x_index = x_coord

            policy_direction = self.policy[y_index, x_index]

            if policy_direction == "o":
                J_val = self.calculate_state_J(state_idx = state_idx, state_coord = (x_coord, y_coord), policy_direction = "o")
                continue

            elif policy_direction == "goal":
                J_val = self.calculate_state_J(state_idx = state_idx, state_coord = (x_coord, y_coord), policy_direction = "goal")
                continue

            best_action = ""
            best_J = -1000

            for action in self.actions: # loop through each action
                
                # calculate the J
                J_val = self.calculate_state_J(state_idx = state_idx, state_coord = (x_coord, y_coord), policy_direction = action)

                # if the policy is better or not
                if J_val > best_J:
                    best_J = J_val
                    best_action = action
            
            # update the policy

            # print(f"State {state_idx}: Policy direction {policy_direction}, Best Action: {best_action}")
            if policy_direction != best_action:
                self.has_state_changed = True
            
            self.policy[y_index, x_index] = best_action


    
    # updates the J value
    def update_J(self): 
        J_new = np.zeros(shape = self.grid.shape)

        for state_id in range(self.num_states): # goes through each state in the grid
            # get all the necessary variables
            x_coord, y_coord = self.state_to_coordinates[state_id]
            y_index = self.y_shape - 1 - y_coord
            x_index = x_coord
            policy_direction = self.policy[self.y_shape - 1 - y_coord, x_coord]

            # calculate value of state state_id
            J = self.calculate_state_J(state_idx = state_id, state_coord = (x_coord, y_coord), policy_direction = policy_direction)

            # update the J_new table
            J_new[y_index, x_index] = J

        return J_new
    
    # helper function for update_J
    # returns the updated cost for ONE grid
    def calculate_state_J(self, state_idx, state_coord, policy_direction):
        x_state_coord, y_state_coord = state_coord
        y_index = self.y_shape - 1 - y_state_coord
        x_index = x_state_coord
        J = 0

        # if the state is an obstacle, then just run the -100 calculation
        if policy_direction == "o":
            # J = -100 + self.gamma * self.J[y_index, x_index]
            J = -100

        elif policy_direction == "goal": # if the state is a goal
            J = 10 + self.gamma * self.J[y_index, x_index]

        else: # everything else
            T_row = self.transition_matrices[policy_direction][state_idx, :]
            

            for next_state_id in range(self.num_states): # go through each state and get the expected J function
                next_x_state_coord, next_y_state_coord = self.state_to_coordinates[next_state_id] 
                y_index_new = self.y_shape - 1 - next_y_state_coord
                x_index_new = next_x_state_coord

                J += T_row[next_state_id] * self.J[y_index_new, x_index_new]

            J = -self.distances[y_index, x_index] + self.gamma * J
        
        return J

    # renders the policy graph as arrows
    def render_graph_as_arrows(self, policy, J, plot_title = ""): 
        
        # Create the heatmap with a different colormap for better contrast
        plt.figure(figsize=(8, 6))
        heatmap = plt.imshow(J, cmap = "magma")  # 'coolwarm' for better contrast
        plt.colorbar(heatmap, label='J values')

        # Add arrows with a contrasting color
        for row in range(10):
            for col in range(10):
                action = policy[row, col]
                if action == "o" or action == "goal":
                    continue

                x, y = col - 0, row

                if action == "up":  # North
                    dx, dy = 0, -0.3
                elif action == "right":  # East
                    dx, dy = 0.3, 0
                elif action == "left":  # West
                    dx, dy = -0.3, 0
                elif action == "down":  # South
                    dx, dy = 0, 0.3
                    
                # Use black arrows for contrast against 'coolwarm'
                plt.arrow(x, y, dx, dy, head_width=0.1, head_length=0.1, fc='black', ec='black')

        # Customize the plot
        plt.title(plot_title)
        plt.xlabel('x-coordinates')
        plt.ylabel('y-coordinates')
        plt.xticks(np.arange(10))
        plt.yticks(np.arange(10))
        # plt.grid(True, which='both', color='white', linestyle='-', linewidth=0.5, alpha = 0.7)
        plt.show()

        
    
