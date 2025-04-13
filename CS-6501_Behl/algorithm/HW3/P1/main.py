import numpy as np
import environment
from PolicyIteration import PolicyIteration
import seaborn as sns
import matplotlib.pyplot as plt


def main():

    grid_environment = environment.generate_grid()
    states_to_coord, coord_to_states = environment.map_states_and_coordinates()
    transition_matrices = environment.generate_transition_matrices(grid_environment, states_to_coord, coord_to_states)

    policy_iteration = PolicyIteration(grid = grid_environment, gamma = 0.9, transition_matrices = transition_matrices,
                                       state_to_coordinates = states_to_coord, coordinates_to_states = coord_to_states) # create the policy iteration instance
    policy_iteration.policy_iteration()

    # print(policy_iteration.policies[-1])

    # sns.heatmap(policy_iteration.J_values[-1], annot = True, fmt = ".0f")
    # plt.show()

    # print(policy_iteration.policies[-1])

    ############
    # A) Coded Environment
    ############

    environment.plot_environment(grid_environment)

    ############
    # B) Value @ k = 0
    ############

    J0 = policy_iteration.J_values[1]
    sns.heatmap(data = J0, annot = True, fmt = ".1f")
    plt.title("J for pi_0")
    plt.xlabel("x-coordinates")
    plt.ylabel("y-coordiantes")
    plt.xticks(np.arange(10))
    plt.yticks(np.arange(10))
    plt.show()

    ############
    # C) 4 iterations of policy and value, converged policy and value 
    ############

    policy_1 = policy_iteration.policies[2]
    J_1 = policy_iteration.J_values[2]

    policy_iteration.render_graph_as_arrows(policy = policy_1, J = J_1, plot_title = f"Policy for k = {1}")
    sns.heatmap(data = J_1, annot = True, fmt = ".1f")
    plt.title("J for pi_1")
    plt.xlabel("x-coordinates")
    plt.ylabel("y-coordinates")
    plt.xticks(np.arange(10))
    plt.yticks(np.arange(10))
    plt.show()


    policy_2 = policy_iteration.policies[3]
    J_2 = policy_iteration.J_values[3]

    policy_iteration.render_graph_as_arrows(policy = policy_2, J = J_2, plot_title = f"Policy for k = {2}")
    sns.heatmap(data = J_2, annot = True, fmt = ".1f")
    plt.title("J for pi_2")
    plt.xlabel("x-coordinates")
    plt.ylabel("y-coordinates")
    plt.xticks(np.arange(10))
    plt.yticks(np.arange(10))
    plt.show()


    policy_3 = policy_iteration.policies[4]
    J_3 = policy_iteration.J_values[4]

    policy_iteration.render_graph_as_arrows(policy = policy_3, J = J_3, plot_title = f"Policy for k = {3}")
    sns.heatmap(data = J_3, annot = True, fmt = ".1f")
    plt.title("J for pi_3")
    plt.xlabel("x-coordinates")
    plt.ylabel("y-coordinates")
    plt.xticks(np.arange(10))
    plt.yticks(np.arange(10))
    plt.show()


    policy_4 = policy_iteration.policies[5]
    J_4 = policy_iteration.J_values[5]

    policy_iteration.render_graph_as_arrows(policy = policy_1, J = J_4, plot_title = f"Policy for k = {4}")
    sns.heatmap(data = J_4, annot = True, fmt = ".1f")
    plt.title("J for pi_4")
    plt.xlabel("x-coordinates")
    plt.ylabel("y-coordinates")
    plt.xticks(np.arange(10))
    plt.yticks(np.arange(10))
    plt.show()


    policy_conv = policy_iteration.policies[-1]
    J_conv = policy_iteration.J_values[-1]

    policy_iteration.render_graph_as_arrows(policy = policy_conv, J = J_conv, plot_title = f"Converged Policy")
    sns.heatmap(data = J_4, annot = True, fmt = ".1f")
    plt.title("Converged J")
    plt.xlabel("x-coordinates")
    plt.ylabel("y-coordinates")
    plt.xticks(np.arange(10))
    plt.yticks(np.arange(10))
    plt.show()
   
if __name__ == "__main__":
    main()