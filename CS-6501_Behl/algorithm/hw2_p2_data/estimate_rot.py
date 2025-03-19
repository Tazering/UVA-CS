import numpy as np
from scipy import io
from quaternion import Quaternion
import seaborn.objects as so
import pandas as pd
import matplotlib.pyplot as plt
import helpful_utils
import plotting_utils
from scipy.optimize import least_squares

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
    calibrate_sensors(accel, gyro, imu['ts'], rotation_matrices, T_vicon[0])

    return None

    # roll, pitch, yaw are numpy arrays of length T
    # return roll,pitch,yaw

# b)
def calibrate_sensors(accel, gyro, imu_T, rotation_matrices, vicon_T):
    imu_timesteps = imu_T[0]
    # plot the data
    # vicon_plot, roll, pitch, yaw = plotting_utils.plot_vicon_data(rotation_matrices = rotation_matrices, T = vicon_T)
    gyro_plot, Wx, Wy, Wz = plotting_utils.plot_gyroscope(gyro, imu_T)
    gyro_plot.show()

    Ax, Ay, Az, Wx, Wy, Wz = helpful_utils.parse_data(accel, gyro)
    
    # calibrate the sensors at during stationary period
    best_param = calibrate_accelerometer(Ax, Ay, Az, rotation_matrices, vicon_T, imu_timesteps) 
    print(best_param)
        
    # accel_plot = plotting_utils.plot_accelerometer(Ax, Ay, Az, imu_T[0], conversion_param=best_param, transformed=True)
    orientation_plot = plotting_utils.plot_orientations(Ax, Ay, Az, imu_T[0], best_param)
    # looking at the graph, the drone seems to be in stationary state with linear or angular acceleration
    # Therefore, the bias, would simply be the sequence of numbers in the first part of graph

    # accel_plot.show()

    # print(best_params)

    orientation_plot.show()
    return None

# use least-squares fitting for parameter estimation
def calibrate_accelerometer(Ax, Ay, Az, rotation_matrices, vicon_timesteps, imu_timesteps):

    # initial setup
    vicon_interpolated = helpful_utils.interpolate_rotations(rotation_matrices = rotation_matrices, vicon_T = vicon_timesteps, imu_T = imu_timesteps)

    g_vector = np.array([0, 0, -9.81]) # gravity vector

    true_Ax = []
    true_Ay = []
    true_Az = []

    for timestep in range(len(imu_timesteps)):
        ground_truth = np.matmul(vicon_interpolated[:, :, timestep], g_vector.T)

        true_Ax.append(ground_truth[0])
        true_Ay.append(ground_truth[1])
        true_Az.append(ground_truth[2])
    
    true_Ax = np.array(true_Ax)
    true_Ay = np.array(true_Ay)
    true_Az = np.array(true_Az)

    beta_x = np.mean(Ax[:700])
    beta_y = np.mean(Ay[:700])
    beta_z = np.mean(Az[:700])
    
    best_param = least_squares(net_force_error, [1, 1, 1], args = (Ax[700:], Ay[700:], Az[700:], true_Ax[700:], true_Ay[700:], true_Az[700:], beta_x, beta_y, beta_z))

    # # get the average of the stationary period of each linear acceleration
    # beta_x = np.average(Ax[:stationary_period])
    # beta_y = np.average(Ay[:stationary_period])
    # beta_z = np.average(Az[:stationary_period])

    # # run least squares
    # results = least_squares(net_force_error, [1, 1, 1], args = (Ax, Ay, Az, beta_x, beta_y, beta_z), bounds = (-np.inf, np.inf))

    # best_params = results["x"]
    # best_params = np.concatenate((best_params, np.array([beta_x, beta_y, beta_z])))

    return np.concatenate((best_param["x"], [beta_x], [beta_y], [beta_z]))

def calibrate_gyroscope():
    
    return None

# helper functions
def net_force_error(parameters, Ax, Ay, Az, true_Ax, true_Ay, true_Az, beta_x, beta_y, beta_z): # these are the raw ax, ay, and az
    
    alpha_x, alpha_y, alpha_z = parameters

    convert_Ax = -helpful_utils.convert_raw_to_value(Ax, alpha_x, beta_x)
    convert_Ay = -helpful_utils.convert_raw_to_value(Ay, alpha_y, beta_y)
    convert_Az = helpful_utils.convert_raw_to_value(Az, alpha_z, beta_z)

    # error = np.concatenate([true_Ax - convert_Ax, true_Ay - convert_Ay, true_Az - convert_Az])
    mag = np.sqrt(convert_Ax**2 + convert_Ay**2 + convert_Az**2)
    avg_mag = np.mean(mag)
    error = np.sqrt((avg_mag - 9.81)**2)
    
    return error

# call the function
estimate_rot()