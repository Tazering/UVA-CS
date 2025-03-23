import numpy as np
from scipy import io
from quaternion import Quaternion
import math
import seaborn.objects as so
import pandas as pd
import matplotlib.pyplot as plt
import helpful_utils
from scipy.interpolate import interp1d
from scipy.signal import savgol_filter


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
        # euler_angle = helpful_utils.convert_rotation_matrix_to_euler(rotation_matrix)
        quaternion.from_rotm(rotation_matrix) # convert to quaternion
        euler_angle = quaternion.euler_angles() # convert to euler_angles

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
def plot_accelerometer(Ax, Ay, Az, vicon_T):

    # initialization
    timesteps = np.arange(len(Ax))

    # if not transformed:
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

    return accel_plot


def plot_orientations(Ax, Ay, Az, Wx, Wy, Wz, imu_T, vicon_T, accel_params, gyro_params):

    alpha_x, beta_x, alpha_y, beta_y, alpha_z, beta_z = accel_params
    gyro_alpha_x, gyro_beta_x, gyro_alpha_y, gyro_beta_y, gyro_alpha_z, gyro_beta_z = gyro_params
    phi = []
    theta = []

    T = imu_T[0]

    wx = helpful_utils.convert_raw_to_value(Wx, alpha = gyro_alpha_x, beta = gyro_beta_x)
    wy = helpful_utils.convert_raw_to_value(Wy, alpha = gyro_alpha_y, beta = gyro_beta_y)
    wz = helpful_utils.convert_raw_to_value(Wz, alpha = gyro_alpha_z, beta = gyro_beta_z)

    dt = np.diff(T)

    quaternion = Quaternion()
    other_quaternion = Quaternion()

    q = np.array([1, 0, 0, 0])
    orientations = np.zeros((len(T), 4))
    orientations[0] = q

    wz_len = len(wz)


    # conversion
    for timestep in range(len(T)):
        ax = helpful_utils.convert_raw_to_value(Ax[timestep], alpha = alpha_x, beta = beta_x)
        ay = -helpful_utils.convert_raw_to_value(Ay[timestep], alpha = alpha_y, beta = beta_y)
        az = helpful_utils.convert_raw_to_value(Az[timestep], alpha = alpha_z, beta = beta_z)

        phi_val, theta_val = helpful_utils.get_roll_and_pitch_from_acceleration(ax, ay, az)

        phi.append(phi_val)
        theta.append(theta_val)

    for timestep in range(len(T) - 1):
        angular_vel_quaternion = np.array([0, wx[timestep], wy[timestep], wz[timestep]])


        quaternion1 = Quaternion()
        quaternion2 = Quaternion()
        quaternion1.q = q
        quaternion2.q = angular_vel_quaternion
        dq = 0.5 * quaternion1.__mul__(quaternion2).q

        q = q + dq * dt[timestep]

        q = q/np.linalg.norm(q)
        orientations[timestep + 1] = q

    euler_angles = np.zeros((len(T), 3))
    for t in range(len(T)):
        quaternion3 = Quaternion()
        quaternion3.q = orientations[t]

        euler_angles[t] = quaternion3.euler_angles()

    yaw = euler_angles[:, 2]

    orientation_plot = (
        so.Plot()
        .add(so.Line(color = "red"), x = T, y = phi, label = "roll")
        .add(so.Line(color = "blue"), x = T, y = theta, label = "pitch")
        # .add(so.Line(color = "green"), x = T, y = yaw, label = "yaw")
        .label(
            x = "Timestep",
            y = "Values",
            title = "Orientations Post Calibration"
        )
    )

    return orientation_plot

def plot_angular_velocity(rotation_matrices, Wx, Wy, Wz, gyro_param, vicon_T, imu_T):
    dt = np.diff(vicon_T)
    T = len(vicon_T)

    alpha_x, beta_x, alpha_y, beta_y, alpha_z, beta_z = gyro_param

    wx = helpful_utils.convert_raw_to_value(Wx, alpha = alpha_x, beta = beta_x, is_gyro=True)
    wy = helpful_utils.convert_raw_to_value(Wy, alpha = alpha_y, beta = beta_y, is_gyro=True)
    wz = helpful_utils.convert_raw_to_value(Wz, alpha = alpha_z, beta = beta_z, is_gyro=True)

    true_wx = []
    true_wy = []
    true_wz = []

    for timestep in range(T-1):

            quaternion = Quaternion()

            quaternion.from_rotm(rotation_matrices[:, :, timestep])
            axis_angle = quaternion.axis_angle()

            true_wx.append(axis_angle[0] / dt[timestep])
            true_wy.append(axis_angle[1] / dt[timestep])
            true_wz.append(axis_angle[2] / dt[timestep])

    plt.plot(true_wx, color = "red", label = "True Wx")
    plt.plot(true_wy, color = "blue", label = "True Wy")
    plt.plot(true_wz, color = "green", label = "True Wz")
    plt.legend()
    plt.show()

    plt.plot(wx, color = "red", label = "Wx")
    plt.plot(wy, color = "blue", label = "Wy")
    plt.plot(wz, color = "green", label = "Wz")
    plt.legend()
    plt.show()


    return None

def plot_gyroscope(gyro, T):
    
    # initialization
    Wx = []
    Wy = []
    Wz = []

    idx_timesteps = np.arange(T.shape[1])

    for timestep in range(T.shape[1]):

        Wx.append(gyro[1][timestep])
        Wy.append(gyro[2][timestep])
        Wz.append(gyro[0][timestep])

    gyro_plot = (
        so.Plot()
        .add(so.Line(color = "red"), x = idx_timesteps, y = Wx, label = "Wx")
        .add(so.Line(color = "blue"), x = idx_timesteps, y = Wy, label = "Wy")
        .add(so.Line(color = "green"), x = idx_timesteps, y = Wz, label = "Wz")
        .label(
            x = "Timesteps",
            y = "Values",
            title = "Gyroscope Plot"
        )
    )

    return gyro_plot


# plot rotation matrices to angular velocity
def plot_vicon_angular_velocities(rotation_matrices, vicon_T):

    # compute angular velocities
    omega, times = helpful_utils.convert_rotation_matrix_to_angular_velocity(rotation_matrices, vicon_T)
    idx_timesteps = np.arange(len(times))

    true_vicon_omega_plot = (
        so.Plot()
        .add(so.Line(color = "red"), x = idx_timesteps, y = omega[0], label = "Wx")
        .add(so.Line(color = "blue"), x = idx_timesteps, y = omega[1], label = "Wy")
        .add(so.Line(color = "green"), x = idx_timesteps, y = omega[2], label = "Wz")
        .label(
            x = "Time",
            y = "Angular Velocity (rad/s)",
            title = "True Angular Velocity Plot"
        )
    )

    return true_vicon_omega_plot

# plot to compare true and predicted angular velocities
def plot_true_v_pred_omega(true_W, pred_omega, true_timesteps, imu_T, params):

    alpha_x, beta_x, alpha_y, beta_y, alpha_z, beta_z = params

    calibrated_wx = helpful_utils.convert_raw_to_value(pred_omega[0], alpha_x, beta_x, is_gyro = True)
    calibrated_wy = helpful_utils.convert_raw_to_value(pred_omega[1], alpha_y, beta_y, is_gyro = True)
    calibrated_wz = helpful_utils.convert_raw_to_value(pred_omega[2], alpha_z, beta_z, is_gyro = True)


    interpolated_wx = helpful_utils.interpolate_ground_truth(true_x = true_timesteps, true_y = true_W[0], pred_x = imu_T)
    interpolated_wy = helpful_utils.interpolate_ground_truth(true_x = true_timesteps, true_y = true_W[1], pred_x = imu_T)
    interpolated_wz = helpful_utils.interpolate_ground_truth(true_x = true_timesteps, true_y = true_W[2], pred_x = imu_T)


    idx_timesteps = np.arange(len(pred_omega[0]))

    compare_plot_Wx = (
        so.Plot()
        .add(so.Line(color = "red"), x = idx_timesteps, y = interpolated_wx, label = f"True Wx")
        .add(so.Line(color = "green"), x = idx_timesteps, y = calibrated_wx, label = f"Calibrated Wx")
        .label(
            x = "Time",
            y = "Angular Velocity (rad/s)",
            title = "Comparions between True and Calibrated Wx"
        )
    )

    compare_plot_Wy = (
        so.Plot()
        .add(so.Line(color = "red"), x = idx_timesteps, y = interpolated_wy, label = f"True Wy")
        .add(so.Line(color = "green"), x = idx_timesteps, y = calibrated_wy, label = f"Calibrated Wy")
        .label(
            x = "Time",
            y = "Angular Velocity (rad/s)",
            title = "Comparions between True and Calibrated Wx"
        )
    )

    compare_plot_Wz = (
        so.Plot()
        .add(so.Line(color = "red"), x = idx_timesteps, y = interpolated_wz, label = f"True Wz")
        .add(so.Line(color = "green"), x = idx_timesteps, y = calibrated_wz, label = f"Calibrated Wz")
        .label(
            x = "Time",
            y = "Angular Velocity (rad/s)",
            title = "Comparions between True and Calibrated Wz"
        )
    )

    return compare_plot_Wx, compare_plot_Wy, compare_plot_Wz