import numpy as np
import pandas as pd
import math

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
    g = 9.81
    phi = math.asin(ay/g)
    theta = math.atan(ax/az)

    return phi, theta

# converts a single value to 
def convert_raw_to_value(raw, alpha, beta):
    value = (raw - beta) * (3300 / (1023 * alpha)) * 9.81

    return value

# get rotation matrix
def get_rotation_matrix(rotation_matrices, idx):

    rotation_matrix = np.zeros(shape = (3, 3))

    for i in range(3):
        for j in range(3):
            rotation_matrix[i][j] = rotation_matrices[i][j][idx]

    return rotation_matrix