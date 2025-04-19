from slam import slam_t, map_t
import numpy as np

class TestObservationStep:
    def __init__(self, slam_t, map_t):
        self.slam_t = slam_t
        self.map_t = map_t

    def make_mock_slam(self):
        slam = self.slam_t(resolution=1.0)
        slam.map = self.map_t(resolution=1.0)
        slam.init_particles(n=2)
        slam.find_joint_t_idx_from_lidar = lambda t: 0
        slam.joint = { "head_angles": [[0], [0]], "t": np.array([0]) }
        slam.lidar_angles = np.array([0])
        slam.lidar_dmin = 0.1
        slam.lidar_dmax = 5.0
        slam.lidar_log_odds_occ = 0.9
        slam.lidar_log_odds_free = -0.2
        return slam

    def test_observation_weights_update(self):
        slam = self.slam_t(resolution=1.0)
        slam.init_particles(n=2)
        slam.p[:, 0] = [0, 0, 0]
        slam.p[:, 1] = [2, 2, 0]
        slam.w[:] = [0.5, 0.5]
        slam.lidar = [{ "t": 0, "scan": np.array([2.0]) }]
        slam.joint = { "head_angles": [[0], [0]], "t": np.array([0]) }
        slam.find_joint_t_idx_from_lidar = lambda t: 0
        slam.lidar_dmin = 0.1
        slam.lidar_dmax = 5.0
        slam.lidar_angles = np.array([0])
        slam.map.cells[0, 2] = 1

        def fake_rays2world(p, d, head_angle, neck_angle, angles):
            if np.allclose(p[:2], [0, 0]):
                return np.array([[2], [0]])
            else:
                return np.array([[20], [20]])

        slam.rays2world = fake_rays2world
        slam.observation_step(0)
        print("\n--- DEBUG OUTPUT ---")
        for i in range(slam.n):
            # Project rays
            z = slam.rays2world(slam.p[:, i], d=np.array([1.0]), head_angle=0, neck_angle=0, angles=np.array([0.0]))
            y_o = slam.map.grid_cell_from_xy(z[0], z[1])
            
            print(f"Particle {i} at {slam.p[:, i]}")
            print(f"  Ray endpoint in world: {z.ravel()}")
            print(f"  Grid index hit: {y_o[:, 0]}")
            print(f"  Map value at hit cell: {slam.map.cells[y_o[1, 0], y_o[0, 0]]}")


        return slam.w

    def test_log_odds_update(self):
        slam = self.make_mock_slam()
        slam.p[:, 0] = [0, 0, 0]
        slam.w[:] = [1.0]
        slam.lidar = [{ "t": 0, "scan": np.array([1.0]) }]
        slam.rays2world = lambda p, d, head_angle, neck_angle, angles: np.array([[1], [0]])
        slam.observation_step(0)
        occupied_idx = slam.map.grid_cell_from_xy(np.array([1.0]), np.array([0.0]))
        free_idx = slam.map.grid_cell_from_xy(np.array([0.0]), np.array([0.0]))

        log_odds_occ = slam.map.log_odds[occupied_idx[1][0], occupied_idx[0][0]]
        log_odds_free = slam.map.log_odds[free_idx[1][0], free_idx[0][0]]

        return log_odds_occ, log_odds_free
    
tester = TestObservationStep(slam_t, map_t)
weights = tester.test_observation_weights_update()
log_occ, log_free = tester.test_log_odds_update()

print("Weights after observation:", weights)
print("Log odds (occupied):", log_occ)
print("Log odds (free):", log_free)

