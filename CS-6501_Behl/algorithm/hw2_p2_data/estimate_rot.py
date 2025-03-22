import numpy as np
from scipy import io
from scipy.interpolate import interp1d
from quaternion import Quaternion
import seaborn.objects as so
import pandas as pd
import matplotlib.pyplot as plt
import helpful_utils
import plotting_utils
from scipy.optimize import least_squares
from scipy.signal import savgol_filter


#data files are numbered on the server.
#for exmaple imuRaw1.mat, imuRaw2.mat and so on.
#write a function that takes in an input number (1 through 6)
#reads in the corresponding imu Data, and estimates
#roll pitch and yaw using an unscented kalman filter

def estimate_rot(data_num=1):
    #load data
    imu = io.loadmat('imu/imuRaw'+str(data_num)+'.mat')
    vicon = io.loadmat('vicon/viconRot'+str(data_num)+'.mat')

    # Ax, Ay, Az: accelerations along corresponding axes
    # Ax and Ay directions are flipped
    accel = imu['vals'][0:3,:] # observations by accelerometer

    # Wx, Wy, Wz = rotation rates about the corresponding axes
    # order of IMU is Wz, Wx, Wy
    gyro = imu['vals'][3:6,:] # observations by gyroscope
    T = np.shape(imu['ts'])[1] # total number of timesteps (in unix time)

    rotation_matrices = vicon['rots']
    T_vicon = vicon['ts']
    # your code goes here


    # b)
        # plot vicon
    vicon_plot, roll, pitch, yaw = plotting_utils.plot_vicon_data(rotation_matrices, T_vicon)
    # vicon_plot.show()
    calibrate_sensors(accel, gyro, imu['ts'], T_vicon[0], rotation_matrices)

    return None

    # roll, pitch, yaw are numpy arrays of length T
    # return roll,pitch,yaw

# b)
def calibrate_sensors(accel, gyro, imu_T, vicon_T, rotation_matrices):
    imu_timesteps = imu_T[0]
    # plot the data
    gyro_plot, Wx, Wy, Wz = plotting_utils.plot_gyroscope(gyro, imu_T)
    gyro_plot.show()
    
    Ax, Ay, Az, Wx, Wy, Wz = helpful_utils.parse_data(accel, gyro)

    accel_params = calibrate_accelerometer(Ax, Ay, Az)
    gyro_params = calibrate_gyroscope(rotation_matrices, Wx, Wy, Wz, vicon_T, imu_T[0])
    print(gyro_params)
        
    orientation_plot = plotting_utils.plot_orientations(Ax, Ay, Az, Wx, Wy, Wz, imu_T, vicon_T, accel_params, gyro_params)

    orientation_plot.show()

    plotting_utils.plot_angular_velocity(rotation_matrices, Wx, Wy, Wz, gyro_params, vicon_T, imu_T)
    return None

# use least-squares fitting for parameter estimation
def calibrate_accelerometer(Ax, Ay, Az):

    # initial setup

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

    # set values
    alpha_x = 342.184 
    beta_x = 510.807
    alpha_y = 239.438
    beta_y = 500.994
    alpha_z = 340.221
    beta_z = 499.69

    return np.array([alpha_x, beta_x, alpha_y, beta_y, alpha_z, beta_z])

def calibrate_gyroscope(rotation_matrices, Wx, Wy, Wz, vicon_T, imu_T):
    dt = np.diff(vicon_T)

    beta_x = np.mean(Wx[:700])
    beta_y = np.mean(Wy[:700])
    beta_z = np.mean(Wz[:700])

    true_W = np.zeros((3, rotation_matrices.shape[2]-1))

    prev_quat = None
    
    for timestep in range(1, rotation_matrices.shape[2]):
        prev_quat = Quaternion()
        prev_quat.from_rotm(rotation_matrices[:, :, timestep - 1])

        true_W[:, timestep-1] = helpful_utils.convert_rotation_matrix_to_angular_velocity(rotation_matrices[:, :, timestep], dt[timestep-1], prev_quat)


    true_W[0] = savgol_filter(true_W[0], window_length=21, polyorder=3)
    true_W[1] = savgol_filter(true_W[1], window_length=21, polyorder=3)
    true_W[2] = savgol_filter(true_W[2], window_length=21, polyorder=3)

    interpolated_wx = helpful_utils.interpolate_ground_truth(true_x = vicon_T[:-1], true_y = true_W[0], pred_x = imu_T)
    interpolated_wy = helpful_utils.interpolate_ground_truth(true_x = vicon_T[:-1], true_y = true_W[1], pred_x = imu_T)
    interpolated_wz = helpful_utils.interpolate_ground_truth(true_x = vicon_T[:-1], true_y = true_W[2], pred_x = imu_T)



    # plt.plot(interpolated_wx, color = "red", label = "True_Wx")
    # plt.plot(interpolated_wy, color = "blue", label = "True_Wy")
    # plt.plot(interpolated_wz, color = "green", label = "True_Wz")

    # plt.legend()
    # plt.show()

    # print(f"\ninterpol_wx: {interpol_wx}\n")

    # idx_timesteps = np.arange(len(interpol_wx) + 1)

    # print(idx_timesteps)

    # plt.plot(true_W[0], label = "wx")
    # # plt.plot(idx_timesteps, interpol_wy, label = "wy")
    # # plt.plot(idx_timesteps, interpol_wz, label = "wz")
    # plt.legend()
    # plt.show()
    


    alpha_params = least_squares(error_function, [100, 100, 100], args = ([Wx, Wy, Wz], [interpolated_wx, interpolated_wy, interpolated_wz], [beta_x, beta_y, beta_z]))

    # print(alpha_params)

    return [alpha_params["x"][0], beta_x, alpha_params["x"][1], beta_y, alpha_params["x"][2], beta_z]


def error_function(params, pred_W, true_W, betas):
    beta_x, beta_y, beta_z = betas
    alpha_x, alpha_y, alpha_z = params

    pred_Ax, pred_Ay, pred_Az = pred_W
    true_Ax, true_Ay, true_Az = true_W

    ax = helpful_utils.convert_raw_to_value(pred_Ax, alpha_x, beta_x, is_gyro=True)
    ay = helpful_utils.convert_raw_to_value(pred_Ay, alpha_y, beta_y, is_gyro=True)
    az = helpful_utils.convert_raw_to_value(pred_Az, alpha_z, beta_z, is_gyro=True)

    error_x = np.average(np.power(ax - true_Ax, 2))
    error_y = np.average(np.power(ay - true_Ay, 2))
    error_z = np.average(np.power(az - true_Az, 2))

    return error_x + error_y + error_z



# def magnitude_residual(params, Ax, Ay, Az, beta_x, beta_y):

#     alpha_x, alpha_y, alpha_z, beta_z = params
#     num_timesteps = len(Ax)
#     magnitudes = []

#     for timestep in range(num_timesteps):
#         ax = helpful_utils.convert_raw_to_value(Ax[timestep], alpha_x, beta_x)
#         ay = helpful_utils.convert_raw_to_value(Ay[timestep], alpha_y, beta_y)
#         magnitudes.append(np.sqrt(ax**2 + ay**2 + 9.81**2))

#     avg_mag = (np.array(magnitudes) - 9.81) ** 2
#     error = np.sum(avg_mag)

#     return error



        # r = rotation_matrices[:, :, timestep]
        # r_next = rotation_matrices[:, :, timestep + 1]

        # relative_r = np.matmul(r.T, r_next)

        # dr = (r_next - r) / dt[timestep]

        # skew_symmetric = np.matmul(r.T, dr)

        # true_W[0, timestep] = skew_symmetric[2, 1]
        # true_W[1, timestep] = skew_symmetric[0, 2]
        # true_W[2, timestep] = skew_symmetric[1, 0]

        # relative_r = np.matmul(r.T, r_next)

        # rot = Rotation.from_matrix(relative_r)
        # axis_angle = rot.as_rotvec()

        # # drdt = (r_next - r) / dt[timestep]

        # # skew_symmetric_matrix = np.matmul(r.T, drdt)


# call the function
estimate_rot()