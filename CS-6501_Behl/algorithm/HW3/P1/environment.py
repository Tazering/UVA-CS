import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from matplotlib.colors import ListedColormap

# generates the initial grid from the assignment details
# only at this moment will the code follow the traditional indexing coordinate system
# generate the map according to the reward
def generate_grid():
    # generate blank grid
    grid = np.zeros(shape = (10, 10))
    grid.fill(-1)

    # set borders as obstacles
    grid[:, 0] = -100
    grid[:, 9] = -100
    grid[0, :] = -100
    grid[9, :] = -100

    # make obstacles
    grid[7, 3:7] = -100
    grid[2:6, 4] = -100
    grid[2, 5] = -100
    grid[4:6, 7] = -100

    # make goal value
    grid[8, 8] = 10

    return grid

def plot_environment(grid):
    colors = ["red", "green", "blue"]
    cmap = ListedColormap(colors)

    sns.heatmap(grid, annot = False, cmap = "mako")
    plt.show()

# create states and their respective coordinates using the cartesian system
def map_states_and_coordinates():
    coord_to_states = {}
    states_to_coord = {}

    # initialize an initial state id number
    state_id = 0

    # create states and their respective coordinates
    for y in range(10):
        for x in range(10):

            coord_to_states[(x, y)] = state_id
            states_to_coord[state_id] = (x, y)

            state_id += 1

    return states_to_coord, coord_to_states

# transition matrices => probabilities from the assignment details
def generate_transition_matrices(grid, states_to_coord, coord_to_states):
    
    transition_matrices = {} # initialize a transition matrix dictionary

    num_states = 100

    up_T = np.zeros(shape = (100, 100))
    down_T = np.zeros(shape = (100, 100))
    left_T = np.zeros(shape = (100, 100))
    right_T = np.zeros(shape = (100, 100))

    goal_state = coord_to_states[(8, 8)]

    up_T[goal_state, goal_state] = 1
    down_T[goal_state, goal_state] = 1
    left_T[goal_state, goal_state] = 1
    right_T[goal_state, goal_state] = 1

    for state_id in range(num_states):
        
        # if a penalty is found
        x, y = states_to_coord[state_id]

        if state_id == goal_state:
            continue

        if grid[9 - y, x] == -100:
            up_T[state_id, state_id] = 1
            down_T[state_id, state_id] = 1
            left_T[state_id, state_id] = 1
            right_T[state_id, state_id] = 1

        else:
            next_up_state = coord_to_states[x, y + 1]
            next_down_state = coord_to_states[x, y - 1]
            next_left_state = coord_to_states[x + 1, y]
            next_right_state = coord_to_states[x - 1, y]

            # up
            up_T[state_id, next_up_state] = .7
            up_T[state_id, next_right_state] = .1
            up_T[state_id, next_left_state] = .1
            up_T[state_id, state_id] = .1

            # down
            down_T[state_id, next_down_state] = .7
            down_T[state_id, next_right_state] = .1
            down_T[state_id, next_left_state] = .1
            down_T[state_id, state_id] = .1

            # left
            left_T[state_id, next_left_state] = .7
            left_T[state_id, next_up_state] = .1
            left_T[state_id, next_down_state] = .1
            left_T[state_id, state_id] = .1

            # right
            right_T[state_id, next_right_state] = .7
            right_T[state_id, next_up_state] = .1
            right_T[state_id, next_down_state] = .1
            right_T[state_id, state_id] = .1
    
    transition_matrices["up"] = up_T
    transition_matrices["down"] = down_T
    transition_matrices["left"] = left_T
    transition_matrices["right"] = right_T


    return transition_matrices