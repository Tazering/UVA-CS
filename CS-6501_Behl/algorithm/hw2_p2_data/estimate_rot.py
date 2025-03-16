import numpy as np
from scipy import io
from quaternion import Quaternion
import math
import seaborn.objects as so
import pandas as pd
import matplotlib.pyplot as plt
import helpful_utils

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
    # plot the vicon data
    vicon_plot, roll, pitch, yaw = plot_vicon_data(rotation_matrices = rotation_matrices, T = vicon_T)
    
    accel_plot, Ax, Ay, Az = plot_accelerometer(accel, imu_T, plot_type = "rotation")

    # accel_plot.show()
    gyro_plot, Wx, Wy, Wz = plot_gyroscope(gyro, imu_T)

    accel_plot.show()
    return None

def calibrate_accelerometer():
    return None

def calibrate_gyroscope():
    return None

# plot vicon roll, pitch, and yaw data
def plot_vicon_data(rotation_matrices, T):
    quaternion = Quaternion()
    num_timesteps = T.shape[1]

    roll = []
    pitch = []
    yaw = []

    for rotm in range(num_timesteps): # loop through timesteps

        rotation_matrix = helpful_utils.get_rotation_matrix(rotation_matrices = rotation_matrices, idx = rotm) # get the rotation matrix
        quaternion.from_rotm(rotation_matrix) # convert to quaternion
        euler_angle = quaternion.euler_angles() # convert to euler_angles

        roll.append(euler_angle[0])
        pitch.append(euler_angle[1])
        yaw.append(euler_angle[2])

    vicon_plot = (
        so.Plot()
        .add(so.Line(color = "red"), x = T[0], y = roll, label = "Roll")
        .add(so.Line(color = "blue"), x = T[0], y = pitch, label = "Pitch")
        .add(so.Line(color = "green"), x = T[0], y = yaw, label = "Yaw")
        .label(
            x = "Timestep",
            y = "Values",
            title = "Vicon Plot"
        )
    )

    return vicon_plot, roll, pitch, yaw

# plot the accelerometer yaw, pitch, and rotate
def plot_accelerometer(accel, T, plot_type = "linear_acceleration", conversion_param = [10000, 0]):

    # initialization
    Ax = []
    Ay = []
    Az = []
    phi = []
    theta = []
    bias = conversion_param[0]
    sensitivity = conversion_param[1]

    timesteps = T[0]

    for timestep in range(T.shape[1]): # get all the linear accelerations

        ax = accel[0][timestep]
        ay = accel[1][timestep]
        az = accel[2][timestep]

        Ax.append(ax) 
        Ay.append(ay)
        Az.append(az)

        ax = helpful_utils.convert_raw_to_value(ax, alpha = bias, beta = sensitivity)
        ay = helpful_utils.convert_raw_to_value(ay, alpha = bias, beta = sensitivity)
        az = helpful_utils.convert_raw_to_value(az, alpha = bias, beta = sensitivity)

        # to match with vicon
        phi_val, theta_val = helpful_utils.get_roll_and_pitch_from_acceleration(ax, ay, az)
        phi.append(phi_val)
        theta.append(theta_val)


    if plot_type == "linear_acceleration":
        accel_plot = (
            so.Plot()
            .add(so.Line(color = "red"), x = timesteps, y = Ax, label = "Ax")
            .add(so.Line(color = "blue"), x = timesteps, y = Ay, label = "Ay")
            .add(so.Line(color = "green"), x = timesteps, y = Az, label = "Az")
            .label(
                x = "Timestep",
                y = "Values",
                title = "Accelerometer Plot (Linear Acceleration)"
            )
        )
    else:
        accel_plot = (
            so.Plot()
            .add(so.Line(color = "red"), x = timesteps, y = phi, label = "Roll")
            .add(so.Line(color = "blue"), x = timesteps, y = theta, label = "Pitch")
            .label(
                x = "Timestep",
                y = "Rotation",
                title = "Accelerometer Plot (Roll and Pitch)"
            )
        )

    return accel_plot, Ax, Ay, Az

def plot_gyroscope(gyro, T):
    
    # initialization
    Wx = []
    Wy = []
    Wz = []

    timesteps = T[0]

    for timestep in range(T.shape[1]):

        Wx.append(gyro[1][timestep])
        Wy.append(gyro[2][timestep])
        Wz.append(gyro[0][timestep])

    gyro_plot = (
        so.Plot()
        .add(so.Line(color = "red"), x = timesteps, y = Wx, label = "Wx")
        .add(so.Line(color = "blue"), x = timesteps, y = Wy, label = "Wy")
        .add(so.Line(color = "green"), x = timesteps, y = Wz, label = "Wz")
        .label(
            x = "Timesteps",
            y = "Values",
            title = "Gyroscope Plot"
        )
    )

    return gyro_plot, Wx, Wy, Wz

# call the function
estimate_rot()