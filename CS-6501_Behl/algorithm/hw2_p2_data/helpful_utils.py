import numpy as np
import pandas as pd
import math
from scipy.interpolate import interp1d
from quaternion import Quaternion

# parses the accelerometer and gyroscope data
def parse_data(accel, gyro):

    T = accel.shape[1]

    Ax = []
    Ay = []
    Az = []
    Wx = []
    Wy = []
    Wz = []

    for timestep in range(T): # get all the linear accelerations

        ax = accel[0][timestep]
        ay = accel[1][timestep]
        az = accel[2][timestep]

        Ax.append(ax) 
        Ay.append(ay)
        Az.append(az)

        Wx.append(gyro[1][timestep])
        Wy.append(gyro[2][timestep])
        Wz.append(gyro[0][timestep])

    return np.array(Ax), np.array(Ay), np.array(Az), np.array(Wx), np.array(Wy), np.array(Wz)

# get roll and pitch
def get_roll_and_pitch_from_acceleration(ax, ay, az):

    # phi = np.arctan2(-ay, -az)
    # theta = math.asin(ax / 9.81)
    phi = np.arctan2(ay, az)  # Roll
    theta = np.arctan2(ax, np.sqrt(ay**2 + az**2))

    return phi, theta

# converts a single value to 
def convert_raw_to_value(raw, alpha, beta, is_gyro = False):
    K = (3300) / (1023)

    if is_gyro:
        K = (3300 * math.pi) / (1023 * 180)

    value = (raw - beta) * (K / alpha)    

    return value

# converts a rotation matrix to angular velocity
def convert_rotation_matrix_to_angular_velocity(rotation_matrix, delta_t, prev_quaternion = None):
    quaternion = Quaternion()
    quaternion.from_rotm(rotation_matrix) # convert to quaternion
    MIN_DELTA_T = 1e-6
    delta_t = max(delta_t, MIN_DELTA_T)


    if prev_quaternion is not None:
        prev_axis_angle = prev_quaternion.axis_angle()
        axis_angle = quaternion.axis_angle()

        delta_axis_angle = axis_angle - prev_axis_angle

        angular_rate = delta_axis_angle / delta_t
    else:
        axis_angle = quaternion.axis_angle()
        angular_rate = axis_angle / delta_t


    return angular_rate

# interpolate data
def interpolate_ground_truth(true_x, true_y, pred_x):
    interp = interp1d(true_x, true_y, kind = "nearest", bounds_error = False, fill_value = "extrapolate")
    return interp(pred_x)
    

# def convert_rotation_matrix_to_euler(rotation_matrix):
#     alpha = math.atan2(rotation_matrix[1][0], rotation_matrix[0][0])
#     beta = math.atan2(-rotation_matrix[2][0], math.sqrt(rotation_matrix[2][1]**2 + rotation_matrix[2][2]**2))
#     gamma = math.atan2(rotation_matrix[2][1], rotation_matrix[2][2])

#     return gamma, beta, alpha

