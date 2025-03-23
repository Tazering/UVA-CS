import numpy as np
from scipy import io
from quaternion import Quaternion
import seaborn.objects as so
import pandas as pd
import helpful_utils
import plotting_utils
import ukf
import calibration

def estimate_rot(data_num=1):
    #load data
    imu = io.loadmat('imu/imuRaw'+str(data_num)+'.mat')
    vicon = io.loadmat('vicon/viconRot'+str(data_num)+'.mat')

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
    # vicon_plot, roll, pitch, yaw = plotting_utils.plot_vicon_data(rotation_matrices, T_vicon)
    # vicon_plot.show()
    accel_params, gyro_params = calibration.calibrate_sensors(accel, gyro, imu['ts'], T_vicon[0], rotation_matrices) # calibration

    # d) Use UFK
    states = ukf.run_ukf_process(accel, accel_params, gyro, gyro_params, imu['ts'][0])


    return None

# call the function
estimate_rot()