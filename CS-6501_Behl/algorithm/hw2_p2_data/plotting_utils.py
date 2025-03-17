import numpy as np
from scipy import io
from quaternion import Quaternion
import math
import seaborn.objects as so
import pandas as pd
import matplotlib.pyplot as plt
import helpful_utils


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
def plot_accelerometer(Ax, Ay, Az, T, plot_type = "linear_acceleration", conversion_param = [1, 2, 3, 4, 5, 6]):

    # initialization
    phi = []
    theta = []
    bias = conversion_param[0]
    sensitivity = conversion_param[1]

    timesteps = T[0]

    alpha_x, beta_x, alpha_y, beta_y, alpha_z, beta_z = conversion_param

    for timestep in range(T.shape[1]): # get all the linear accelerations


        ax = helpful_utils.convert_raw_to_value(Ax[timestep], alpha = alpha_x, beta = beta_x)
        ay = helpful_utils.convert_raw_to_value(Ay[timestep], alpha = alpha_y, beta = beta_y)
        az = helpful_utils.convert_raw_to_value(Az[timestep], alpha = alpha_z, beta = beta_z)

        # to match with vicon
        phi_val, theta_val = helpful_utils.get_roll_and_pitch_from_acceleration(-ax, -ay, az)
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

    return accel_plot

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