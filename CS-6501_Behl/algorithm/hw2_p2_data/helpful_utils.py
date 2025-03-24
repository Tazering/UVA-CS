import numpy as np
import pandas as pd
import math
from scipy.interpolate import interp1d
from quaternion import Quaternion
from scipy.signal import savgol_filter
from scipy.spatial.transform import Slerp

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


# def convert_rotation_matrix_to_angular_velocity(rotation_matrices, vicon_T):
#     T = rotation_matrices.shape[2]
#     dt = np.gradient(vicon_T)
#     dr = np.gradient(rotation_matrices, axis = 2) / np.gradient(vicon_T)

#     angular_velocities = np.zeros((3, T-1))

#     for t in range(T-1):
#         R_t = rotation_matrices[:, :, t]
#         R_t_next = rotation_matrices[:, :, t + 1]

#         R_relative = np.matmul(R_t.T, R_t_next)
        
#         quaternion = Quaternion()
#         quaternion.from_rotm(R_relative)
#         axis_angle = quaternion.axis_angle()
#         angular_velocities[:, t] = axis_angle / dt[t]
#         # angular_velocities[:, t] = np.array([R_relative[1, 2], R_relative[0, 2], R_relative[0, 1]])
    
#     # window = 51
#     # angular_velocities = savgol_filter(angular_velocities, window_length=window, polyorder=2, axis=1)

#     return angular_velocities, vicon_T[:-1]

def convert_rotation_matrix_to_angular_velocity(rotation_matrices, vicon_T):
    T = rotation_matrices.shape[2]

    angular_velocities = np.zeros(shape = (3, T-1))
    dt = np.gradient(vicon_T)
    dr = np.gradient(rotation_matrices, axis = 2) / dt

    for i in range(T-1):
        skew_symmetric = np.matmul(dr[:, :, i], rotation_matrices[:, :, i].T)
        angular_velocities[:, i] = np.array([skew_symmetric[2, 1], skew_symmetric[0, 2], skew_symmetric[1, 0]])
    
    return angular_velocities, vicon_T[:-1]

# def convert_rotation_matrix_to_angular_velocity(R, ts):
#     T = ts.shape[0]
#     w = np.zeros((3, T))

#     def unskew(mat):
#         return np.array([mat[2, 1], mat[0, 2], mat[1, 0]])
    
#     for i in range(1, T - 1):
#         dt = ts[i + 1] - ts[i - 1]
#         dR = (R[:, :, i + 1] - R[:, :, i - 1]) / dt
#         w_skew = dR @ R[:, :, i].T
#         w[:, i] = unskew(w_skew)
    
#     dt0 = ts[1] - ts[0]
#     dR0 = (R[:, :, 1] - R[:, :, 0]/ dt0)
#     w_skew0 = dR0 @ R[:, :, 0].T
#     w[:, 0] = unskew(w_skew())

#     dt_last = ts[T - 1] - ts[T - 2]
#     dR_last = (R[:, :, T - 1] - R[:, :, T - 2]) / dt_last

#     w_skew_last = dR_last @ R[:, :, T-1].T
#     w[:, T - 1] = unskew(w_skew_last)

#     return w

# interpolate data
def interpolate_ground_truth(true_x, true_y, pred_x):
    interp = interp1d(true_x, true_y, kind = "nearest", bounds_error = False, fill_value = "extrapolate")
    return interp(pred_x)
    
def quaternion_mean(quaternions, threshold = 1e-4, max_iter = 50):
    # step 1: initial guess
    q_bar = Quaternion(scalar = quaternions[0].scalar(), vec = quaternions[0].vec())
    e = Quaternion()

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
                # e_i_axis_angle = e_i.vec() / np.linalg.norm(e_i.vec()) * theta
                e_i_axis_angle = e_i.axis_angle()

            errors.append(e_i_axis_angle)

        # step 4: barycentric mean of errors 
        e_bar = np.mean(errors, axis = 0)
        theta = np.linalg.norm(e_bar)

        if theta < threshold:
            break
        
        # step 5: update
        # e = Quaternion(scalar = np.cos(theta / 2), vec = e_bar/theta * np.sin(theta/2))
        # e.q = [np.cos(theta / 2), e_bar[0]/theta * np.sin(theta/2), e_bar[1]/theta * np.sin(theta/2), e_bar[2]/theta * np.sin(theta/2)]

        e.from_axis_angle(e_bar)
        q_bar = e.__mul__(q_bar)
    
    return q_bar
    # return Quaternion()

# def quaternion_mean(quaternions, threshold = 1e-4, max_iter = 50):
#     return Quaternion()

def get_euler_angles_from_states(states):
    m, n = states.shape
    quaternions = states[:, 0:4]
    quaternion = Quaternion()

    euler_angles = np.zeros(shape = (m, 3))

    for idx in range(m):
        quaternion.q = quaternions[idx]
        euler_angles[idx, :] = quaternion.euler_angles()

    return euler_angles[:, 0], euler_angles[:, 1], euler_angles[:, 2]

def split_state_into_q_and_omega(x):
    return Quaternion(scalar = x[0], vec = x[1:4]), np.array(x[4:7])

