from slam import slam_t
import numpy as np

def test_log_odds_update():
    slam = slam_t(resolution=1.0)
    slam.init_particles(n=1)
    slam.p[:, 0] = [0, 0, 0]

    slam.w[:] = [1.0]

    slam.lidar = [{ "t": 0, "scan": np.array([1.0]) }]
    slam.joint = { "head_angles": [[0], [0]], "t": np.array([0]) }
    slam.find_joint_t_idx_from_lidar = lambda t: 0
    slam.lidar_dmin = 0.1
    slam.lidar_dmax = 5.0
    slam.lidar_angles = np.array([0])
    slam.lidar_log_odds_occ = 0.8
    slam.lidar_log_odds_free = -0.2

    def fake_rays2world(p, d, head_angle, neck_angle, angles):
        return np.array([[1], [0]])

    slam.rays2world = fake_rays2world

    slam.observation_step(0)

    occupied_idx = slam.map.grid_cell_from_xy(np.array([1.0]), np.array([0.0]))
    free_idx = slam.map.grid_cell_from_xy(np.array([0.0]), np.array([0.0]))

    assert slam.map.log_odds[occupied_idx[1][0], occupied_idx[0][0]] > 0.7, "Occupied cell log-odds should increase"
    assert slam.map.log_odds[free_idx[1][0], free_idx[0][0]] < -0.1, "Free cell log-odds should decrease"

test_log_odds_update()