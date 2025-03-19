import numpy as np
import pandas as pd
import math
from scipy import interpolate

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

# interpolate values
def interpolate_rotations(rotation_matrices, vicon_T, imu_T):
    interpolate_func = interpolate.interp1d(vicon_T, rotation_matrices, axis = 2, fill_value='extrapolate', kind = "nearest")
    return interpolate_func(imu_T)

# get roll and pitch
def get_roll_and_pitch_from_acceleration(ax, ay, az):
    g = 9.81

    phi = math.asin(np.clip(ay/g, -1, 1))
    theta = math.atan(ax/az)
    # phi = np.arcsin(ay, az)  # Roll
    # theta = np.arctan2(-ax, np.sqrt(ay**2 + az**2))

    return phi, theta

# converts a single value to 
def convert_raw_to_value(raw, alpha, beta):
    K = (3300 * 9.81) / (1023)
    value = (raw - beta) * K / alpha

    return value

def convert_rotation_matrix_to_euler(rotation_matrix):
    alpha = math.atan2(rotation_matrix[1][0], rotation_matrix[0][0])
    beta = math.atan2(-rotation_matrix[2][0], math.sqrt(rotation_matrix[2][1]**2 + rotation_matrix[2][2]**2))
    gamma = math.atan2(rotation_matrix[2][1], rotation_matrix[2][2])

    return gamma, beta, alpha

# get rotation matrix
# def get_rotation_matrix(rotation_matrices, idx):

#     rotation_matrix = np.zeros(shape = (3, 3))

#     for i in range(3):
#         for j in range(3):
#             rotation_matrix[i][j] = rotation_matrices[i][j][idx]

#     return rotation_matrix