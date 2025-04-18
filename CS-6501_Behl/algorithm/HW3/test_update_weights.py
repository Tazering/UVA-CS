import numpy as np
from slam import slam_t

def test_update_weights():
    # Prior weights (equal), in log-space
    w = np.log(np.array([1/3, 1/3, 1/3]))
    
    # Observation log-probabilities (simulate different particle likelihoods)
    obs_logp = np.array([-5.0, -1.0, -0.1])

    print(f"Initial log weights: {w}")
    print(f"Observation log-probabilities: {obs_logp}")

    # Run the function
    log_weights_new = slam_t.update_weights(w, obs_logp)
    weights_new = np.exp(log_weights_new)

    print(f"New log weights: {log_weights_new}")
    print(f"New normalized weights: {weights_new}")
    print(f"Sum of new weights: {np.sum(weights_new)}")

    # Basic checks
    assert np.all(weights_new >= 0), "Weights must be non-negative"
    assert np.isclose(np.sum(weights_new), 1.0), "Weights must sum to 1"

    # Heuristic check: third particle should have highest weight
    assert np.argmax(weights_new) == 2, "Particle with highest log-likelihood should have highest weight"

    print("✅ update_weights() passed all tests.")

if __name__ == "__main__":
    test_update_weights()
