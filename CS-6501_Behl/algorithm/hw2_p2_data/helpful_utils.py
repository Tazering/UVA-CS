import numpy as np
import pandas as pd
import math

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