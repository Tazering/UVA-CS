import numpy as np
from slam import slam_t

def test_get_control():
    """
    Test the get_control method in slam_t.
    We’ll simulate LiDAR poses and compute the control in the robot's local frame.
    """
    print('> Testing get_control')

    # Initialize slam_t object
    slam = slam_t(resolution=0.05)

    # Test Case 1: t=0, should return zeros
    print("\nTest Case 1: t=0 (edge case)")
    slam.lidar = [{"t": 0, "xyth": np.array([0, 0, 0])}]  # Dummy data
    control = slam.get_control(t=0)
    expected = np.array([0, 0, 0])
    print(f"Computed control: {control}")
    print(f"Expected control: {expected}")
    print(f"Match: {np.allclose(control, expected, atol=1e-5)}")

    # Set up LiDAR data for remaining tests
    slam.lidar = [
        {"t": 0, "xyth": np.array([0, 0, 0])},
        {"t": 1, "xyth": np.array([1, 0, 0])},  # Move 1m forward
        {"t": 2, "xyth": np.array([1, 0, np.pi/2])},  # Rotate pi/2
        {"t": 3, "xyth": np.array([2, 0, np.pi/2 + np.pi/4])}  # Move 1m forward, rotate pi/4
    ]

    # Test Case 2: Translation only (t=1)
    print("\nTest Case 2: Translation only (move 1m forward)")
    control = slam.get_control(t = 1)    
    expected = np.array([1, 0, 0])
    print(f"Computed control: {control}")
    print(f"Expected control: {expected}")
    print(f"Match: {np.allclose(control, expected, atol=1e-5)}")

    # Test Case 3: Rotation only (t=2)
    print("\nTest Case 3: Rotation only (rotate pi/2)")
    control = slam.get_control(t=2)
    expected = np.array([0, 0, np.pi/2])
    print(f"Computed control: {control}")
    print(f"Expected control: {expected}")
    print(f"Match: {np.allclose(control, expected, atol=1e-5)}")

    # Test Case 4: Combined motion (t=3)
    print("\nTest Case 4: Combined motion (move 1m forward in world frame, rotate pi/4)")
    control = slam.get_control(t=3)
    # From (1, 0, pi/2) to (2, 0, 3pi/4), θ_{t-1}=pi/2
    # R^T = [[0, -1], [1, 0]]
    # World displacement: [1, 0]
    # Local displacement: R^T * [1, 0] = [0, -1]
    # Δθ = pi/4
    expected = np.array([0, -1, np.pi/4])
    print(f"Computed control: {control}")
    print(f"Expected control: {expected}")
    print(f"Match: {np.allclose(control, expected, atol=1e-5)}")

if __name__ == "__main__":
    test_get_control()