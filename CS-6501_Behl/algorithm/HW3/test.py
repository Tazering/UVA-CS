import numpy as np
from slam import slam_t
import matplotlib.pyplot as plt

# s = slam_t()
# p = np.array([1.0, 2.0, np.pi/4])  # Particle at (1, 2) with 45° yaw
# d = np.ones(1081) * 1.0  # 1m distance for all rays
# head_angle = 0.1
# neck_angle = -0.2
# points = s.rays2world(p, d, head_angle, neck_angle, angles = s.lidar_angles)
# print(points.shape)  # Should be (2, 1081)
# plt.scatter(points[0, :], points[1, :])
# plt.axis('equal')
# plt.show()


# import numpy as np
# s = slam_t()
# s.n = 3
# s.w = np.ones(s.n) / s.n  # [1/3, 1/3, 1/3]
# obs_logp = np.array([-200, -201, -202])
# new_w = s.update_weights(s.w, obs_logp)
# print(new_w)
# print(np.sum(new_w))  # Should be 1

import numpy as np
N = 4
s = slam_t()
p = np.array([[0.1, 0.2, 0.3, 0.4], [0.5, 0.6, 0.7, 0.8], [0, 0, 0, 0]])
w = np.array([0.4, 0.3, 0.2, 0.1])
p_new, w_new = s.stratified_resampling(p, w)
print("Resampled particles:\n", p_new.T)
print("Resampled weights:", w_new)