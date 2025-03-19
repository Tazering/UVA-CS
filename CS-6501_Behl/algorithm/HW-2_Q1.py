import numpy as np
import matplotlib.pyplot as plt
import math 
import statistics

def main(seed = 42):
    np.random.seed(seed)

    distribution_param = {} # stores the distribution parameters
    distribution_param[0] = {"mean": np.array([[1], [7]]), "covariance": np.array([[2, 0],[0, 100]])}

    observations = simulate(plot = False) # get observations and plot
    distribution_param, a_list = extended_kalman_filter(distribution_param, observations)

    print(a_list)

    return 0

# a) simulate with a = -1 (30 minutes)
def simulate(a = -1, iterations = 100, plot = True):

    observation = []
    
    # get the initial state and observation
    x_i = np.random.normal(1, 2)
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
    

    return  observation

# b) extended kalman filter
def extended_kalman_filter(distribution_param, observations):

    # initial setup
    a = distribution_param[0]["mean"][1][0]
    num_observations = len(observations)

    a_list = [a]

    for obs_idx in range(1, num_observations):
        # propagate dynamics
        mean, cov = propagate_dynamics(distribution_param[obs_idx - 1], a)

        # incorporate observations
        mean, cov = incorporate_observation(mean, cov, observations[obs_idx])

        # updates
        distribution_param[obs_idx] = {"mean": mean, "covariance": cov}
        a = mean[1][0]
        a_list.append(a)
        # print(f"mean:\n{mean}\ncov:\n{cov}")


    return distribution_param, a_list

# major functions
def propagate_dynamics(state, a, R = 1):
    mean = state["mean"]
    cov = state["covariance"]

    A = np.array([[a, mean[0][0]], [0, 1]])

    mean = np.array([[mean[0][0] * a], [a]])
    cov = np.matmul(A, cov)
    cov = np.matmul(cov, A.T) + np.array([[1, 0], [0, 0]])

    return mean, cov

def incorporate_observation(mean, cov, current_obs, Q = .5):
    C = get_C(mean[0][0])

    K = calculate_kalman_gain(cov, C, Q)

    mean = mean + K * (current_obs - get_observation(mean[0][0], incorporate_noise = False))
    cov = np.matmul((np.array([[1, 0], [0, 1]]) - np.matmul(K, C)), cov)

    return mean, cov


# helper functions
def calculate_kalman_gain(cov, C, Q = .5):
    K = np.matmul(cov, C.T)
    inverse_portion = np.matmul(C, cov)
    inverse_portion = np.matmul(inverse_portion, C.T) + Q

    K = np.matmul(K, np.linalg.inv(inverse_portion))

    return K

# calculate next state
def calculate_next_state(previous_state, a, e):
    x_k = a * previous_state + e
    return x_k

# calculate C
def get_C(state):

    y = np.array([[calculate_derivative_of_g(state), 0]])

    return y

def calculate_derivative_of_g(x):
    return x / math.sqrt(math.pow(x, 2) + 1)

# get the observation
def get_observation(state, v = None, incorporate_noise = True):
    if incorporate_noise:
        y_k = np.sqrt(np.power(state, 2) + 1) + v
    else:
        y_k = np.sqrt(np.power(state, 2) + 1)

    return y_k


# call the main function
main()