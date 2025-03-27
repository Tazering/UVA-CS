import numpy as np
import math
from quaternion import Quaternion
import helpful_utils
import calibration
from scipy.signal import butter, filtfilt

def initialize(ax, ay, az, wx, wy, wz, imu_T):
    # assume initial orientation is normal
    init_q = Quaternion(scalar = 1, vec = [0, 0, 0])
    init_omega = np.array([0, 0, 0])
    x0 = np.concatenate((init_q.q, init_omega)) 
    
    # P0 = np.eye(6) * 0.01 # initial covariance

    # Q_q = np.diag([.0001, .0001, .0001])
    # Q_omega = np.diag([0.01, 0.01, 0.01])

    # R = np.diag([0.01, 0.01, 0.01, .001, .001, .001])
    # Q = np.block([[Q_q, np.zeros((3, 3))], [np.zeros((3, 3)), Q_omega]])
    
    R = calibration.calculate_R_covariance(ax, ay, az, wx, wy, wz)
    Q = calibration.calculate_Q_covariance(wx, wy, wz, imu_T)

    # R = np.diag([100, 100, 100, 1e-10, 1e-10, 1e-10])
    # Q = np.diag([1e-10, 1e-10, 1e-10, 1e-10, 1e-10, 1e-10])
    # P0 = np.diag([100, 100, 100, 100, 100, 100])

    # Q = calibration.calculate_Q_covariance(wx, wy, wz, imu_T) # process noise

    # R = calibration.calculate_R_covariance(ax, ay, az, wx, wy, wz) # measurement noise

    P0 = calibration.calculate_P_covariance(ax, ay, az)

    R[0:3, 0:3] *= 0.001  # Increase trust in gyro
    R[3:6, 3:6] *= 100    # Decrease trust in accel
    Q[0:3, 0:3] *= 10     # Allow moderate noise in quaternion
    Q[3:6, 3:6] *= 5      # Allow moderate noise in angular velocityR[0:3, 0:3] *= 0.001  # Increase trust in gyro
    R[3:6, 3:6] *= 100    # Decrease trust in accel
    Q[0:3, 0:3] *= 10     # Allow moderate noise in quaternion
    Q[3:6, 3:6] *= 5      # Allow moderate noise in angular velocity

    return x0, P0, Q, R

def run_ukf_process(accel, accel_params, gyro, gyro_params, imu_T):
    # initialize
    accel_alpha_x, accel_beta_x, accel_alpha_y, accel_beta_y, accel_alpha_z, accel_beta_z = accel_params
    gyro_alpha_x, gyro_beta_x, gyro_alpha_y, gyro_beta_y, gyro_alpha_z, gyro_beta_z = gyro_params

    Ax, Ay, Az, Wx, Wy, Wz = helpful_utils.parse_data(accel, gyro)
    ax = helpful_utils.convert_raw_to_value(Ax, accel_alpha_x, accel_beta_x)
    ay = helpful_utils.convert_raw_to_value(Ay, accel_alpha_y, accel_beta_y)
    az = helpful_utils.convert_raw_to_value(Az, accel_alpha_z, accel_beta_z)
    wx = helpful_utils.convert_raw_to_value(Wx, gyro_alpha_x, gyro_beta_x)
    wy = helpful_utils.convert_raw_to_value(Wy, gyro_alpha_y, gyro_beta_y)
    wz = helpful_utils.convert_raw_to_value(Wz, gyro_alpha_z, gyro_beta_z)

    def lowpass_filter(data, cutoff = 5, fs = 100, order = 2):
        nyquist = fs/2
        normal_cutoff = cutoff / nyquist
        b, a = butter(order, normal_cutoff, btype = 'low', analog = False)
        return filtfilt(b, a, data, axis = 0)
    
    gyro_data = np.column_stack((wx, wy, wz))
    fs = 1 / np.mean(np.gradient(imu_T))
    gyro_data = lowpass_filter(gyro_data, cutoff = 5, fs = fs)
    wx, wy, wz = gyro_data.T

    dt = np.gradient(imu_T)

    x_hat, P, Q, R = initialize(ax, ay, az, wx, wy, wz, imu_T)

    # actually run the ukf
    T = len(dt)

    # T = 10
    states = []
    covariances = []

    for k in range(T):
        accel_k = np.array([ax[k], ay[k], az[k]])
        gyro_k = np.array([wx[k], wy[k], wz[k]])
        dt_k = dt[k]

        # forward/predict
        W_i = step_1(P, Q) # generate the sigma points | W_i

        chi_x = step_2(x_hat, W_i) # compute the sigma point

        y_i = step_3(chi_x, dt_k) # propagate through process model

        x_hat_k = step_4(y_i) # compute a priori

        W_tick_i = step_5(y_i, x_hat_k) # compute relative sigma points | should result in 6 x 12

        P_minus_k = step_6(W_tick_i) # compute covariance a priori | should result in 6 x 6

        # measure sigma points | should result in 6 x 12 (z_rot, z_accel)
        g = np.array([0, 0, -9.81])
        Z_i = step_7(y_i, g, R) 

        z_sensor = np.concatenate((gyro_k, accel_k)) # compute innovation | should result in a 6 x 1 vector
        v_k = step_8(Z_i, z_sensor)

        P_vv = step_9(Z_i, R) # measurement covariance | should return 6 x 6

        P_xz = step_10(W_tick_i, Z_i) # cross covariance | should return 6 x 6

        x_hat, K_k = step_11(x_hat_k, P_vv, P_xz, v_k) # update the state | should return a state

        P = step_12(P_minus_k, K_k, P_vv) # update covariance | should return a 6 x 6

        states.append(x_hat)
        covariances.append(P)

        # print(f"y_i (propagated data): {y_i}\nShape: {y_i.shape}")
        # print(f"x_hat_k: {x_hat_k}\nShape: {x_hat_k.shape}")
        # print(f"q_bar: {q_bar}\n")
        # print(f"W_tick_i: {W_tick_i}\nShape: {W_tick_i.shape}")
        # print(f"P_minus_k: {P_minus_k}\nShape: {P_minus_k.shape}")
        # print(f"Z_i: {Z_i}\nShape: {Z_i.shape}")
        # print(f"v_k (innovation): {v_k}Shape: {v_k.shape}")
        # print(f"Pvv: {P_vv}\nShape: {P_vv.shape}")
        # print(f"P_xz: {P_xz}\nShape: {P_xz.shape}")
        # print(f"x_hat: {x_hat}\nShape: {x_hat.shape}")

        # update
    return np.array(states), np.array(covariances)

# step 1
def step_1(P, Q):
    n = 6

    # cholesky decomposition to get S
    if np.isscalar(P):
        S = np.sqrt(P + Q)
    else:
        S = np.linalg.cholesky(P + Q)

    # get the set Wi
    Wi = np.zeros(shape = (n, 2 * n))
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

    prev_x_q , prev_x_omega = helpful_utils.split_state_into_q_and_omega(prev_x)

    chi_x = np.zeros(shape = (n + 1, m)) # 34

    for idx in range(m):
        wi_quaternion = Quaternion()

        wi_axis_angle = Wi[0:3, idx]
        wi_quaternion.from_axis_angle(wi_axis_angle)

        # calculate quaternion portion
        sigma_quaternion = prev_x_q.__mul__(wi_quaternion)

        # calculate the angular velocity portion
        wi_omega = Wi[3:6, idx]
        sigma_omega = prev_x_omega + wi_omega

        sigma = np.concatenate((sigma_quaternion.q, sigma_omega))

        chi_x[:, idx] = sigma
    
    return chi_x

def step_3(chi_x, delta_t):
    n, m = chi_x.shape

    y_i = np.zeros(shape = chi_x.shape)
    for idx in range(m):
        sigma_state = np.array(chi_x[:, idx])
        next_x = process_model(sigma_state, delta_t)

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

    return x_hat_k

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
        z_rot = omega_k + v_k[3:]
        
        # H2
        q_g = Quaternion(scalar = 0, vec = g)
        qg = q_k.__mul__(q_g)
        q_g_prime = qg.__mul__(q_k.inv()) # 27 g'

        z_accel = q_g_prime.vec() + v_k[:3]

        Z_i[:, idx] = np.concatenate((z_rot, z_accel))

    return Z_i

def step_8(Z_i, z_i_sensor):
    # barycentric mean of Z_i
    Z_k_prior = np.mean(Z_i, axis = 1) # Z_k^-

    # calculate innovation
    v = z_i_sensor - Z_k_prior

    return v

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

def step_11(x_k_prior, P_vv, P_xz, v_k):
    K_k = np.matmul(P_xz, np.linalg.inv(P_vv))
    correction = np.matmul(K_k, v_k)

    q_prior, omega_prior = helpful_utils.split_state_into_q_and_omega(x_k_prior)

    # update quaternion
    # q_prior_rotation_vector = q_prior.axis_angle()
    # new_rotation_vector = q_prior_rotation_vector + correction[:3]
    # q_next = Quaternion()
    # q_next.from_axis_angle(new_rotation_vector)
    q_correction = Quaternion()
    q_correction.from_axis_angle(correction[:3])
    q_next = q_prior.__mul__(q_correction)

    # update angular velocity
    omega_correction = np.array(correction[3:])
    omega_next = omega_prior + omega_correction

    x_next = np.concatenate((q_next.q, omega_next))
    return x_next, K_k

def step_12(P_minus_k, K_k, P_vv):
    correction = np.matmul(K_k, P_vv)
    P_next = P_minus_k - np.matmul(correction, K_k.T)

    return P_next

# process model
def process_model(x_k, delta_t):
    # get q_k
    q_k, omega_k = helpful_utils.split_state_into_q_and_omega(x_k)

    # # get q_w
    # w_q = w_k[:3] # w_q
    # w_omega = w_k[3:6] # w_k

    # alpha_w = np.linalg.norm(w_q) # 14
    # e_w = w_q / alpha_w # 15

    # q_w = Quaternion(scalar = np.cos(alpha_w/2), vec = e_w * np.sin(alpha_w/2)) # 14 q_w

    # get q_delta
    omega_k_norm = np.linalg.norm(omega_k)

    if omega_k_norm < 1e-6:  # Handle very small or zero norm to avoid division by zero
        q_delta = Quaternion(scalar=1, vec=[0, 0, 0])  # Identity quaternion (no rotation)
    else:
        alpha_delta = omega_k_norm * delta_t
        e_delta = omega_k / omega_k_norm
        q_delta = Quaternion(scalar=np.cos(alpha_delta / 2), vec=e_delta * np.sin(alpha_delta/2))

    # create the new state vector
    disturbed_q = q_k.__mul__(q_delta)

    new_omega = omega_k

    x_next = np.concatenate((disturbed_q.q, new_omega)) # x_{k+1}

    return x_next

# helper


"""def test_function():
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
    A = L @ L.T w_omega
        
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

    print(f"x_next: {x_next}\n{x_next.shape}")"""
    


# # # test_function()