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


def convert_rotation_matrix_to_angular_velocity(rotation_matrices, vicon_T):
    T = rotation_matrices.shape[2]
    dt = np.gradient(vicon_T)

    angular_velocities = np.zeros((3, T-1))

    for t in range(T - 1):
        R_t = rotation_matrices[:, :, t]
        R_t_next = rotation_matrices[:, :, t + 1]

        R_relative = np.matmul(R_t.T, R_t_next)
        
        quaternion = Quaternion()
        quaternion.from_rotm(R_relative)
        axis_angle = quaternion.axis_angle()
        angular_velocities[:, t] = axis_angle / dt[t]
    
    return angular_velocities, vicon_T[:-1]

# interpolate data
def interpolate_ground_truth(true_x, true_y, pred_x):
    interp = interp1d(true_x, true_y, kind = "nearest", bounds_error = False, fill_value = "extrapolate")
    return interp(pred_x)
    
# helper function
def quaternion_mean(quaternions, threshold = 1e-4, max_iter = 50):
    # step 1: initial guess
    q_bar = Quaternion(scalar = quaternions[0].scalar(), vec = quaternions[0].vec())

    for _ in range(max_iter): # loop through iterations
        errors = []
        # step 2: get e_i for each quaternion
        for q_i in quaternions: 
            e_i = q_i.__mul__(q_bar.inv()) # 50
            theta = 2 * np.arccos(np.clip(e_i.scalar(), -1, 1))
            
            # step 3: convert e_i into axis angle
            if abs(theta) < 1e-10:
                e_i_axis_angle = np.zeros(3)
            else:
                e_i_axis_angle = e_i.vec() / np.linalg.norm(e_i.vec()) * theta

            errors.append(e_i_axis_angle)

        # step 4: barycentric mean of errors 
        e_bar = np.mean(errors, axis = 0)
        theta = np.linalg.norm(e_bar)

        if theta < threshold:
            break
        
        # step 5: update
        e = Quaternion(scalar = np.cos(theta / 2), vec = e_bar/theta * np.sin(theta/2))
        e.from_axis_angle(e_bar)
        q_bar = e.__mul__(q_bar)
    
    return q_bar

def split_state_into_q_and_omega(x):
    return Quaternion(scalar = x[0], vec = x[1:4]), np.array(x[4:7])
# def convert_rotation_matrix_to_euler(rotation_matrix):
#     alpha = math.atan2(rotation_matrix[1][0], rotation_matrix[0][0])
#     beta = math.atan2(-rotation_matrix[2][0], math.sqrt(rotation_matrix[2][1]**2 + rotation_matrix[2][2]**2))
#     gamma = math.atan2(rotation_matrix[2][1], rotation_matrix[2][2])

#     return gamma, beta, alpha

