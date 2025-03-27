import numpy as np
import pandas as pd
import math
from scipy.interpolate import interp1d
from quaternion import Quaternion
from scipy.signal import savgol_filter

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

# get the angular velocities from the estimated states
def get_estimated_angular_velocities_from_states(ukf_states, rotation_matrices, vicon_T, imu_T):

    N = ukf_states.shape[0]

    ukf_wx = []
    ukf_wy = []
    ukf_wz = []

    # interpolated_matrices = interpolate_ground_truth(true_x = vicon_T, true_y = rotation_matrices, pred_x = imu_T)
    # angular_velocities, timesteps = convert_rotation_matrix_to_angular_velocity(interpolated_matrices, imu_T)

    # true_wx = angular_velocities[0]
    # true_wy = angular_velocities[1]
    # true_wz = angular_velocities[2]

    true_wx, true_wy, true_wz = get_interpolated_angular_velocities(rotation_matrices, vicon_T, imu_T)


    for idx in range(N): # loop through timesteps
        
        # get values from states
        state = ukf_states[idx]
        
        ukf_wx.append(state[4])
        ukf_wy.append(state[5])
        ukf_wz.append(state[6])

    return np.array(ukf_wx), np.array(ukf_wy), np.array(ukf_wz), true_wx, true_wy, true_wz


def convert_rotation_matrix_to_angular_velocity(rotation_matrices, vicon_T):
    T = rotation_matrices.shape[2]

    angular_velocities = np.zeros(shape = (3, T))
    dt = np.gradient(vicon_T)
    dr = np.gradient(rotation_matrices, axis = 2) / dt

    for i in range(T):
        skew_symmetric = np.matmul(dr[:, :, i], rotation_matrices[:, :, i].T)
        angular_velocities[:, i] = np.array([skew_symmetric[2, 1], skew_symmetric[0, 2], skew_symmetric[1, 0]])
    
    return angular_velocities, vicon_T


# interpolate data
def interpolate_ground_truth(true_x, true_y, pred_x):
    interp = interp1d(true_x, true_y, kind = "nearest", bounds_error = False, fill_value = "extrapolate")
    return interp(pred_x)


# get interpolated angular velocities
def get_interpolated_angular_velocities(rotation_matrices, vicon_T, imu_T):

    interpolated_matrices = interpolate_ground_truth(true_x = vicon_T, true_y = rotation_matrices, pred_x = imu_T)
    angular_velocities, timesteps = convert_rotation_matrix_to_angular_velocity(interpolated_matrices, imu_T)

    return angular_velocities

    
def quaternion_mean(quaternions, threshold = 1e-4, max_iter = 40):
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
        latest_errors = errors
        e_bar = np.mean(errors, axis = 0)
        theta = np.linalg.norm(e_bar)

        if theta < threshold:
            break
        
        e.from_axis_angle(e_bar)
        q_bar = e.__mul__(q_bar)
        
    return q_bar, latest_errors
    # return Quaternion()

def get_euler_angles_from_states(states):
    m, n = states.shape

    euler_angles = np.zeros(shape = (3, m))

    for idx in range(m):

        state = states[idx, :]

        q, omega = split_state_into_q_and_omega(state)
        euler_angles[:, idx] = q.euler_angles()

    return euler_angles

def split_state_into_q_and_omega(x):
    return Quaternion(scalar = x[0], vec = x[1:4]), np.array(x[4:7])

def convert_rotation_matrices_to_euler_angles(rotation_matrices):
    q = Quaternion()
    m = rotation_matrices.shape[2]

    roll = []
    pitch = []
    yaw = []

    for idx in range(m):
        rotation_matrix = rotation_matrices[:, :, idx]
        q.from_rotm(rotation_matrix)
        euler_angles = q.euler_angles()

        roll.append(euler_angles[0])
        pitch.append(euler_angles[1])
        yaw.append(euler_angles[2])

    return np.array([roll, pitch, yaw])