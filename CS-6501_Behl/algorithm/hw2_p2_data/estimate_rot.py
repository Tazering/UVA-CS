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

    # print(f"accel:\n{accel}\ngyro:\n{gyro}")

    rotation_matrices = vicon['rots']
    T_vicon = vicon['ts']

    # your code goes here

    # b)
    calibrate_sensors(accel, gyro, imu['ts'], rotation_matrices, T_vicon)

    return None

    # roll, pitch, yaw are numpy arrays of length T
    # return roll,pitch,yaw

# b)
def calibrate_sensors(accel, gyro, imu_T, rotation_matrices, vicon_T):
    # plot the data
    vicon_plot, roll, pitch, yaw = plotting_utils.plot_vicon_data(rotation_matrices = rotation_matrices, T = vicon_T)
    # gyro_plot, Wx, Wy, Wz = plotting_utils.plot_gyroscope(gyro, imu_T)

    Ax, Ay, Az, Wx, Wy, Wz = helpful_utils.parse_data(accel, gyro)



    # calibrate the sensors
    best_params = calibrate_accelerometer(Ax, Ay, Az)

    accel_plot = plotting_utils.plot_accelerometer(Ax, Ay, Az, imu_T, plot_type = "rotation", conversion_param = best_params)

    # print(best_params)

    accel_plot.show()
    return None

# use least-squares fitting for parameter estimation
def calibrate_accelerometer(Ax, Ay, Az):
    # run least squares
    results = least_squares(net_force_error, [1, 1, 1, 1, 1, 1], args = (Ax, Ay, Az))

    best_params = results["x"]
    return best_params

def calibrate_gyroscope():
    return None

# helper functions
def net_force_error(parameters, ax, ay, az): # these are the raw ax, ay, and az
    
    alpha_x, beta_x, alpha_y, beta_y, alpha_z, beta_z = parameters

    g = 9.81

    ax_transformed = helpful_utils.convert_raw_to_value(ax, alpha = alpha_x, beta = beta_x)
    ay_transformed = helpful_utils.convert_raw_to_value(ay, alpha = alpha_y, beta = beta_y)
    az_transformed = helpful_utils.convert_raw_to_value(az, alpha = alpha_z, beta = beta_z)

    # get the magnitudes
    magnitudes = np.sqrt(np.power(ax_transformed, 2) + np.power(ay_transformed, 2) + np.power(az_transformed, 2))
    
    return sum(np.power(magnitudes - 9.81, 2))

# call the function
estimate_rot()