import numpy as np
import matplotlib.pyplot as plt
import math 
import statistics

def main(seed = 17):
    np.random.seed(seed)
    observations = simulate() # get observations and plot


    return 0

# a) simulate with a = -1 (30 minutes)
def simulate(a = -1, iterations = 100, plot = True):

    observation = []
    
    # get the initial state and observation
    initial_x_mu = 1
    initial_x_sigma_squared= 2

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
def extended_kalman_filter(x_0, observations, initial_a_guess = 7):

    estimated_a = initial_a_guess
    x_list = [x_0]
  

    for observation in observations:

    # 1. propagation
        mean = statistics.mean(x_list)
        var = math.pow(estimated_a, 2) * statistics.variance(x_list) + 1


    # 2. update
        

    return None



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