import numpy as np


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
        :param cmap: The binary NxM colormap known to the robot.
        :param belief: An NxM numpy ndarray representing the prior belief.
        :param action: The action as a numpy ndarray. [(1, 0), (-1, 0), (0, 1), (0, -1)]
        :param observation: The observation from the color sensor. [0 or 1].
        :return: The posterior distribution.
        '''

        ### Your Algorithm goes Below.
        # self.print_list_of_values(observation, "observation")

        return None

    




    # a bunch of helper functions for debugging and testing
    def print_list_of_values(self, lst, name):
        
        print("\n-----------\nPrinting Values from " + str(name) + "\n")
        for val in lst:
            print(val)
        print("-----------\n")

        return None
