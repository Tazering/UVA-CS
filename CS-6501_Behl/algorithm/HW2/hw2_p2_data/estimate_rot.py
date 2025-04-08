import numpy as np
from scipy import io
import helpful_utils
import unscented_kalman_filter
import matplotlib.pyplot as plt

import plotting_utils

# import matplotlib.pyplot as plt
from scipy.signal import butter, filtfilt

def estimate_rot(data_num=3):
    #load data
    imu = io.loadmat('imu/imuRaw'+str(data_num)+'.mat')
    vicon = io.loadmat('vicon/viconRot'+str(data_num)+'.mat')
    accel = imu['vals'][0:3,:] # observations by accelerometer
    gyro = imu['vals'][3:6,:] # observations by gyroscope
    T = np.shape(imu['ts'])[1] # total number of timesteps (in unix time)

    rotation_matrices = vicon['rots']
    T_vicon = vicon['ts']
    imu_T = imu['ts'][0]
    # # your code goes here
    vicon_T = T_vicon[0]

    Ax, Ay, Az, Wx, Wy, Wz = helpful_utils.parse_data(accel, gyro)

    vicon_plot, roll, pitch, yaw = plotting_utils.plot_vicon_data(rotation_matrices, T_vicon)
    # vicon_plot.show()

    # b)
    accel_params = [342.184, 510.807, 239.438, 500.994, 340.221, 499.69]

    ax = helpful_utils.convert_raw_to_value(Ax, 342.184, 510.807)
    ay = helpful_utils.convert_raw_to_value(Ay, 239.438, 500.994)
    az = helpful_utils.convert_raw_to_value(Az, 340.221, 499.69)

    pred_roll, pred_pitch = helpful_utils.get_roll_and_pitch_from_acceleration(-ax, -ay, az)

    roll_graph = plotting_utils.compare_plots(pred = pred_roll, true = roll[:3404], name = "Roll")

    # plt.title("Roll Graph")
    # plt.plot(pred_roll[:5600], label = "Calibrated Roll")
    # plt.plot(roll[:5600], label = "True Roll")
    # plt.xlabel("Timesteps")
    # plt.ylabel("Euler Angles (radians)")
    # plt.legend()
    # plt.show()

    # plt.title("Pitch Graph")
    # plt.plot(pred_pitch[:5600], label = "Calibrated Pitch")
    # plt.plot(pitch[:5600], label = "True Pitch")
    # plt.xlabel("Timesteps")
    # plt.ylabel("Euler Angles (radians)")
    # plt.legend()
    # plt.show()


    # print(len(pred_roll), len(roll))
    # roll_graph.show()


    # gyro_params = [3.679439556727866, 373.57142857142856, 3.6052804683739508, 375.37285714285713, 6.249146181748531, 369.6857142857143]
    true_wx, true_wy, true_wz = helpful_utils.get_interpolated_angular_velocities(rotation_matrices, vicon_T, imu_T)
    gyro_params = [135.9439556727866, 373.57142857142856, 140.52804683739508, 375.37285714285713, 140.49146181748531, 369.6857142857143]
    # wx = helpful_utils.convert_raw_to_value(Wx, 135.9439556727866, 373.57142857142856)
    # wy = helpful_utils.convert_raw_to_value(Wy, 140.52804683739508, 375.37285714285713)
    # wz = helpful_utils.convert_raw_to_value(Wz, 140.49146181748531, 369.6857142857143)

    # plt.title("Calibrated vs Vicon: Wx")
    # plt.plot(true_wx, color = "red", label = "True Wx")
    # plt.plot(wx, color = "blue", label= "Calibrated Wx")
    # plt.xlabel("Timesteps")
    # plt.ylabel("Angular Velocities (rad/s)")
    # plt.legend()
    # plt.show()

    # plt.title("Calibrated vs Vicon: Wy")
    # plt.plot(true_wy, color = "red", label = "True Wy")
    # plt.plot(wy, color = "blue", label= "Calibrated Wy")
    # plt.xlabel("Timesteps")
    # plt.ylabel("Angular Velocities (rad/s)")
    # plt.legend()
    # plt.show()

    # plt.title("Calibrated vs Vicon: Wz")
    # plt.plot(true_wz, color = "red", label = "True Wz")
    # plt.plot(wz, color = "blue", label= "Calibrated Wz")
    # plt.xlabel("Timesteps")
    # plt.ylabel("Angular Velocities (rad/s)")
    # plt.legend()
    # plt.show()

    # exit()



    # wx = helpful_utils.convert_raw_to_value(Wx, 135.9439556727866, 373.57142857142856)
    # wy = helpful_utils.convert_raw_to_value(Wy, 140.52804683739508, 375.37285714285713)
    # wz = helpful_utils.convert_raw_to_value(Wz, 140.49146181748531, 369.6857142857143)

    # true_wx, true_wy, true_wz = helpful_utils.get_interpolated_angular_velocities(rotation_matrices, vicon_T, imu_T)

    # wx_compare = plotting_utils.compare_plots(pred = wx, true = true_wx, name = "wx")
    # wy_compare = plotting_utils.compare_plots(pred = wy, true = true_wy, name = "wy")
    # wz_compare = plotting_utils.compare_plots(pred = wz, true = true_wz, name = "wz") # use dataset 3 for wz

    # wx_compare.show()
    # wy_compare.show()
    # wz_compare.show()

    # calibration.calibrate_sensors(accel, gyro, imu_T, vicon_T, rotation_matrices)

    # d) Use UFK
    states, covariances = unscented_kalman_filter.run_ukf(accel, accel_params, gyro, gyro_params, imu_T)

    roll_cov = []
    pitch_cov = []
    yaw_cov = []
    wx_cov = []
    wy_cov = []
    wz_cov = []

    q0_mean = []
    q1_mean = []
    q2_mean = []
    q3_mean = []
    wx_mean = []
    wy_mean = []
    wz_mean = []

    for cov_idx in range(covariances.shape[0]):
        cov = covariances[cov_idx, :]

        roll_cov.append(cov[0, 0])
        pitch_cov.append(cov[1, 1])
        yaw_cov.append(cov[2, 2])
        wx_cov.append(cov[3, 3])
        wy_cov.append(cov[4, 4])
        wz_cov.append(cov[5, 5])


    plt.title("Covariance: Euler Angles")
    plt.plot(roll_cov, color = "red", label = "Roll Covariance")
    plt.plot(pitch_cov, color = "blue", label= "Pitch Covariance")
    plt.plot(yaw_cov, color = "green", label= "Yaw Covariance")
    plt.xlabel("Timesteps")
    plt.ylabel("Euler Angles (radians)")
    plt.legend()
    plt.show()

    plt.title("Covariance: Angular Velocity")
    plt.plot(wx_cov, color = "red", label = "Wx Covariance")
    plt.plot(wy_cov, color = "blue", label= "Wy Covariance")
    plt.plot(wz_cov, color = "green", label= "Wz Covariance")
    plt.xlabel("Timesteps")
    plt.ylabel("Angular Velocity (rad/s)")
    plt.legend()
    plt.show()

    for state_idx in range(states.shape[0]):
        state = states[state_idx, :]

        q0_mean.append(state[0])
        q1_mean.append(state[1])
        q2_mean.append(state[2])
        q3_mean.append(state[3])
        wx_mean.append(state[4])
        wy_mean.append(state[5])
        wz_mean.append(state[6])

    
    plt.title("Mean: Quaternions")
    plt.plot(q0_mean, color = "red", label = "q0 Mean")
    plt.plot(q1_mean, color = "blue", label = "q1 Mean")
    plt.plot(q2_mean, color = "green", label = "q2 Mean")
    plt.plot(q3_mean, color = "purple", label = "q3 Mean")
    plt.xlabel("Timesteps")
    plt.ylabel("Quaternions")
    plt.legend()
    plt.show()

    
    plt.title("Mean: Angular Velocity")
    plt.plot(wx_mean, color = "red", label = "Wx Mean")
    plt.plot(wy_mean, color = "blue", label = "Wy Mean")
    plt.plot(wz_mean, color = "green", label = "Wz Mean")
    plt.xlabel("Timesteps")
    plt.ylabel("Angular Velocity (rad/s)")
    plt.legend()
    plt.show()

    exit()

    # ukf_wx, ukf_wy, ukf_wz, true_wx, true_wy, true_wz = helpful_utils.get_estimated_angular_velocities_from_states(states, rotation_matrices, vicon_T, imu_T)

    # wx_compare_plot = plotting_utils.compare_plots(pred = ukf_wx, true = true_wx, name = "Wx")
    # wy_compare_plot = plotting_utils.compare_plots(pred = ukf_wy, true = true_wy, name = "Wy")
    # wz_compare_plot = plotting_utils.compare_plots(pred = ukf_wz, true = true_wz, name = "Wz")

    # wx_compare_plot.show()
    # wy_compare_plot.show()
    # wz_compare_plot.show()


    # # euler_angles_compare.show()
    # # angular_velocities_compare.show()
    # # ax = helpful_utils.convert_raw_to_value(Ax, 342.184, 510.807)
    # # ay = helpful_utils.convert_raw_to_value(Ay, 239.438, 500.994)
    # # az = helpful_utils.convert_raw_to_value(Az, 340.221, 499.69)

    # # roll, pitch = helpful_utils.get_roll_and_pitch_from_acceleration(ax, ay, az)
    interpolated_rotation_matrices = helpful_utils.interpolate_ground_truth(true_x = vicon_T, true_y = rotation_matrices, pred_x = imu_T)

    def lowpass_filter(data, cutoff = 5, fs = 100, order = 2):
        nyquist = fs/2
        normal_cutoff = cutoff / nyquist
        b, a = butter(order, normal_cutoff, btype = 'low', analog = False)
        return filtfilt(b, a, data, axis = 0)

    output_euler_angles = helpful_utils.get_euler_angles_from_states(states)
    true_euler_angles = helpful_utils.convert_rotation_matrices_to_euler_angles(interpolated_rotation_matrices)

    # # euler_angles_compare = plotting_utils.plot_ukf_vs_sensor_axis_angles(states, interpolated_rotation_matrices)
    # # angular_velocities_compare = plotting_utils.plot_ukf_vs_sensor_angular_velocities(states, rotation_matrices, vicon_T, imu_T)


    true_roll, true_pitch, true_yaw = true_euler_angles
    output_roll, output_pitch, output_yaw = output_euler_angles

    output_roll = lowpass_filter(output_roll, cutoff = 1, fs = 100)
    output_pitch = lowpass_filter(output_pitch, cutoff = 1, fs = 100)
    output_yaw = lowpass_filter(output_yaw, cutoff = 1, fs = 100)

    roll_compare_plot = plotting_utils.compare_plots(pred = output_roll, true = true_roll, name = "Roll")
    pitch_compare_plot = plotting_utils.compare_plots(pred = output_pitch, true = true_pitch, name = "Pitch")
    yaw_compare_plot = plotting_utils.compare_plots(pred = output_yaw, true = true_yaw, name = "Yaw")
    roll_compare_plot.show()
    pitch_compare_plot.show()
    yaw_compare_plot.show()


    return np.array(output_roll), np.array(output_pitch), np.array(output_yaw)
    # return np.random.rand(5645), np.random.rand(5645), np.zeros(5645)

    # return roll, pitch, np.zeros(shape = (5645))

# call the function
estimate_rot()