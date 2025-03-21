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

# get roll and pitch
def get_roll_and_pitch_from_acceleration(ax, ay, az):

    phi = np.arctan2(-ay, -az)
    theta = math.asin(ax, 9.81)
    # phi = np.arcsin(ay, 9.81)  # Roll
    # theta = np.arctan2(ay/ az)

    return phi, theta

# converts a single value to 
def convert_raw_to_value(raw, alpha, beta, is_gyro = False):
    K = (3300) / (1023)

    if is_gyro:
        K = (3300 * math.pi) / (1023 * 180)

    value = (raw - beta) * (K / alpha)    

    return value

def convert_rotation_matrix_to_euler(rotation_matrix):
    alpha = math.atan2(rotation_matrix[1][0], rotation_matrix[0][0])
    beta = math.atan2(-rotation_matrix[2][0], math.sqrt(rotation_matrix[2][1]**2 + rotation_matrix[2][2]**2))
    gamma = math.atan2(rotation_matrix[2][1], rotation_matrix[2][2])

    return gamma, beta, alpha

def get_average_sensitivity_from_datapoints(dynamic_period = [2000, 4100], num_of_samples = 3, beta = 512, roll = [], pitch = [], yaw = []):
    sum = 0

    for i in range(num_of_samples):
        random_idx = np.random.choice(np.arange(dynamic_period[0], dynamic_period[1]))
        a += -9.81 * np.sin()
