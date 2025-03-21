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
    timesteps = np.arange(num_timesteps)

    roll = []
    pitch = []
    yaw = []

    for rotm in range(num_timesteps): # loop through timesteps

        rotation_matrix = rotation_matrices[:, :, rotm]
        euler_angle = helpful_utils.convert_rotation_matrix_to_euler(rotation_matrix)
        # quaternion.from_rotm(rotation_matrix) # convert to quaternion
        # euler_angle = quaternion.euler_angles() # convert to euler_angles

        roll.append(euler_angle[0])
        pitch.append(euler_angle[1])
        yaw.append(euler_angle[2])

    vicon_plot = (
        so.Plot()
        .add(so.Line(color = "red"), x = timesteps, y = roll, label = "Roll")
        .add(so.Line(color = "blue"), x = timesteps, y = pitch, label = "Pitch")
        .add(so.Line(color = "green"), x = timesteps, y = yaw, label = "Yaw")
        .label(
            x = "Timestep",
            y = "Values",
            title = "Vicon Plot"
        )
    )

    return vicon_plot, roll, pitch, yaw

# plot the accelerometer yaw, pitch, and rotate
def plot_accelerometer(Ax, Ay, Az, T, conversion_param = [1, 2, 3, 4, 5, 6], transformed = False):

    # initialization
    timesteps = T

    alpha_x, alpha_y, alpha_z, beta_x, beta_y, beta_z = conversion_param
    
    convert_ax = []
    convert_ay = []
    convert_az = []

    for timestep in range(len(T)): # get all the linear accelerations

        ax = -helpful_utils.convert_raw_to_value(Ax[timestep], alpha = alpha_x, beta = beta_x)
        ay = -helpful_utils.convert_raw_to_value(Ay[timestep], alpha = alpha_y, beta = beta_y)
        az = helpful_utils.convert_raw_to_value(Az[timestep], alpha = alpha_z, beta = beta_z)

        convert_ax.append(ax)
        convert_ay.append(ay)
        convert_az.append(az)
    

    if not transformed:
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
            .add(so.Line(color = "red"), x = timesteps, y = convert_ax, label = "Ax")
            .add(so.Line(color = "blue"), x = timesteps, y = convert_ay, label = "Ay")
            .add(so.Line(color = "green"), x = timesteps, y = convert_az, label = "Az")
            .label(
                x = "Timestep",
                y = "Values",
                title = "Accelerometer Plot (Linear Acceleration)"
            )
        )

    return accel_plot


def plot_orientations(Ax, Ay, Az, T, best_params):

    alpha_x, beta_x, alpha_y, beta_y, alpha_z, beta_z = best_params
    phi = []
    theta = []

    # conversion
    for timestep in range(len(T)):
        ax = helpful_utils.convert_raw_to_value(Ax[timestep], alpha = alpha_x, beta = beta_x)
        ay = -helpful_utils.convert_raw_to_value(Ay[timestep], alpha = alpha_y, beta = beta_y)
        az = helpful_utils.convert_raw_to_value(Az[timestep], alpha = alpha_z, beta = beta_z)

        phi_val, theta_val = helpful_utils.get_roll_and_pitch_from_acceleration(ax, ay, az)

        phi.append(phi_val)
        theta.append(theta_val)
    
    orientation_plot = (
        so.Plot()
        .add(so.Line(color = "red"), x = T, y = phi, label = "roll")
        .add(so.Line(color = "blue"), x = T, y = theta, label = "pitch")
        .label(
            x = "Timestep",
            y = "Values",
            title = "Orientations Post Calibration"
        )
    )

    return orientation_plot

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

def compare_graphs(pred, true, title_name):
    timesteps = np.arange(len(pred))

    comparison_plot = (
        so.Plot()
        .add(so.Line(color = "red"), x = timesteps, y = true, label = "True")
        .add(so.Line(color = "blue"), x = timesteps, y = pred, label = "Calibrated")
        .label(
            x = "Timesteps",
            y = "Values",
            title = title_name
        )
    )

    return comparison_plot