import matplotlib.pyplot as plt
import numpy as np

"""
The functions here are simply for visualization, plotting, or others
that help better understand the process.
"""

# create a heatmap given pi
def display_heatmap(pi):
    plt.imshow(pi, cmap = 'hot', interpolation = 'nearest')
    plt.show()