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

        print(cmap)

        # initialize alpha_1, T, and M
        alpha_1, T, M = self.initialize_matrices(grid = cmap)

        


        return None


    # initialized the pi, T, and M matrices
    def initialize_matrices(self, grid):

        # get the shape
        n, m = grid.shape
        num_states = n * m

        # number of unique observations
        unique_obs_count = 2
        
        # create the matrices
        pi = np.full(shape = (n, m), fill_value = 1 / (num_states), dtype = 'float', order = 'C')

        # create T
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
                
                state_num += 1

        # create M
        T = np.zeros(shape = (num_states, num_states))

        return pi, T, M
    


    
