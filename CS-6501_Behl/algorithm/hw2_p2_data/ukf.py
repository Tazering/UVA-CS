import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import math
from quaternion import Quaternion


def initialize():
    covariance = .1
    dynamic_noise = .1
    measurement_cov = .1

def run_ukf_process(self):
    # initialize


    # step 1
    # step 2
    return None

# step 1
def step_1(P):
    n = 6

    # cholesky decomposition to get S
    if np.isscalar(P):
        S = np.sqrt(P)
    else:
        S = np.linalg.cholesky(P)

    # get the set Wi
    Wi = np.zeros(shape = (6, 12))
    positive_s = math.sqrt(2 * n)
    negative_s = -math.sqrt(2 * n)

    Wi[:, 0] = S[:, 0] * positive_s
    Wi[:, 1] = S[:, 0] * negative_s
    Wi[:, 2] = S[:, 1] * positive_s
    Wi[:, 3] = S[:, 1] * negative_s
    Wi[:, 4] = S[:, 2] * positive_s
    Wi[:, 5] = S[:, 2] * negative_s
    Wi[:, 6] = S[:, 3] * positive_s
    Wi[:, 7] = S[:, 3] * negative_s
    Wi[:, 8] = S[:, 4] * positive_s
    Wi[:, 9] = S[:, 4] * negative_s
    Wi[:, 10] = S[:, 5] * positive_s
    Wi[:, 11] = S[:, 5] * negative_s

    return Wi

# compute the sigma points
def step_2(prev_x, Wi):
    n, m = Wi.shape

    prev_x_q = Quaternion(scalar = prev_x[0], vec = prev_x[1:4])
    prev_x_omega = prev_x[4:7]

    chi_x = np.zeros(shape = (n + 1, m))

    for idx in range(m):
        wi_quaternion = Quaternion()

        wi_euler_angle = Wi[0:3, idx]
        wi_quaternion.from_axis_angle(wi_euler_angle)

        # calculate quaternion portion
        sigma_quaternion = prev_x_q.__mul__(wi_quaternion)

        # calculate the angular velocity portion
        wi_omega = Wi[3:6, idx]
        sigma_omega = prev_x_omega + wi_omega

        sigma = np.concatenate((sigma_quaternion.q, sigma_omega))

        chi_x[:, idx] = sigma
    
    return chi_x

def step_3(chi_x, delta_t):
    x_omega = np.array(chi_x[4:7, :])
    x_quaternion = np.array(chi_x[0:4, :])
    n, m = x_omega.shape

    # print(f"x_quaternion: {x_quaternion}\n")

    y_i = []
    for idx in range(m):
        sigma_omega = np.array(x_omega[:, idx])
        sigma_quaternion = np.array(x_quaternion[:, idx])

        sigma_omega_norm = np.linalg.norm(sigma_omega)
        alpha = sigma_omega_norm * delta_t # 9
        e = sigma_omega / sigma_omega_norm # 10

        quaternion_delta = Quaternion(scalar = np.cos(alpha/2), vec = np.sin(alpha/2) * e)
        quaternion = Quaternion(scalar = sigma_quaternion[0], vec = sigma_quaternion[1:4])

        next_quaternion = quaternion.__mul__(quaternion_delta)

        # print(f"quaternion delta: {quaternion_delta}\n")

    # x_omega_norm = np.linalg.norm(x_omega)

    # alpha = x_omega_norm * delta_t # 9
    # e = x_omega / x_omega # 10

    # quaternion_delta = Quaternion(scalar = np.cos(alpha/2), vec = np.sin(alpha/2) * e) # 11

    # quaternion = Quaternion()


    # print(f"\nquaternion: {quaternion}\n")

    return None

def test_function():
    test_state = np.array([1, 0, 0, 0, .5, .3, .2])
    test_state_2 = np.array([.5, .2, 0, 0, .1, .3, .7])
    data = np.vstack((test_state, test_state_2))

    L = np.random.rand(6, 6)
    A = L @ L.T
        
    # test step 1 for functionality
    test_Wi = step_1(A)
    test_chi_x = step_2(test_state, test_Wi)
    step_3(test_chi_x, .1)



test_function()