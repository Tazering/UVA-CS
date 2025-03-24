import numpy as np
from scipy import io
from quaternion import Quaternion
import helpful_utils
import unscented_kalman_filter
import calibration

import plotting_utils


def estimate_rot(data_num=1):
    #load data
    imu = io.loadmat('imu/imuRaw'+str(data_num)+'.mat')
    vicon = io.loadmat('vicon/viconRot'+str(data_num)+'.mat')

    accel = imu['vals'][0:3,:] # observations by accelerometer

    # # Wx, Wy, Wz = rotation rates about the corresponding axes
    # # order of IMU is Wz, Wx, Wy
    gyro = imu['vals'][3:6,:] # observations by gyroscope
    # T = np.shape(imu['ts'])[1] # total number of timesteps (in unix time)

    rotation_matrices = vicon['rots']
    T_vicon = vicon['ts']
    imu_T = imu['ts'][0]
    # # your code goes here
    vicon_T = T_vicon[0]

    interpolated_rotation_matrices = helpful_utils.interpolate_ground_truth(true_x = vicon_T, true_y = rotation_matrices, pred_x = imu_T)

    # # b)
    #     # plot vicon
    # vicon_plot, roll, pitch, yaw = plotting_utils.plot_vicon_data(rotation_matrices, T_vicon)
    # vicon_plot.show()
    # # accel_params, gyro_params = calibration.calibrate_sensors(accel, gyro, imu['ts'], T_vicon[0], rotation_matrices) # calibration
    # accel_params, gyro_params = calibration.calibrate_sensors(accel, gyro, imu['ts'], vicon_T, rotation_matrices)
    # print(f"gyro params: {gyro_params}\n")

    accel_params = [342.184, 510.807, 239.438, 500.994, 340.221, 499.69]

    gyro_params = [3.1960820636599356, 373.57142857142856, 2.9294486896322045, 375.37285714285713, 7.9143836834327805, 369.6857142857143]
    calibration.calibrate_sensors(accel, gyro, imu_T, vicon_T, rotation_matrices)

    # # d) Use UFK
    states, covariances = unscented_kalman_filter.run_ukf_process(accel, accel_params, gyro, gyro_params, imu['ts'][0])

    euler_angles_compare = plotting_utils.plot_ukf_vs_sensor_axis_angles(states, interpolated_rotation_matrices)
    angular_velocities_compare = plotting_utils.plot_ukf_vs_sensor_angular_velocities(states, rotation_matrices, vicon_T, imu_T)

    euler_angles_compare.show()
    angular_velocities_compare.show()

    output_roll, output_pitch, output_yaw = helpful_utils.get_euler_angles_from_states(states)
    return np.array(output_roll), np.array(output_pitch), np.array(output_yaw)

    # return np.random.rand(5645), np.random.rand(5645), np.random.rand(5645)

# call the function
estimate_rot()