import numpy as np
import helper_utils


class HistogramFilter(object):
    """
    Class HistogramFilter implements the Bayes Filter on a discretized grid space.

    - S = sensor; C = color
    - Every cell has color 0 or 1
    - P(S = 1 | C = 1) or P(S = 0 | C = 0) = .9
    - else: .1
    - Action Space = [north, east, south, west]
    - P(robot actually moves) = .9
    - P(robot does not execute) = .1
    - chooses action -> moves -> observes
    - when on edge, robot does not move
    - start with uniform prior on all states
    """

   
    k_alpha = {}  # primarily for memoization when doing summations
    state_to_coordinates = {} # keep track of which states refer to which coordinates (y, x) for sake of consistency


    def histogram_filter(self, cmap, belief, action, observation):
        '''
        Takes in a prior belief distribution, a colormap, action, and observation, and returns the posterior
        belief distribution according to the Bayes Filter.
        :param cmap: The binary NxM colormap known to the robot. (the grid)
        :param belief: An NxM numpy ndarray representing the prior belief. (I think this is the ground-truth for checking)
        :param action: The action as a numpy ndarray. [(1, 0), (-1, 0), (0, 1), (0, -1)]
        :param observation: The observation from the color sensor. [0 or 1].
        :return: The posterior distribution. (stores coordinates)
        '''


        ### Your Algorithm goes Below.
        print(f"cmap Shape: {cmap.shape}")
        print(f"action Shape: {action.shape}")
        print(f"observation shape: {observation.shape}")

        # initialize alpha_1, T, and M
        alpha_1, M = self.initialize_matrices(grid = cmap)

        # run forward algorithm
        beliefs, alpha_next = self.forward_algorithm(cmap, alpha_1, M, action, observations=observation)

        print(beliefs)
        helper_utils.display_heatmap(alpha_next)
        print(alpha_next)


        return None


    # run the forward algorithm
    def forward_algorithm(self, grid, alpha_init, M, action_sequence, observations):

        # do for 0th iteration
        alpha_next = np.zeros(shape = grid.shape)
        beliefs = np.zeros(shape = action_sequence.shape)
        
        for i in range(len(action_sequence)): # loop through each action

            max_index = [-1, -1]
            max_val = -1
            

            for state in self.state_to_coordinates.keys():
                M_x_y = M[state][observations[i]]
                y_index, x_index = self.state_to_coordinates[state]

                updated_belief = M_x_y * self.calculate_alpha_T_summation(state, grid, alpha_init, action_sequence[i])
                alpha_next[y_index][x_index] = updated_belief

                if updated_belief > max_val:
                    max_val = updated_belief
                    max_index = [y_index, x_index]

                alpha_init = alpha_next
            
            beliefs[i] = np.array(max_index)

            print(max_val)

        return beliefs, alpha_next    
    
    # calculates the summation for all observations given one state of interest
    def calculate_alpha_T_summation(self, state_of_interest, grid, alpha, action):

        y_index, x_index = self.state_to_coordinates[state_of_interest]
        alpha_k_state = alpha[y_index][x_index]         

        does_pass_boundry = self.passes_boundry(grid, y_index, x_index, action) # check if boundry is crossed

        if does_pass_boundry: # if boundry is passed    
            return alpha_k_state
                
        else: # if boundry is not passed
            result = (alpha[y_index][x_index] * .1) + (alpha[y_index - action[1]][x_index + action[0]] * .9)
            return result

        # helper function
    def passes_boundry(self, grid, y_index, x_index, action):
        
        delta_x, delta_y = action
        n, m = grid.shape

        if delta_y == 1:
            return y_index <= 0
            
        elif delta_y == -1:
            return y_index >= (n - 1)
        
        elif delta_x == 1:
            return x_index >= (m - 1)
        
        elif delta_x == -1:
            return x_index <= 0
        
        return False


    # initialized the pi, T, and M matrices
    def initialize_matrices(self, grid):

        # get the shape
        n, m = grid.shape
        num_states = n * m

        # number of unique observations
        unique_obs_count = 2
        
        # create the matrices
        pi = np.full(shape = (n, m), fill_value = 1 / (num_states), dtype = 'float', order = 'C')

        # create M
        M = np.zeros(shape = (num_states, unique_obs_count))
        state_num = 0
        for y_index in range(n-1, -1, -1):
            for x_index in range(0, m):

                if grid[y_index][x_index] == 0:
                    M[state_num][0] = .9
                    M[state_num][1] = .1
                else:
                    M[state_num][0] = .1
                    M[state_num][1] = .9
                
                self.state_to_coordinates[state_num] = (y_index, x_index)
                state_num += 1

        return pi, M