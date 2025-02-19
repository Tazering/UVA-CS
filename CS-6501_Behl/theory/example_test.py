import numpy as np
import matplotlib.pyplot as plt
from histogram_filter import HistogramFilter
import random


if __name__ == "__main__":

    # Load the data
    data = np.load(open('starter.npz', 'rb'))
    cmap = data['arr_0']
    actions = data['arr_1']
    observations = data['arr_2']
    belief_states = data['arr_3']

    print("belief_states: \n", belief_states)
    # print("action_shape: ", actions.shape)
    # print(type(actions[0]))
    # print(belief_states.shape)

    # print(type(belief_states[0]))


    #### Test your code here
    histogram_filter_class = HistogramFilter()
    histogram_filter_class.histogram_filter(cmap = cmap, action = actions, observation = observations, belief = belief_states)
    # histogram_filter_class.histogram_filter(cmap = np.array([[1, 0],[0, 1]]), action = np.array([1, 0]), observation = 1, belief = belief_states)

