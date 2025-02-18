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
    state_to_coordinates = {} # keep track of which states refer to which coordinates (y, x) for sake of consistency
    coordinates_to_states = {}
    state_probabilities = {}


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
        beliefs = np.zeros(shape = action.shape)

        # 1. initialize alpha_1, T, and M
        T, M = self.initialize_matrices(grid = cmap)

        # 2. compute probabilities and normalize
       

        # # 3. create beliefs
        # k = 0
        # for pi_k in self.k_pi.keys():
        #     most_likely_location = self.get_most_likely_state(self.k_pi[pi_k])
        #     beliefs[k] = np.array(most_likely_location)
        #     k += 1

        # # print(beliefs)
        # print(f"action shape: {action.shape}")
        # print(f"observation shape: {observation.shape}")
        
        # # heat map 
        # # helper_utils.display_heatmap(self.k_pi[0])
        # print(beliefs)

        return beliefs

    def calculate_probability(action, current_observation, T, M, beliefs):
        return None

    
    # initialized the pi, T, and M matrices
    def initialize_matrices(self, grid):

        T = {}
        M = {}
        n, m = grid.shape

        total_states = n * m

        # give each location a state
        state_id = 0
        for y in range(0, n):
            for x in range(0, m):
                self.state_to_coordinates[state_id] = (x, y)
                self.coordinates_to_states[(x, y)] = state_id
                state_id += 1


        # T matrix
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

        # set the state probabilities dictionary
        for state_id in range(total_states):
            self.state_probabilities[state_id] = 1/total_states

        return T, M