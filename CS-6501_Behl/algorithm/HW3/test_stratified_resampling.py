import numpy as np
from slam import slam_t

def test_stratified_resampling():
    """
    Test the stratified_resampling method in slam_t.
    We’ll simulate different log-weight distributions and verify that resampling
    produces particles proportional to the weights.
    """
    print('> Testing stratified_resampling')

    # Test Case 1: Uniform log-weights
    print("\nTest Case 1: Uniform log-weights")
    N = 5  # Number of particles
    # Create particle states: [x, y, theta] for each particle
    # For simplicity, set x = index, y = 0, theta = 0
    p = np.zeros((3, N))
    p[0, :] = np.arange(N)  # x = [0, 1, 2, 3, 4]
    log_w = np.log(np.ones(N) / N)  # log(1/5) for each particle
    num_trials = 10000
    indices = np.zeros(N, dtype=np.int32)  # Count occurrences of each particle
    for _ in range(num_trials):
        new_particles, new_weights = slam_t.stratified_resampling(p, log_w)
        # Map new particles back to indices by looking at x-coordinate
        for x in new_particles[0, :]:
            idx = int(x)  # x-coordinate corresponds to original index
            indices[idx] += 1
        # Check new weights are uniform
        assert np.allclose(new_weights, np.ones(N) / N, atol=1e-6), "Weights should be uniform"
    empirical_probs = indices / (num_trials * N)
    expected_probs = np.ones(N) / N  # Should be uniform: 0.2 for each
    print(f"Empirical probabilities: {empirical_probs}")
    print(f"Expected probabilities: {expected_probs}")
    print(f"Match: {np.allclose(empirical_probs, expected_probs, atol=1e-2)}")

    # Test Case 2: Skewed log-weights
    print("\nTest Case 2: Skewed log-weights")
    probs = np.array([0.5, 0.25, 0.15, 0.05, 0.05])
    log_w = np.log(probs)
    indices = np.zeros(N, dtype=np.int32)
    for _ in range(num_trials):
        new_particles, new_weights = slam_t.stratified_resampling(p, log_w)
        for x in new_particles[0, :]:
            idx = int(x)
            indices[idx] += 1
        assert np.allclose(new_weights, np.ones(N) / N, atol=1e-6), "Weights should be uniform"
    empirical_probs = indices / (num_trials * N)
    expected_probs = probs
    print(f"Empirical probabilities: {empirical_probs}")
    print(f"Expected probabilities: {expected_probs}")
    print(f"Match: {np.allclose(empirical_probs, expected_probs, atol=1e-2)}")

    # Test Case 3: Extreme log-weights
    print("\nTest Case 3: Extreme log-weights")
    log_w = np.array([1000.0, 0.0, -1000.0, -2000.0, -3000.0])
    indices = np.zeros(N, dtype=np.int32)
    for _ in range(num_trials):
        new_particles, new_weights = slam_t.stratified_resampling(p, log_w)
        for x in new_particles[0, :]:
            idx = int(x)
            indices[idx] += 1
        assert np.allclose(new_weights, np.ones(N) / N, atol=1e-6), "Weights should be uniform"
    empirical_probs = indices / (num_trials * N)
    expected_probs = np.array([1.0, 0.0, 0.0, 0.0, 0.0])
    print(f"Empirical probabilities: {empirical_probs}")
    print(f"Expected probabilities: {expected_probs}")
    print(f"Match: {np.allclose(empirical_probs, expected_probs, atol=1e-2)}")

    # Test Case 4: Single non-zero weight
    print("\nTest Case 4: Single non-zero weight")
    log_w = np.array([0.0, -np.inf, -np.inf, -np.inf, -np.inf])
    indices = np.zeros(N, dtype=np.int32)
    for _ in range(num_trials):
        new_particles, new_weights = slam_t.stratified_resampling(p, log_w)
        for x in new_particles[0, :]:
            idx = int(x)
            indices[idx] += 1
        assert np.allclose(new_weights, np.ones(N) / N, atol=1e-6), "Weights should be uniform"
    empirical_probs = indices / (num_trials * N)
    expected_probs = np.array([1.0, 0.0, 0.0, 0.0, 0.0])
    print(f"Empirical probabilities: {empirical_probs}")
    print(f"Expected probabilities: {expected_probs}")
    print(f"Match: {np.allclose(empirical_probs, expected_probs, atol=1e-2)}")

if __name__ == "__main__":
    test_stratified_resampling()