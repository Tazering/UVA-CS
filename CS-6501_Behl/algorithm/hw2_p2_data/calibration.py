import numpy as np
import helpful_utils
from quaternion import Quaternion
# import plotting_utils
from scipy.optimize import least_squares
import math

# b)
def calibrate_sensors(accel, gyro, imu_T, vicon_T = None, rotation_matrices = None):
    Ax, Ay, Az, Wx, Wy, Wz = helpful_utils.parse_data(accel, gyro)

    accel_params = [342.184, 510.807, 239.438, 500.994, 340.221, 499.69]
    gyro_params = calibrate_gyroscope(rotation_matrices, Wx, Wy, Wz, vicon_T, imu_T)
    print(gyro_params)
    # gyro_params = [3.11a  960820636599356, 373.57142857142856, 2.9294486896322045, 375.37285714285713, 7.9143836834327805, 369.6857142857143]

    # plotting_utils.plot_angular_velocity(rotation_matrices, Wx, Wy, Wz, gyro_params, vicon_T, imu_T)

    return accel_params, gyro_params

# use least-squares fitting for parameter estimation
"""def calibrate_accelerometer(Ax, Ay, Az, use_found_values = False):

    if use_found_values:
        # set values
        alpha_x = 342.184 
        beta_x = 510.807
        alpha_y = 239.438
        beta_y = 500.994
        alpha_z = 340.221
        beta_z = 499.69
    else:

        # 1. Calibrate bias of ax and ay using stationary period (:700)
        beta_x = np.mean(Ax[:700])
        beta_y = np.mean(Ay[:700])
        beta_z = np.mean(Az[1900:2000]) # where the x-axis = g

        # 2. Compute the sensitivities
        average_z = np.mean(Az[:700])
        alpha_z = (average_z - beta_z) * (3300/1023)
        
        average_y = np.mean(Ay[3700:4100])
        alpha_y = (average_y - beta_y) * (3300/1023)

        average_x = np.mean(Ax[1900:2000])
        alpha_x = -((average_x - beta_x) * (3300/1023))


    return np.array([alpha_x, beta_x, alpha_y, beta_y, alpha_z, beta_z])
"""

def calibrate_gyroscope(rotation_matrices, Wx, Wy, Wz, vicon_T, imu_T, use_found_values = False):

    if use_found_values:
        alpha_x = 290.9503
        beta_x = 373.57142857142856
        alpha_y = 181.52
        beta_y = 375.37285714285713
        alpha_z = 176.704
        beta_z = 369.6857142857143
    else:

        beta_x = np.mean(Wx[:700])
        beta_y = np.mean(Wy[:700])
        beta_z = np.mean(Wz[:700])

        true_wx, true_wy, true_wz = helpful_utils.get_interpolated_angular_velocities(rotation_matrices, vicon_T, imu_T)

        # alpha_params = least_squares(error_function, [.133, .133, .133], args = ([Wx, Wy, Wz], [interpolated_wx, interpolated_wy, interpolated_wz], [beta_x, beta_y, beta_z]))

        # alpha_x = alpha_params["x"][0]
        # alpha_y = alpha_params["x"][1]
        # alpha_z = alpha_params["x"][2]

        alpha_x, alpha_y, alpha_z = get_sensitivity_with_closed_form_solution(true_w = [true_wx, true_wy, true_wz],
                                                                              pred_w = [Wx, Wy, Wz], betas = [beta_x, beta_y, beta_z])

    return [alpha_x, beta_x, alpha_y, beta_y, alpha_z, beta_z]


# def error_function(params, pred_W, true_W, betas):
#     alpha_x, alpha_y, alpha_z = params
#     beta_x, beta_y, beta_z = betas

#     pred_wx, pred_wy, pred_wz = pred_W
#     true_wx, true_wy, true_wz = true_W

#     wx = helpful_utils.convert_raw_to_value(pred_wx, alpha_x, beta_x, is_gyro=True)
#     wy = helpful_utils.convert_raw_to_value(pred_wy, alpha_y, beta_y, is_gyro=True)
#     wz = helpful_utils.convert_raw_to_value(pred_wz, alpha_z, beta_z, is_gyro=True)

#     error_x = wx - true_wx
#     error_y = wy - true_wy
#     error_z = wz - true_wz

#     return np.concatenate([error_x, error_y, error_z])

def get_sensitivity_with_closed_form_solution(true_w, pred_w, betas):
    true_wx, true_wy, true_wz = true_w
    pred_wx, pred_wy, pred_wz = pred_w
    beta_x, beta_y, beta_z = betas

    scale_x = (pred_wx - beta_x) * ((3300 * math.pi) / (1023 * 180))
    scale_y = (pred_wy - beta_y) * ((3300 * math.pi) / (1023 * 180))
    scale_z = (pred_wz - beta_z) * ((3300 * math.pi) / (1023 * 180))

    alpha_x = 1 / (np.sum(scale_x * true_wx) / np.sum(scale_x * scale_x))
    alpha_y = 1 / (np.sum(scale_y * true_wy) / np.sum(scale_y * scale_y))
    alpha_z = 1 / (np.sum(scale_z * true_wz) / np.sum(scale_z * scale_z))

    return alpha_x, alpha_y, alpha_z



# def calculate_R_covariance(ax, ay, az, wx, wy, wz, stationary_period = 700): # measurement covariance

#     R_omega = np.var(np.array([wx[:stationary_period], wy[:stationary_period], wz[:stationary_period]]), axis = 1, ddof = 1)
#     R_a = np.var(np.array([ax[:stationary_period], ay[:stationary_period], az[:stationary_period]]), axis = 1, ddof = 1)

#     R = np.diag(np.concatenate([R_omega, R_a]))
#     return R

# def calculate_Q_covariance(wx, wy, wz, imu_T, stationary_period = 700):

#     avg_diff = np.mean(np.gradient(imu_T))

#     wx_var = np.var(wx[:stationary_period])
#     wy_var = np.var(wy[:stationary_period])
#     wz_var = np.var(wz[:stationary_period])

#     Q_omega = np.array([wx_var, wy_var, wz_var])

#     Q_q = Q_omega * avg_diff / 4

#     Q = np.diag(np.concatenate((Q_q, Q_omega)))

#     return Q

# def calculate_P_covariance(wx, wy, wz, stationary_period = 700):
#     P_omega = np.var(np.array([wx, wy, wz]), axis = 1, ddof = 1)

#     P_q = 1e-2 * np.ones(3)

#     P = np.diag(np.concatenate([P_q, P_omega]))

#     return P


def calculate_R_covariance(ax, ay, az, wx, wy, wz, stationary_period = 700): # measurement covariance

    R_omega = np.var(np.array([wx[:stationary_period], wy[:stationary_period], wz[:stationary_period]]), axis = 1, ddof = 1) * .01
    R_a = np.var(np.array([ax[:stationary_period], ay[:stationary_period], az[:stationary_period] + 9.81]), axis = 1, ddof = 1) * 10

    R = np.diag(np.concatenate([R_omega, R_a]))
    return R

def calculate_Q_covariance(wx, wy, wz, imu_T, stationary_period = 700):

    avg_diff = np.mean(np.gradient(imu_T))

    wx_var = np.var(wx[:stationary_period])
    wy_var = np.var(wy[:stationary_period])
    wz_var = np.var(wz[:stationary_period])

    Q_omega = np.array([wx_var, wy_var, wz_var]) * 10

    Q_q = Q_omega * avg_diff / 2

    Q = np.diag(np.concatenate((Q_q, Q_omega)))

    return Q

def calculate_P_covariance(wx, wy, wz, stationary_period = 700):
    P_omega = np.var(np.array([wx, wy, wz]), axis = 1, ddof = 1)

    P_q = 1e-1 * np.ones(3)

    P = np.diag(np.concatenate([P_q, P_omega]))

    return P


def calculate_R_covariance2(ax, ay, az, wx, wy, wz, stationary_period = 700): # measurement covariance

    R_omega = np.var([wx[:stationary_period], wy[:stationary_period], wz[:stationary_period]], axis = 1)
    R_a = np.var([wx[:stationary_period], wy[:stationary_period], wz[:stationary_period] + 9.81], axis = 1)
    return np.diag(np.concatenate([R_omega, R_a]))
    # stationary_data = np.array([wx[:stationary_period], wy[:stationary_period], wz[:stationary_period], ax[:stationary_period], ay[:stationary_period], az[:stationary_period]])

    # covariances = np.cov(stationary_data, rowvar = True)
    # diagonal_values = np.diag(covariances)

    # R = np.diag(diagonal_values)

    return R

def calculate_Q_covariance2(wx, wy, wz, stationary_period = 700):

    gyro_var = np.var([wx[:stationary_period], wy[:stationary_period], wz[:stationary_period]], axis = 1)
    Q_q = gyro_var * .001
    Q_omega = gyro_var

    return np.diag(np.concatenate([Q_q, Q_omega]))