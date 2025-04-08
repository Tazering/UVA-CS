import numpy as np
import environment


def main():

    grid_environment = environment.generate_grid()
    states_to_coord, coord_to_states = environment.map_states_and_coordinates()
    transition_matrices = environment.generate_transition_matrices(grid_environment, states_to_coord, coord_to_states)

    environment.plot_environment(grid_environment)

    return None

if __name__ == "__main__":
    main()