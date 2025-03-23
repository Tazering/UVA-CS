import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import math
from quaternion import Quaternion
import helpful_utils

def initialize():
    Q = np.random.random(shape = (6, 6))
    dynamic_noise = .1
    R = np.diag([0.01, 0.01, 0.01, .001, .001, .001])

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

    chi_x = np.zeros(shape = (n + 1, m)) # 34

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

def step_3(chi_x, delta_t, Q):
    n, m = chi_x.shape

    y_i = np.zeros(shape = chi_x.shape)
    for idx in range(m):
        sigma_state = np.array(chi_x[:, idx])
        w_k = np.random.multivariate_normal(mean = np.zeros(6), cov = Q) # 13

        next_x = process_model(sigma_state, w_k, delta_t)

        y_i[:, idx] = next_x
    
    return y_i

def step_4(y_i):

    # compute mean of omega
    y_i_omega = y_i[4:7, :] # get omega values
    omega_mean = np.mean(y_i_omega, axis = 1) # \bar{omega}

    # use iterative gradient descent for mean of q
    quaternions = []

        # make list of quaternions
    for idx in range(y_i.shape[1]):
        q_idx = Quaternion(scalar = y_i[0, idx], vec = y_i[1:4, idx])
        quaternions.append(q_idx)

    q_bar = helpful_utils.quaternion_mean(quaternions)

    # make a priori
    x_hat_k = np.concatenate((q_bar.q, omega_mean)) # \hat{y}^-_k

    return x_hat_k, q_bar

def step_5(y_i, x_hat_k):
    n, m = y_i.shape

    W_tick_i = np.zeros(shape = (n - 1, m))
    q_bar, omega_bar = helpful_utils.split_state_into_q_and_omega(x_hat_k)


    for idx in range(m):
        x_i = y_i[:, idx]
        q_i, omega_i = helpful_utils.split_state_into_q_and_omega(x_i)

        # omega part
        rel_omega_i = omega_i - omega_bar

        # quaternion part
        rel_q_i = q_i.__mul__(q_bar.inv())
        rel_q_i.normalize()
        rel_q_axis_angle = rel_q_i.axis_angle()
        
        # combine
        w_tick_i = np.concatenate((rel_q_axis_angle, rel_omega_i))

        W_tick_i[:, idx] = w_tick_i

    return W_tick_i

def step_6(W_tick_i):
    n, m = W_tick_i.shape

    P_minus_k = np.matmul(W_tick_i, W_tick_i.T) / m

    return P_minus_k

def step_7(y_i, g, R):
    
    n, m = y_i.shape
    Z_i = np.zeros(shape = (n-1, m))
    for idx in range(m):
        sigma_i = y_i[:, idx]

        q_k, omega_k = helpful_utils.split_state_into_q_and_omega(sigma_i)
        v_k = np.random.multivariate_normal([0, 0, 0, 0, 0, 0], R)

        # H1
        z_rot = omega_k + v_k[:3]
        
        # H2
        q_g = Quaternion(scalar = 0, vec = g)
        qg = q_k.__mul__(q_g)
        q_g_prime = qg.__mul__(q_k.inv()) # 27 g'

        z_accel = q_g_prime.vec() + v_k[3:]

        Z_i[:, idx] = np.concatenate((z_rot, z_accel))

    return Z_i

def step_8(Z_i, z_i_sensor):
    # barycentric mean of Z_i
    Z_k_prior = np.mean(Z_i, axis = 1) # Z_k^-

    # calculate innovation
    v = z_i_sensor - Z_k_prior

    return v[0]

def step_9(Z_i, R):
    P_zz = np.cov(Z_i)
    P_vv = P_zz + R # 45

    return P_vv

def step_10(W_i_prime, Z_i):
    n, m = W_i_prime.shape

    Z_k_prior = np.mean(Z_i, axis = 1) # Z_k^-
    rel_Z = Z_i - Z_k_prior.reshape(len(Z_k_prior), 1)
    P_xz = np.matmul(W_i_prime, rel_Z.T) / m
    return P_xz

def step_11(x_k_prior, P_vv, P_xz, v_k, q_bar):
    K_k = np.matmul(P_xz, np.linalg.inv(P_vv))
    correction = np.matmul(K_k, v_k)

    q_prior, omega_prior = helpful_utils.split_state_into_q_and_omega(x_k_prior)

    # update quaternion
    orientation_correction = np.array(correction[:3])
    theta = np.linalg.norm(orientation_correction)
    e = orientation_correction/theta
    q_delta = Quaternion(scalar = np.cos(theta/2), vec = e * np.sin(theta/2))
    q_next = q_delta.__mul__(q_bar)

    # update angular velocity
    omega_correction = np.array(correction[3:])
    omega_next = omega_prior + omega_correction

    x_next = np.concatenate((q_next.q, omega_next))
    return x_next

# process model
def process_model(x_k, w_k, delta_t):
    # get q_k
    q_k = Quaternion(scalar = x_k[0], vec = x_k[1:4]) # q_k
    omega_k = np.array(x_k[4:7])

    # get q_w
    w_q = w_k[:3] # w_q
    w_omega = w_k[3:6] # w_k

    alpha_w = np.linalg.norm(w_q) # 14
    e_w = w_q / alpha_w # 15

    q_w = Quaternion(scalar = np.cos(alpha_w/2), vec = e_w * np.sin(alpha_w/2)) # 14 q_w

    # get q_delta
    alpha_delta = np.linalg.norm(omega_k) * delta_t # 9
    e_delta = omega_k / alpha_delta # 10
    q_delta = Quaternion(scalar = np.cos(alpha_delta / 2), vec = e_delta * np.sin(alpha_delta/2)) # 11 q_delta

    # create the new state vector
    disturbed_q = q_k.__mul__(q_w)
    new_q = disturbed_q.__mul__(q_delta)

    new_omega = omega_k + w_omega

    x_next = np.concatenate((new_q.q, new_omega)) # x_{k+1}

    return x_next

# helper


def test_function():
    test_state = np.array([1, 0, 0, 0, .5, .3, .2])
    test_state_2 = np.array([.5, .5, .5, .5, .1, .3, .7])
    data = np.vstack((test_state, test_state_2))
    Q_q = np.diag([0.0001, 0.0001, 0.0001])
    Q_omega = np.diag([0.01, 0.01, 0.01])
    R = np.diag([0.01, 0.01, 0.01, .001, .001, .001])
    g = np.array([0, 0, -9.81])
    Z_i_sensor = np.random.rand(1, 6)


    Q = np.block([[Q_q, np.zeros((3, 3))], [np.zeros((3, 3)), Q_omega]])

    L = np.random.rand(6, 6)
    A = L @ L.T
        
    # test steps for functionality
    test_Wi = step_1(A)
    test_chi_x = step_2(test_state, test_Wi)
    y_i = step_3(test_chi_x, .1, Q)
    x_hat_k, q_bar = step_4(y_i)
    W_tick_i = step_5(y_i, x_hat_k)
    P_minus_k = step_6(W_tick_i)
    Z_i = step_7(y_i, g, np.zeros((6,6)))
    innovation = step_8(Z_i, Z_i_sensor)
    P_vv = step_9(Z_i, R)
    P_xz = step_10(W_tick_i, Z_i)
    x_next = step_11(test_state, P_vv, P_xz, innovation, q_bar)

    print(f"x_next: {x_next}\n{x_next.shape}")
    




test_function()