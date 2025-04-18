import numpy as np
from slam import slam_t

def test_observation_step():
    print('> Testing observation_step')
    slam = slam_t(resolution=0.05)
    slam.N = 3
    slam.p = np.array([[0.2, 0.2, 0.1], [2.0, 0.4, 2.7], [3.0, 5.0, 4.0]])
    slam.w = np.log(np.ones(slam.N) / slam.N)
    slam.map = np.zeros((100, 100))
    slam.lidar = [{}]
    slam.lidar.append({'xyth': np.array([0.0, 0.0, 0.0])})

    print("\nTest Case 1: Observation step with scaled obs_logp")
    distances = np.sqrt(slam.p[0, :]**2 + slam.p[1, :]**2)
    obs_logp = -distances  # [-2.01, -0.447, -2.70]
    # Scale obs_logp to a range where update_weights works (e.g., max difference of 2)
    obs_logp = (obs_logp - np.min(obs_logp)) / (np.max(obs_logp) - np.min(obs_logp)) * 2  # Scale to [0, 2]
    print(f"Scaled obs_logp: {obs_logp}")
    # Expected: [0.628, 2.0, 0.0]
    slam.w = slam_t.update_weights(slam.w, obs_logp)
    print(f"Weights after update (log-space): {slam.w}")
    w_probs = np.exp(slam.w - slam_t.log_sum_exp(slam.w))
    print(f"Weights after update (probabilities): {w_probs}")
    expected_largest = 1
    largest_weight_idx = np.argmax(w_probs)
    print(f"Largest weight index: {largest_weight_idx}, Expected: {expected_largest}")
    print(f"Match: {largest_weight_idx == expected_largest}")

    print("\nTest Case 2: Observation step with resampling")
    ess = 1.0 / np.sum(w_probs ** 2)
    print(f"ESS: {ess}, Threshold: {slam.N / 2}")
    if ess < slam.N / 2:
        print("ESS below threshold, resampling...")
        slam.p, slam.w = slam_t.resample_particles(slam.p, slam.w)
    else:
        print("ESS above threshold, no resampling.")
    print(f"Particles after observation_step:\n{slam.p}")
    print(f"Weights after observation_step (probabilities): {np.exp(slam.w - slam_t.log_sum_exp(slam.w))}")
    if ess < slam.N / 2:
        expected_probs = np.ones(slam.N) / slam.N
        print(f"Expected weights (probabilities): {expected_probs}")
        print(f"Match: {np.allclose(np.exp(slam.w - slam_t.log_sum_exp(slam.w)), expected_probs, atol=1e-6)}")
    else:
        largest_weight_idx = np.argmax(np.exp(slam.w - slam_t.log_sum_exp(slam.w)))
        print(f"Largest weight index: {largest_weight_idx}, Expected: {expected_largest}")
        print(f"Match: {largest_weight_idx == expected_largest}")

if __name__ == "__main__":
    test_observation_step()