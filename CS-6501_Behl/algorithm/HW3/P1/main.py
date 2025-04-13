import numpy as np
import environment
from PolicyIteration import PolicyIteration
import seaborn as sns
import matplotlib.pyplot as plt


def main():

    grid_environment = environment.generate_grid()
    states_to_coord, coord_to_states = environment.map_states_and_coordinates()
    transition_matrices = environment.generate_transition_matrices(grid_environment, states_to_coord, coord_to_states)

    # environment.plot_environment(grid_environment)

    policy_iteration = PolicyIteration(grid = grid_environment, gamma = 0.9, transition_matrices = transition_matrices,
                                       state_to_coordinates = states_to_coord, coordinates_to_states = coord_to_states) # create the policy iteration instance
    q_matrix = policy_iteration.create_q_matrix(goal_coordinates = (8, 1), states_to_coord = states_to_coord)
    policy_iteration.policy_iteration()

    return None

if __name__ == "__main__":
    main()