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
    vicon_plot.show()
    calibrate_sensors(accel, gyro, imu['ts'], T_vicon[0], roll, pitch, yaw)

    return None

    # roll, pitch, yaw are numpy arrays of length T
    # return roll,pitch,yaw

# b)
def calibrate_sensors(accel, gyro, imu_T, vicon_T, roll, pitch, yaw):
    imu_timesteps = imu_T[0]
    # plot the data
    # vicon_plot, roll, pitch, yaw = plotting_utils.plot_vicon_data(rotation_matrices = rotation_matrices, T = vicon_T)
    gyro_plot, Wx, Wy, Wz = plotting_utils.plot_gyroscope(gyro, imu_T)
    gyro_plot.show()

    Ax, Ay, Az, Wx, Wy, Wz = helpful_utils.parse_data(accel, gyro)

    accel_params = calibrate_accelerometer(Ax, Ay, Az, roll, pitch, yaw)
    print(accel_params)
    calibrate_gyroscope(roll, pitch, yaw, Wx, Wy, Wz, vicon_T)
    set_times = np.arange(len(Ax))
        
    # accel_plot = plotting_utils.plot_accelerometer(Ax, Ay, Az, imu_T[0], conversion_param=best_param, transformed=True)
    orientation_plot = plotting_utils.plot_orientations(Ax, Ay, Az, set_times, accel_params)
    # looking at the graph, the drone seems to be in stationary state with linear or angular acceleration
    # Therefore, the bias, would simply be the sequence of numbers in the first part of graph

    # accel_plot.show()

    # print(best_params)

    orientation_plot.show()
    return None

# use least-squares fitting for parameter estimation
def calibrate_accelerometer(Ax, Ay, Az, roll, pitch, yaw):

    # initial setup

    # 1. Calibrate bias of ax and ay using stationary period (:700)
    beta_x = np.mean(Ax[:700])
    beta_y = np.mean(Ay[:700])
    beta_z = np.mean(Az[1900:2000]) # where the x-axis = g

    # print(beta_x, beta_y, beta_z)
    
    # 2. Compute the sensitivities
    average_z = np.mean(Az[:700])
    alpha_z = (average_z - beta_z) * (3300/1023)
    
    average_y = np.mean(Ay[3700:4100])
    alpha_y = (average_y - beta_y) * (3300/1023)

    average_x = np.mean(Ax[1900:2000])
    alpha_x = (average_x - beta_x) * (3300/1023)

    
    print(alpha_x, alpha_y, alpha_z)

    # best_params = least_squares(magnitude_residual, [100, 100, 100, beta_x], args = (Ax[:700], Ay[:700], Az[:700], beta_x, beta_y))
    # 2. Calibrate sensitivity of ax and ay using the dynamic portion of the data
    # sum_y = 0
    # for i in range(10):
    #     random_idx = np.random.choice(np.arange(1800, 4100)) # pick random point from dynamic portion
    #     ay = - 9.81 * np.sin(roll[random_idx])
    #     sensitivity_test_point = (3300 * (Ay[random_idx] - beta_y)) / (ay * 1023)
    #     sum_y += sensitivity_test_point

    # alpha_y = sum_y / 10
    # print(beta_x, beta_y, alpha_y)
   
    

    # # get the average of the stationary period of each linear acceleration
    # beta_x = np.average(Ax[:stationary_period])
    # beta_y = np.average(Ay[:stationary_period])
    # beta_z = np.average(Az[:stationary_period])

    # # run least squares
    # results = least_squares(net_force_error, [1, 1, 1], args = (Ax, Ay, Az, beta_x, beta_y, beta_z), bounds = (-np.inf, np.inf))

    # best_params = results["x"]
    # best_params = np.concatenate((best_params, np.array([beta_x, beta_y, beta_z])))

    return np.array([alpha_x, beta_x, alpha_y, beta_y, alpha_z, beta_z])

def calibrate_gyroscope(roll, pitch, yaw, Wx, Wy, Wz, vicon_T):

    d_wx = np.gradient(roll, 1)
    d_wy = np.gradient(pitch, 1)
    d_wz = np.gradient(yaw, 1)
    print(max(d_wx))
    plt.plot(np.arange(len(d_wx)), d_wx, label = "X")
    plt.plot(np.arange(len(d_wx)), d_wy, label = "Y")
    plt.plot(np.arange(len(d_wx)), d_wz, label = "Z")

    plt.legend()

    plt.show()


    return None



def magnitude_residual(params, Ax, Ay, Az, beta_x, beta_y):

    alpha_x, alpha_y, alpha_z, beta_z = params
    num_timesteps = len(Ax)
    magnitudes = []

    for timestep in range(num_timesteps):
        ax = helpful_utils.convert_raw_to_value(Ax[timestep], alpha_x, beta_x)
        ay = helpful_utils.convert_raw_to_value(Ay[timestep], alpha_y, beta_y)
        magnitudes.append(np.sqrt(ax**2 + ay**2 + 9.81**2))

    avg_mag = (np.array(magnitudes) - 9.81) ** 2
    error = np.sum(avg_mag)

    return error

def calibrate_z(params, Az, stationary_period = 700):
    alpha_z, beta_z = params

    num_timesteps = len(Az)

    az = helpful_utils.convert_raw_to_value(raw = az, alpha = alpha_z, beta = beta_z)

    mag = np.sqrt(az**2)
    error = np.sqrt((mag - 9.81)**2)






# call the function
estimate_rot()