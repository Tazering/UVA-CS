import matplotlib.pyplot as plt
import numpy as np

"""
The functions here are simply for visualization, plotting, or others
that help better understand the process.
"""

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