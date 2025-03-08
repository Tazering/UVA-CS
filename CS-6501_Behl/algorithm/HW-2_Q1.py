import numpy as np
import matplotlib.pyplot as plt
import math 
import statistics

def main(seed = 17):
    np.random.seed(seed)

    distribution_param = {} # stores the distribution parameters
    distribution_param[0] = {"mean": 1, "variance": 2}

    observations = simulate(distribution_param = distribution_param) # get observations and plot

    return 0

# a) simulate with a = -1 (30 minutes)
def simulate(a = -1, iterations = 100, distribution_param = {}, plot = True):

    observation = []
    
    # get the initial state and observation
    initial_x_mu = distribution_param[0]["mean"]
    initial_x_sigma_squared= distribution_param[0]["variance"]

    x_i = np.random.normal(initial_x_mu, initial_x_sigma_squared)
    v = np.random.normal(0, 1/2) # noise
    y_i = get_observation(x_i, v) # initial observation

    observation.append(y_i) # add first observation

    for i in range(iterations - 1):
        e = np.random.normal(0, 1)
        x_i = calculate_next_state(x_i, a, e)

        v = np.random.normal(0, 1/2) # noise
        y_i = get_observation(x_i, v)

        observation.append(y_i)
    
    if plot:
        plt.title("x_k vs y_k")
        plt.plot(observation)
        plt.xlabel("X_k")
        plt.ylabel("Y_k")
        plt.show()
    

    return observation

# b) extended kalman filter
def extended_kalman_filter(x_0, distribution_param, observations, initial_a_guess = 7):

    estimated_a = initial_a_guess
    x_list = [x_0]
  
# calculate next state
def calculate_next_state(previous_state, a, e):
    x_k = a * previous_state + e
    return x_k

# get the observation
def get_observation(state, v):
    y_k = np.sqrt(np.power(state, 2) + 1) + v

    return y_k


# call the main function
main()