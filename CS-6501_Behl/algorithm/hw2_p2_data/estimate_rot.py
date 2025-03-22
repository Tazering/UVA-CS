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
    calibrate_sensors(accel, gyro, imu['ts'], T_vicon[0], roll, pitch, yaw, rotation_matrices)

    return None

    # roll, pitch, yaw are numpy arrays of length T
    # return roll,pitch,yaw

# b)
def calibrate_sensors(accel, gyro, imu_T, vicon_T, roll, pitch, yaw, rotation_matrices):
    imu_timesteps = imu_T[0]
    # plot the data
    # vicon_plot, roll, pitch, yaw = plotting_utils.plot_vicon_data(rotation_matrices = rotation_matrices, T = vicon_T)
    gyro_plot, Wx, Wy, Wz = plotting_utils.plot_gyroscope(gyro, imu_T)
    gyro_plot.show()

    Ax, Ay, Az, Wx, Wy, Wz = helpful_utils.parse_data(accel, gyro)

    accel_params = calibrate_accelerometer(Ax, Ay, Az, roll, pitch, yaw)
    calibrate_gyroscope(rotation_matrices, Wx, Wy, Wz, vicon_T)
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
    alpha_x = -((average_x - beta_x) * (3300/1023))

    # set values
    alpha_x = 342.184 
    beta_x = 510.807
    alpha_y = 239.438
    beta_y = 500.994
    alpha_z = 340.221
    beta_z = 499.69

    print("Parameters")
    print(alpha_x, beta_x, alpha_y, beta_y, alpha_z, beta_z)

    return np.array([alpha_x, beta_x, alpha_y, beta_y, alpha_z, beta_z])

def calibrate_gyroscope(rotation_matrices, Wx, Wy, Wz, vicon_T):
    dt = np.diff(vicon_T)

    true_W = np.zeros((3, rotation_matrices.shape[2]))
    
    for timestep in range(rotation_matrices.shape[2] - 1):
        r = rotation_matrices[:, :, timestep]
        r_next = rotation_matrices[:, :, timestep + 1]

        drdt = (r_next - r) / dt[timestep]

        skew_symmetric_matrix = np.matmul(r.T, drdt)

        true_W[0, timestep] = skew_symmetric_matrix[2, 1]
        true_W[1, timestep] = skew_symmetric_matrix[0, 2]
        true_W[2, timestep] = skew_symmetric_matrix[1, 0]

    interp_wx = interp1d(vicon_T, true_W[0], kind='nearest', bounds_error = False, fill_value="extrapolate")
    interp_wy = interp1d(vicon_T, true_W[1], kind = "nearest", bounds_error = False, fill_value = "extrapolate")
    interp_wz = interp1d(vicon_T, true_W[2], kind = 'nearest', bounds_error = False, fill_value = 'extrapolate')

    interpol_wx = interp_wx()

    print(Wx.shape)
    exit(0)

    # # for timestep in range(len(dt)):
    # dwx = np.diff(roll) / dt
    # dwy = np.diff(pitch) / dt
    # dwz = np.diff(yaw) / dt

    # print(f"Wx, Wy, Wz Shapes: {Wx.shape}, {Wy.shape}, {Wz.shape}\n")
    # print(f"dWx, dWy, dWz Shapes: {dwx.shape}, {dwy.shape}, {dwz.shape}\n")

    # beta_x = np.mean(Wx[:700])
    # beta_y = np.mean(Wy[:700])
    # beta_z = np.mean(Wz[:700])

    # print(Wx.shape)
    # exit(0)

    alpha_params = least_squares(error, [100, 100, 100], args = ([dwx, dwy, dwz], [Wx, Wy, Wz], [beta_x, beta_y, beta_z]))



    # print(f"Max of dwx: {max(dwx)}")    
    # d_wx = np.gradient(roll, 1)
    # d_wy = np.gradient(pitch, 1)
    # d_wz = np.gradient(yaw, 1)
    # print(max(d_wx))
    # plt.plot(np.arange(len(dwx)), dwx, label = "X")
    # plt.plot(np.arange(len(dwx)), dwy, label = "Y")
    # plt.plot(np.arange(len(dwx)), dwz, label = "Z")

    # plt.legend()

    # plt.show()


    return None


def error(params, pred_W, true_W, betas):
    beta_x, beta_y, beta_z = betas
    alpha_x, alpha_y, alpha_z = params

    pred_Ax, pred_Ay, pred_Az = pred_W
    true_Ax, true_Ay, true_Az = true_W

    ax = helpful_utils.convert_raw_to_value(pred_Ax, alpha_x, beta_x)
    ay = helpful_utils.convert_raw_to_value(pred_Ay, alpha_y, beta_y)
    az = helpful_utils.convert_raw_to_value(pred_Az, alpha_z, beta_z)

    error_x = np.sqrt(np.power(ax - true_Ax, 2))
    error_y = np.sqrt(np.power(ay - true_Ay, 2))
    error_z = np.sqrt(np.power(az - true_Az, 2))

    return error_x + error_y + error_z

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





# call the function
estimate_rot()