import os, sys, pickle, math
from copy import deepcopy

from scipy import io
import numpy as np
import matplotlib.pyplot as plt

from load_data import load_lidar_data, load_joint_data, joint_name_to_index
from utils import *

import logging
logger = logging.getLogger()
logger.setLevel(os.environ.get("LOGLEVEL", "INFO"))

class map_t:
    """
    This will maintain the occupancy grid and log_odds. You do not need to change anything
    in the initialization
    """
    def __init__(s, resolution=0.05):
        s.resolution = resolution
        s.xmin, s.xmax = -20, 20
        s.ymin, s.ymax = -20, 20
        s.szx = int(np.ceil((s.xmax-s.xmin)/s.resolution+1))
        s.szy = int(np.ceil((s.ymax-s.ymin)/s.resolution+1))

        # binarized map and log-odds
        s.cells = np.zeros((s.szx, s.szy), dtype=np.int8)
        s.log_odds = np.zeros(s.cells.shape, dtype=np.float64)

        # value above which we are not going to increase the log-odds
        # similarly we will not decrease log-odds of a cell below -max
        s.log_odds_max = 5e6
        # number of observations received yet for each cell
        s.num_obs_per_cell = np.zeros(s.cells.shape, dtype=np.uint64)

        # we call a cell occupied if the probability of
        # occupancy P(m_i | ... ) is >= occupied_prob_thresh
        s.occupied_prob_thresh = 0.6
        s.log_odds_thresh = np.log(s.occupied_prob_thresh/(1-s.occupied_prob_thresh))

    def grid_cell_from_xy(s, x, y):
        """
        x and y are 1-dimensional arrays, compute the cell indices in the map corresponding
        to these (x,y) locations. You should return an array of shape 2 x len(x). Be
        careful to handle instances when x/y go outside the map bounds, you can use
        np.clip to handle these situations.
        """
        #### TODO: XXXXXXXXXXX
        # offset the coordinates
        x_rel = x - s.xmin
        y_rel = y - s.ymin

        # discretize
        x_disc = x_rel / s.resolution
        y_disc = y_rel / s.resolution

        # floor the values
        x_floor = np.floor(x_disc).astype(int)
        y_floor = np.floor(y_disc).astype(int)

        # clip the values
        clipped_x = np.clip(a = x_floor, a_min = 0, a_max = s.szx)
        clipped_y = np.clip(a = y_floor, a_min = 0, a_max = s.szy)

        return np.vstack((clipped_x, clipped_y))
        
class slam_t:
    """
    s is the same as self. In Python it does not really matter
    what we call self, s is shorter. As a general comment, (I believe)
    you will have fewer bugs while writing scientific code if you
    use the same/similar variable names as those in the mathematical equations.
    """
    def __init__(s, resolution=0.05, Q=1e-3*np.eye(3),
                 resampling_threshold=0.3):
        s.init_sensor_model()

        # dynamics noise for the state (x,y,yaw)
        s.Q = 1e-8*np.eye(3)

        # we resample particles if the effective number of particles
        # falls below s.resampling_threshold*num_particles
        s.resampling_threshold = resampling_threshold

        # initialize the map
        s.map = map_t(resolution)

    def read_data(s, src_dir, idx=0, split='train'):
        """
        src_dir: location of the "data" directory
        """
        logging.info('> Reading data')
        s.idx = idx
        s.lidar = load_lidar_data(os.path.join(src_dir,
                                               'data/%s/%s_lidar%d'%(split,split,idx)))
        s.joint = load_joint_data(os.path.join(src_dir,
                                               'data/%s/%s_joint%d'%(split,split,idx)))

        # finds the closets idx in the joint timestamp array such that the timestamp
        # at that idx is t
        s.find_joint_t_idx_from_lidar = lambda t: np.argmin(np.abs(s.joint['t']-t)) # tkj9ep: this seems like interpolation

    def init_sensor_model(s):
        # lidar height from the ground in meters
        s.head_height = 0.93 + 0.33
        s.lidar_height = 0.15

        # dmin is the minimum reading of the LiDAR, dmax is the maximum reading
        s.lidar_dmin = 1e-3
        s.lidar_dmax = 30
        s.lidar_angular_resolution = 0.25
        # these are the angles of the rays of the Hokuyo
        s.lidar_angles = np.arange(-135,135+s.lidar_angular_resolution,
                                   s.lidar_angular_resolution)*np.pi/180.0

        # sensor model lidar_log_odds_occ is the value by which we would increase the log_odds
        # for occupied cells. lidar_log_odds_free is the value by which we should decrease the
        # log_odds for free cells (which are all cells that are not occupied)
        s.lidar_log_odds_occ = np.log(9)
        s.lidar_log_odds_free = np.log(1/9.)

    def init_particles(s, n=100, p=None, w=None, t0=0):
        """
        n: number of particles
        p: xy yaw locations of particles (3xn array)
        w: weights (array of length n)
        """
        s.n = n
        s.p = deepcopy(p) if p is not None else np.zeros((3,s.n), dtype=np.float64)
        s.w = deepcopy(w) if w is not None else np.ones(n)/float(s.n)

    @staticmethod
    def stratified_resampling(p, w):
        """
        resampling step of the particle filter, takes p = 3 x n array of
        particles with w = 1 x n array of weights and returns new particle
        locations (number of particles n remains the same) and their weights
        """
        #### TODO: XXXXXXXXXXX
        raise NotImplementedError

    @staticmethod
    def log_sum_exp(w):
        return w.max() + np.log(np.exp(w-w.max()).sum())

    def rays2world(s, p, d, head_angle=0, neck_angle=0, angles=None):
        """
        p is the pose of the particle (x,y,yaw)
        angles = angle of each ray in the body frame (this will usually
        be simply s.lidar_angles for the different lidar rays)
        d = is an array that stores the distance of along the ray of the lidar, for each ray (the length of d has to be equal to that of angles, this is s.lidar[t]['scan'])
        Return an array 2 x num_rays which are the (x,y) locations of the end point of each ray
        in world coordinates
        """
        #### TODO: XXXXXXXXXXX
        # make sure each distance >= dmin and <= dmax, otherwise something is wrong in reading
        # the data

        clipped_d = np.clip(a = d, a_min = s.lidar_dmin, a_max = s.lidar_dmax)

        # 1. from lidar distances to points in the LiDAR frame
        x_lidar = clipped_d * np.cos(angles) # polar to cartesian
        y_lidar = clipped_d * np.sin(angles)
        z_lidar = np.zeros(shape = d.shape)

        lidar_coordinates = np.vstack((x_lidar, y_lidar, z_lidar))
        homogeneous_coords3d = make_homogeneous_coords_3d(lidar_coordinates)

        # 2. from LiDAR frame to the body frame
        T_h_b = euler_to_se3(0, head_angle, neck_angle, np.array([0, 0, s.lidar_height]))

        # 3. from body frame to world frame
        T_b_g_2d = get_se2(p[2], p[:2])
        T_b_g = np.eye(4)
        T_b_g[:2, :2] = T_b_g_2d[:2, :2]
        T_b_g[:2, 3] = T_b_g_2d[:2, 2]
        T_b_g[2, 2] = 1

        # 4. combined them all together
        combined_transformations = np.matmul(T_b_g, T_h_b)
        lidar_points = np.matmul(combined_transformations, homogeneous_coords3d)[:2, :]

        return lidar_points

    def get_control(s, t):
        """
        Use the pose at time t and t-1 to calculate what control the robot could have taken
        at time t-1 at state (x,y,th)_{t-1} to come to the current state (x,y,th)_t. We will
        assume that this is the same control that the robot will take in the function dynamics_step
        below at time t, to go to time t-1. need to use the smart_minus_2d function to get the difference of the two poses and we will simply set this to be the control (delta x, delta y, delta theta)
        """

        if t == 0:
            return np.zeros(3)

        #### TODO: XXXXXXXXXXX
        o_prev = s.lidar[t - 1]["xyth"] # get previous timestep
        o = s.lidar[t]["xyth"] # get current timestep

        o_diff = smart_minus_2d(o, o_prev)

        return o_diff

    def dynamics_step(s, t):
        """"
        Compute the control using get_control and perform that control on each particle to get the updated locations of the particles in the particle filter, remember to add noise using the smart_plus_2d function to each particle
        """
        #### TODO: XXXXXXXXXXX
        o_diff = s.get_control(t) # the delta_o
        particle_noise = np.random.multivariate_normal([0, 0, 0], s.Q, size = s.n).T # generate random particle noise
        noisy_o_diff = o_diff[:, None] + particle_noise

        # loop through particles, 1) update with delta_o, 2) corrupt with noise
        for p_id in range(s.n):
            s.p[:, p_id] = smart_plus_2d(s.p[:, p_id], noisy_o_diff[:, p_id])

    @staticmethod
    def update_weights(w, obs_logp):
        """
        Given the observation log-probability and the weights of particles w, calculate the
        new weights as discussed in the writeup. Make sure that the new weights are normalized
        """
        #### TODO: XXXXXXXXXXX
        # update the weight
        log_new_w = np.log(w + 1e-10)
        propagated_w = log_new_w + obs_logp

        # normalize
        max_w = np.max(propagated_w)
        log_summation = np.log(np.sum(np.exp(propagated_w - max_w)))

        norm_propagated_w = propagated_w - max_w - log_summation
        
        # new_w = new_w - np.max(new_w) - np.log(np.sum(np.exp(new_w - np.max(new_w))))

        return np.exp(norm_propagated_w)

        # raise NotImplementedError

    def observation_step(s, t):
        """
        This function does the following things
            1. updates the particles using the LiDAR observations
            2. updates map.log_odds and map.cells using occupied cells as shown by the LiDAR data

        Some notes about how to implement this.
            1. As mentioned in the writeup, for each particle
                (a) First find the head, neck angle at t (this is the same for every particle)
                (b) Project lidar scan into the world frame (different for different particles)
                (c) Calculate which cells are obstacles according to this particle for this scan,
                calculate the observation log-probability
            2. Update the particle weights using observation log-probability
            3. Find the particle with the largest weight, and use its occupied cells to update the map.log_odds and map.cells.
        You should ensure that map.cells is recalculated at each iteration (it is simply the binarized version of log_odds). map.log_odds is of course maintained across iterations.
        """
        #### TODO: XXXXXXXXXXX

        # calculate the head and neck angle
        joint_idx = s.find_joint_t_idx_from_lidar(s.lidar[t]["t"])

        neck_angle = s.joint["head_angles"][0][joint_idx]
        head_angle = s.joint["head_angles"][1][joint_idx]

        for p_i in range(s.n):
            # project particles into world coordinates
            z_t = s.rays2world(p = s.p[:, p_i], d = s.lidar[t]["scan"], head_angle = head_angle, 
                               neck_angle = neck_angle, angles = s.lidar_angles)
            
            O = s.map.grid_cell_from_xy(x = z_t[0], y = z_t[1])
            cleaned_O = np.unique(O, axis = 1) # to avoid overcounting

            obs_logp = np.sum(s.map.cells[cleaned_O[0], cleaned_O[1]])
        
        new_weights = s.update_weights(w = s.w, obs_logp = obs_logp)
        s.new = new_weights

        raise NotImplementedError

    def resample_particles(s):
        """
        Resampling is a (necessary) but problematic step which introduces a lot of variance
        in the particles. We should resample only if the effective number of particles
        falls below a certain threshold (resampling_threshold). A good heuristic to
        calculate the effective particles is 1/(sum_i w_i^2) where w_i are the weights
        of the particles, if this number of close to n, then all particles have about
        equal weights and we do not need to resample
        """
        e = 1/np.sum(s.w**2)
        logging.debug('> Effective number of particles: {}'.format(e))
        if e/s.n < s.resampling_threshold:
            s.p, s.w = s.stratified_resampling(s.p, s.w)
            logging.debug('> Resampling')
