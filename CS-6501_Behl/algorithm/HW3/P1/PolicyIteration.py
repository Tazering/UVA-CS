import numpy as np

"""
0 - up
1 - down
2 - left
3 - right
"""

class PolicyIteration():
    # initialization approach
    def __init__(self, gamma, q_cost_func, grid_shape = (10, 10)):
        self.gamma = gamma
        self.policy = np.full(shape = grid_shape, fill_value = 3)
        self.q_cost_func = q_cost_func

    def policy_iteration():
        return None
    
    
