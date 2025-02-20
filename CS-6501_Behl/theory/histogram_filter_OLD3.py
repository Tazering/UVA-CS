import numpy as np
import matplotlib.pyplot as plt


class HistogramFilter(object):
    """
    Class HistogramFilter implements the Bayes Filter on a discretized grid space.
    """
    state_to_coordinates = {} # keep track of which states refer to which coordinates (y, x) for sake of consistency
    coordinates_to_states = {}
    k_posterior = {}

    def histogram_filter(self, cmap, belief, action, observation):
        '''
        Takes in a prior belief distribution, a colormap, action, and observation, and returns the posterior
        belief distribution according to the Bayes Filter.
        :param cmap: The binary NxM colormap known to the robot. (the grid)
        :param belief: An NxM numpy ndarray representing the prior belief. (I think this is the ground-truth for checking)
        :param action: The action as a numpy ndarray. [(1, 0), (-1, 0), (0, 1), (0, -1)]
        :param observation: The observation from the color sensor. [0 or 1].
        :return: The posterior distribution. 
        '''
        ### Your Algorithm goes Below.
        n, m = cmap.shape
        beliefs = np.zeros(shape = (n, m))

        # 1. initialize T and M matrices
        T, M = self.initialize_matrices(grid = cmap)

        # 2. recursively solve Bayes Filter
        posterior = self.calculate_beliefs(actions = action, observations = observation, M = M, T = T)

        beliefs = self.convert_MT_to_grid(grid = cmap, MT = posterior)

        # beliefs = translate_dict_to_map(self.state_probabilities, self.state_to_coordinates, shape = cmap.shape)

        # for i in range(belief.shape[0]):
        #     if ((belief[i][0] - best_locations[i][0]) == 0) and ((belief[i][1] - best_locations[i][1]) == 0):
        #         print(i)
        
        # print(beliefs.shape)

        return beliefs


    def calculate_beliefs(self, actions, observations, M, T):

        if (len(actions.shape) == 1):
            current_action = self.string_action(actions)
            current_observation = observations

            return np.matmul(T[current_action], M[current_observation])
        
        current_action = self.string_action(actions[0])
        current_observation = observations[0]

        posterior = np.matmul(T[current_action], M[current_observation])
        prior = np.sum(posterior, axis = 0)
        prior_matrix = self.create_prior_matrix(prior)
        
        for i in range(1, actions.shape[0]):
            current_action = self.string_action(actions[i])
            current_observation = observations[i]

            posterior = np.matmul(T[current_action], M[current_observation])
            posterior = np.matmul(prior_matrix, posterior)

            prior = np.sum(posterior, axis = 0)
            prior_matrix = self.create_prior_matrix(prior)

            max_state = self.pick_largest(prior)

            # print(self.state_to_coordinates[max_state])


        return posterior

    def create_prior_matrix(self, prior):
        prior_matrix = np.zeros(shape = (len(prior), len(prior)))

        for state in range(len(prior)):
            prior_matrix[state][state] = prior[state]
        

        return prior_matrix


    # get largest state
    def pick_largest(self, state_probabilities):

        max_val = -1
        max_state = -1

        for i in range(len(state_probabilities)):

            if state_probabilities[i] >= max_val:
                max_val = state_probabilities[i]
                max_state = i
        
        return max_state

    
    ######################
    # Initialization
    ######################
    
    # initialized the pi, T, and M matrices
    def initialize_matrices(self, grid):
        n, m = grid.shape
        total_states = n * m

        # give each location a state
        state_id = 0
        for y in range(0, n):
            for x in range(0, m):
                self.state_to_coordinates[state_id] = (x, y)
                self.coordinates_to_states[(x, y)] = state_id

                state_id += 1

        T = self.init_T(grid = grid)
        M = self.init_M(grid = grid)

        return T, M

    # helper for initialization
    def init_T(self, grid):
        T = {}
        n, m = grid.shape
        total_states = n * m

        # T matrices
        T_right = np.zeros(shape = (total_states, total_states))
        T_left = np.zeros(shape = (total_states, total_states))
        T_up = np.zeros(shape = (total_states, total_states))
        T_down = np.zeros(shape = (total_states, total_states))

        for state in self.state_to_coordinates.keys(): # loop through states
            
            x, y = self.state_to_coordinates[state]

            # boundries first
            if x >= (m - 1):
                T_right[state][state] = 1
            if x <= 0:
                T_left[state][state] = 1
            if y >= (n - 1):
                T_up[state][state] = 1
            if y <= 0:
                T_down[state][state] = 1

            # fill everything in
            if T_right[state][state] != 1:
                T_right[state][self.coordinates_to_states[((x + 1), y)]] = .9
                T_right[state][state] = .1

            if T_left[state][state] != 1:
                T_left[state][self.coordinates_to_states[((x - 1), y)]] = .9
                T_left[state][state] = .1

            if T_up[state][state] != 1:
                T_up[state][self.coordinates_to_states[(x, y + 1)]] = .9
                T_up[state][state] = .1
            
            if T_down[state][state] != 1:
                T_down[state][self.coordinates_to_states[(x, y - 1)]] = .9
                T_down[state][state] = .1
        
        T["right"] = T_right
        T["left"] = T_left
        T["up"] = T_up
        T["down"] = T_down

        return T


    def init_M(self, grid):

        M = {}
        n, m = grid.shape
        total_states = n * m

        # M matrix
        M_1 = np.zeros(shape = (total_states, total_states))
        M_0 = np.zeros(shape = (total_states, total_states))

        # M matrix
        for y in range(n - 1, -1, -1):
            for x in range(0, m):
                state_id = self.coordinates_to_states[(x, n - 1 - y)]

                if grid[y][x] == 1:
                    M_0[state_id][state_id] = .1
                    M_1[state_id][state_id] = .9
                else:
                    M_0[state_id][state_id] = .9
                    M_1[state_id][state_id] = .1
        
        M[0] = M_0
        M[1] = M_1

        return  M

    # converts action to words
    def string_action(self, action):
        x = action[0]
        y = action[1]

        if x == 1:
            return "right"

        if x == -1:
            return "left"

        if y == 1:
            return "up"
        
        return "down"
    
    # update the probabilities
    def update_state_probabilities(self, likelihood):
        sum = 0
        max_val = -1
        max_idx = np.array([-1, -1])

        for state in self.state_probabilities.keys(): # add the prior belief
            for y in range(likelihood.shape[0]):
                likelihood[y][state] *= self.state_probabilities[state]

        for state in self.state_probabilities.keys(): # loop through states
            self.state_probabilities[state] = np.sum(likelihood[state])
            sum += self.state_probabilities[state]
        
        for state in self.state_probabilities.keys():
            self.state_probabilities[state] /= sum

            if self.state_probabilities[state] >= max_val:
                max_val = self.state_probabilities[state]

                x, y = self.state_to_coordinates[state]

                max_idx = np.array([x, y])
        
        return max_idx


    # converts M to grid
    def convert_MT_to_grid(self, grid, MT):
        n, m = grid.shape
        posterior = np.zeros(shape = grid.shape)

        state_probabilities = np.sum(MT, axis = 0)
        state_probabilities /= np.sum(state_probabilities)

        for state in self.state_to_coordinates.keys():
            x, y = self.state_to_coordinates[state]

            posterior[n - 1 - y][x] = state_probabilities[state]
        
        return posterior

# translate dict to map
def translate_dict_to_map(state_to_probabilities, state_to_coordinates, shape = (1, 1)):
    n, m = shape

    belief = np.zeros(shape = shape)
    for state in state_to_probabilities.keys(): # loop through states
        x, y = state_to_coordinates[state]

        belief[n - 1 - y][x] = state_to_probabilities[state]
    
    return belief

# create a heatmap given pi
def display_heatmap(pi):
    plt.imshow(pi, cmap = 'hot', interpolation = 'nearest')
    plt.show()