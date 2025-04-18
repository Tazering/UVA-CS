import numpy as np
import matplotlib.pyplot as plt
from slam import slam_t

def test_rays2world_complex():
    slam = slam_t()
    slam.lidar_dmin = 0.1
    slam.lidar_dmax = 10.0
    slam.lidar_height = 0.0
    slam.lidar_angles = np.linspace(-np.pi / 2, np.pi / 2, 180)

    d = np.ones_like(slam.lidar_angles) * 5.0  # all rays at fixed distance
    poses = [
        ("Origin (0,0,0)", np.array([0.0, 0.0, 0.0])),
        ("Translated (2,2,0)", np.array([2.0, 2.0, 0.0])),
        ("Rotated (0,0,π/4)", np.array([0.0, 0.0, np.pi / 4])),
        ("Rotated + Translated", np.array([3.0, 1.0, -np.pi / 2]))
    ]

    fig, axes = plt.subplots(2, 2, figsize=(12, 12))
    axes = axes.flatten()

    for i, (label, pose) in enumerate(poses):
        rays_world = slam.rays2world(
            p=pose,
            d=d,
            head_angle=0.0,
            neck_angle=0.0,
            angles=slam.lidar_angles
        )

        ax = axes[i]
        ax.plot(rays_world[0], rays_world[1], '.', label="Ray Endpoints", markersize=1)
        ax.plot(pose[0], pose[1], 'ro', label="Robot Pose")
        ax.set_title(f"{label}")
        ax.set_aspect('equal')
        ax.grid(True)
        ax.set_xlabel('x (m)')
        ax.set_ylabel('y (m)')
        ax.legend()

    plt.suptitle("Test: rays2world() with Complex Poses", fontsize=16)
    plt.tight_layout()
    plt.show()

if __name__ == "__main__":
    test_rays2world_complex()
