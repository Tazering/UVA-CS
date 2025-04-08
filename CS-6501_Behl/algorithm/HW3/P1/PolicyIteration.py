import numpy as np

"""
0 - up
1 - down
2 - left
3 - right
"""

class PolicyIteration():
    # initialization approach
    def __init__(self, gamma, grid_shape = (10, 10)):
        self.gamma = gamma
        self.policy = np.full(shape = grid_shape, fill_value = 3)
