import numpy as np
from quaternion import Quaternion
import calibration
import helpful_utils
import math

def run_ukf(accel, accel_params, gyro, gyro_params, imu_T):

    accel_alpha_x, accel_beta_x, accel_alpha_y, accel_beta_y, accel_alpha_z, accel_beta_z = accel_params
    gyro_alpha_x, gyro_beta_x, gyro_alpha_y, gyro_beta_y, gyro_alpha_z, gyro_beta_z = gyro_params

    Ax, Ay, Az, Wx, Wy, Wz = helpful_utils.parse_data(accel, gyro)
    ax = helpful_utils.convert_raw_to_value(Ax, accel_alpha_x, accel_beta_x)
    ay = helpful_utils.convert_raw_to_value(Ay, accel_alpha_y, accel_beta_y)
    az = helpful_utils.convert_raw_to_value(Az, accel_alpha_z, accel_beta_z)
    wx = helpful_utils.convert_raw_to_value(Wx, gyro_alpha_x, gyro_beta_x)
    wy = helpful_utils.convert_raw_to_value(Wy, gyro_alpha_y, gyro_beta_y)
    wz = helpful_utils.convert_raw_to_value(Wz, gyro_alpha_z, gyro_beta_z)

    dt = np.gradient(imu_T)

    # actually run the ukf
    T = len(dt)

    # T = 10
    states = []
    covariances = []

    # initialize the covariances
    init_q = Quaternion(scalar = 1, vec = [0, 0, 0])
    init_omega = np.array([0, 0, 0])
    x0 = np.concatenate((init_q.q, init_omega)) 

    # R = calibration.calculate_R_covariance(ax, ay, az, wx, wy, wz)
    # Q = calibration.calculate_Q_covariance(wx, wy, wz, imu_T)

    # P0 = calibration.calculate_P_covariance(ax, ay, az)

    # R = np.diag([.1e-2, .1e-2, .1e-2, .1e-2, .1e-2, .1e-2])
    # Q = np.diag([.1e-2, .1e-2, .1e-2, .1e-2, .1e-2, .1e-2])
    # P0 = np.diag([.1e-2, .1e-2, .1e-2, .1e-2, .1e-2, .1e-2])

    # R = np.diag([.1e-2, .1e-2, .1e-2, .1e-2, .1e-2, .1e-2])
    # Q = np.diag([1e-1, 1e-1, 1e-1, 1, 1, 1])
    # P0 = np.diag([.1e-2, .1e-2, .1e-2, .1e-2, .1e-2, .1e-2])

    # R = np.diag([.1e-4, .1e-4, .1e-4, .1e-1, .1e-1, .1e-1])
    # Q = np.diag([1e-3, 1e-3, 1e-3, 1e-1, .1e-1, .1e-1])
    # P0 = np.diag([.1e-2, .1e-2, .1e-2, .1e-2, .1e-2, .1e-2])

    # R = np.diag([.1e-6, .1e-6, .1e-6, .1e-1, .1e-1, .1e-1])
    # Q = np.diag([1e-6, 1e-6, 1e-6, 1e-1, .1e-1, .1e-1])
    # P0 = np.diag([.1e-2, .1e-2, .1e-2, .1e-2, .1e-2, .1e-2])

##### BEST
    # R = np.diag([.1e-6, .1e-6, .1e-6, .1, .1, .1])
    # Q = np.diag([1e2, 1e2, 1e2, 1e2, 1e2, 1e2])
    # P0 = np.diag([.1e-2, .1e-2, .1e-2, .1e-2, .1e-2, .1e-2])
####

    R = np.diag([.1e-12, .1e-12, .1e-12, 1e-1, 1e-1, 1e-1])
    Q = np.diag([1e2, 1e2, 1e2, 1e2, 1e2, 1e2])
    P0 = np.diag([.1e-2, .1e-2, .1e-2, .1e-2, .1e-2, .1e-2])

    # R = np.diag([.1e-12, .1e-12, .1e-12, 1e-1, 1e-1, 1e-1])
    # Q = np.diag([1e3, 1e3, 1e3, 1e2, 1e2, 1e2])
    # P0 = np.diag([.1e-2, .1e-2, .1e-2, .1e-2, .1e-2, .1e-2])

    x_bar = x0
    P_prior_k = P0

    for k in range(T):
        accel_k = np.array([ax[k], ay[k], az[k]])
        gyro_k = np.array([wx[k], wy[k], wz[k]])
        dt_k = dt[k]

        Y_i = generate_sigma_points(x_bar, P_prior_k, dt_k, Q)
        x_hat_prior, P_prior_k, W_prime_i = compute_apriori(Y_i)
        v_k, P_vv, P_xz = propagate_forward(Y_i, W_prime_i, accel_k, gyro_k, R)
        x_hat, P_k = update(x_hat_prior, P_prior_k, v_k, P_xz, P_vv)
    
        x_bar = x_hat
        P_prior_k = P_k

        states.append(x_bar)
        covariances.append(P_prior_k)


    return np.array(states), np.array(covariances)

# this function generates and forwards the sigma points (steps 1 - 3)
def generate_sigma_points(prev_mu, P, delta_t, Q):

    # step 1: convert the previous covariance P and process noise Q into Wi (6 x 12)
    S = np.linalg.cholesky(P + Q) # run cholesky decomposition 
    scaling_factor = math.sqrt(2 * 6)
    W_i = np.hstack((scaling_factor * S, -scaling_factor * S)) # 36, (6 x 12)

    # step 2: create sigma points set chi_x
    chi_i = np.zeros(shape = (7, 12))
    Y_i = np.zeros(shape = (7, 12))
    prev_mu_q, prev_mu_omega = helpful_utils.split_state_into_q_and_omega(prev_mu)
    disturbance_q = Quaternion()

    for disturbance_factor_idx in range(12): # iterate through all the W_i values
        disturbance_factor = W_i[:, disturbance_factor_idx]
        disturbance_q.from_axis_angle(disturbance_factor[:3])

        chi_i_q = prev_mu_q.__mul__(disturbance_q)
        chi_i_omega = prev_mu_omega + disturbance_factor[3:]
        sigma_state = np.concatenate([chi_i_q.q, chi_i_omega])
        chi_i[:, disturbance_factor_idx] = sigma_state

        # step 3: project each point ahead using the process model
        Y_i[:, disturbance_factor_idx] = process_model(sigma_state, delta_t)

    return Y_i

# run through the process model
def process_model(x_k, delta_t):
    x_k_q, omega_k = helpful_utils.split_state_into_q_and_omega(x_k)

    omega_k_norm = np.linalg.norm(omega_k)

    if omega_k_norm < 1e-6:  # Handle very small or zero norm to avoid division by zero
        q_delta = Quaternion(scalar=1, vec=[0, 0, 0])  # Identity quaternion (no rotation)
    else:
        alpha_delta = omega_k_norm * delta_t

        e_delta = omega_k / omega_k_norm
        q_delta = Quaternion(scalar=np.cos(alpha_delta / 2), vec = e_delta * np.sin(alpha_delta/2))

    q_disturbed = x_k_q.__mul__(q_delta)

    propagated_sigma = np.concatenate([q_disturbed.q, omega_k])

    return propagated_sigma

# computes the apriori's (4 - 6)
def compute_apriori(Y_i):

    # step 4: compute the a priori estimates from Y_i

    # iterative gradient descent to get quaternion mean
    quaternions = []

    for idx in range(12):
        q_idx = Quaternion(scalar = Y_i[0, idx], vec = Y_i[1:4, idx])
        quaternions.append(q_idx)

    q_bar, latest_error = helpful_utils.quaternion_mean(quaternions)

    # get barycentric mean of angular velocities
    Y_i_omega = Y_i[4:7, :] # get omega values
    omega_mean = np.mean(Y_i_omega, axis = 1) # \bar{omega}

    x_hat_prior = np.concatenate([q_bar.q, omega_mean])

    # step 5: get W_prime_i
    W_prime_i = np.zeros(shape = (6, 12))
    r_W_prime = latest_error

    for propagated_sigma_idx in range(12):
        propagated_sigma = Y_i[:, propagated_sigma_idx]
        propagated_sigma_q, propagated_sigma_omega = helpful_utils.split_state_into_q_and_omega(propagated_sigma)

        omega_W_prime = propagated_sigma_omega - omega_mean

        W_prime_i[:, propagated_sigma_idx] = np.concatenate([r_W_prime[propagated_sigma_idx], omega_W_prime])

    # step 6: compute a priori covariance
    P_prior_k = np.matmul(W_prime_i, W_prime_i.T) / (12)

    return x_hat_prior, P_prior_k, W_prime_i

# propage and update for next timestep
def propagate_forward(Y_i, W_prime_i, accel_i, gyro_i, R):

    Z_i = np.zeros(shape = (6, 12))

    # step 7: apply measurements
    for sigma_idx in range(12):
        sigma_point = Y_i[:, sigma_idx]
        z_rot, z_accel = measurement_model(sigma_point)

        Z_i[:, sigma_idx] = np.concatenate([z_rot, z_accel])

    # step 8: calculate innovation
    z_k_mean = np.mean(Z_i, axis = 1)
    v_k = np.concatenate([gyro_i, accel_i]) - z_k_mean

    # step 9: innovation covariance
    P_zz = np.cov(Z_i)
    P_vv = P_zz + R

    # step 10: compute cross correlation P_xz
    rel_Z = Z_i - z_k_mean[:, np.newaxis]
    P_xz = np.matmul(W_prime_i, rel_Z.T) / 12

    return v_k, P_vv, P_xz

def measurement_model(x_k):
    q_k, omega_k = helpful_utils.split_state_into_q_and_omega(x_k)

    z_rot = omega_k # H1
    g = [0, 0, 9.81]
    
    q_g = Quaternion(scalar = 0, vec = g)

    g_prime_0 = q_k.__mul__(q_g)
    g_prime = g_prime_0.__mul__(q_k.inv())

    z_accel = g_prime
    return z_rot, z_accel.vec()

def update(current_mean_state, current_cov, v_k, P_xz, P_vv):
    K_k = np.matmul(P_xz, np.linalg.inv(P_vv))
    correction = np.matmul(K_k, v_k.T)

    q_mean, omega_mean = helpful_utils.split_state_into_q_and_omega(current_mean_state)
    q_correction = Quaternion()

    q_correction.from_axis_angle(correction[:3])

    updated_q = q_mean.q + q_correction.q
    q = Quaternion(scalar = updated_q[0], vec = updated_q[1:])
    q.normalize()

    updated_omega = omega_mean + correction[3:]

    x_hat = np.concatenate([q.q, updated_omega])

    cov_correction = np.matmul(K_k, P_vv)
    cov_correction2 = np.matmul(cov_correction, K_k.T)

    P_k = current_cov - cov_correction2

    return x_hat, P_k

#################################
# For Testing Purposes 
#################################
def test_function():
    test_state = np.array([1, 0, 0, 0, .5, .3, .2])
    test_state_2 = np.array([.5, .5, .5, .5, .1, .3, .7])
    data = np.vstack((test_state, test_state_2))
    Q_q = np.diag([0.0001, 0.0001, 0.0001])
    Q_omega = np.diag([0.01, 0.01, 0.01])
    R = np.diag([0.01, 0.01, 0.01, .001, .001, .001])
    g = np.array([0, 0, -9.81])
    Z_i_sensor = np.random.rand(1, 6)

    L = np.random.rand(6, 6)
    A = L @ L.T


    Q = np.block([[Q_q, np.zeros((3, 3))], [np.zeros((3, 3)), Q_omega]])

    L = np.random.rand(6, 6)
        
    # test steps for functionality
    # W_i = generate_sigma_points(test_state, A, Q)

    # print(f"W_i: {W_i}\nShape: {W_i.shape}")

    Y_i = generate_sigma_points(test_state, A, .01, Q)
    x_hat_prior, P_prior_k, W_prime_i = compute_apriori(Y_i)
    v_k, P_vv, P_xz = propagate_forward(Y_i, W_prime_i, Z_i_sensor[3:], Z_i_sensor[:3], R)
    x_hat, P_k = update(test_state_2, Q, v_k, P_xz, P_vv)

    print(f"x_hat: {x_hat}\nShape: {x_hat.shape}")
    print(f"P_k: {P_k}\nShape: {P_k.shape}")
    # print(f"v_k: {v_k}\nShape: {v_k.shape}")
    # print(f"P_vv: {P_vv}\nShape: {P_vv.shape}")
    # print(f"P_xz: {P_xz}\nShape: {P_xz.shape}")
    # print(f"x_hat_prior: {x_hat_prior}\nShape: {x_hat_prior.shape}")
    # print(f"P_prior_k: {P_prior_k}\nShape: {P_prior_k.shape}")


# test_function()
    

