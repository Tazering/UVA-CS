import numpy as np
from slam import map_t

def test_grid_cell_from_xy():
    """
    Test the grid_cell_from_xy method in map_t.
    We’ll create a small map and test coordinate conversions.
    """
    print('> Testing grid_cell_from_xy')

    # Initialize map_t object with a small map for testing
    map_obj = map_t(resolution=0.05)
    # Override map bounds for a smaller test map: -2.5 to 2.5
    map_obj.xmin, map_obj.xmax = -2.5, 2.5
    map_obj.ymin, map_obj.ymax = -2.5, 2.5
    map_obj.szx = int(np.ceil((map_obj.xmax - map_obj.xmin) / map_obj.resolution + 1))  # 101 cells
    map_obj.szy = int(np.ceil((map_obj.ymax - map_obj.ymin) / map_obj.resolution + 1))  # 101 cells
    map_obj.cells = np.zeros((map_obj.szx, map_obj.szy), dtype=np.int8)
    map_obj.log_odds = np.zeros((map_obj.szx, map_obj.szy), dtype=np.float64)
    map_obj.num_obs_per_cell = np.zeros((map_obj.szx, map_obj.szy), dtype=np.uint64)

    # Test Case 1: Points within bounds, including (0, 0)
    print("\nTest Case 1: Points within bounds")
    x = np.array([0, 1, -1])  # (0, 0), (1, 1), (-1, -1)
    y = np.array([0, 1, -1])
    indices = map_obj.grid_cell_from_xy(x, y)

    # Expected:
    # Map: -2.5 to 2.5, resolution=0.05 → 101 cells (indices 0 to 100)
    # (0, 0): x_rel = 0 - (-2.5) = 2.5, x_disc = 2.5/0.05 = 50 → (50, 50)
    # (1, 1): x_rel = 1 - (-2.5) = 3.5, x_disc = 3.5/0.05 = 70 → (70, 70)
    # (-1, -1): x_rel = -1 - (-2.5) = 1.5, x_disc = 1.5/0.05 = 30 → (30, 30)
    expected = np.array([[50, 70, 30], [50, 70, 30]])
    print(f"Input (x, y): {list(zip(x, y))}")
    print(f"Computed indices:\n{indices}")
    print(f"Expected indices:\n{expected}")
    print(f"Match: {np.allclose(indices, expected)}")

    # Test Case 2: Points at boundaries
    print("\nTest Case 2: Points at boundaries")
    x = np.array([-2.5, 2.5])  # Minimum and maximum bounds
    y = np.array([-2.5, 2.5])
    indices = map_obj.grid_cell_from_xy(x, y)

    # Expected:
    # (-2.5, -2.5): x_rel = -2.5 - (-2.5) = 0, x_disc = 0/0.05 = 0 → (0, 0)
    # (2.5, 2.5): x_rel = 2.5 - (-2.5) = 5, x_disc = 5/0.05 = 100 → (100, 100)
    expected = np.array([[0, 100], [0, 100]])
    print(f"Input (x, y): {list(zip(x, y))}")
    print(f"Computed indices:\n{indices}")
    print(f"Expected indices:\n{expected}")
    print(f"Match: {np.allclose(indices, expected)}")

    # Test Case 3: Points outside bounds
    print("\nTest Case 3: Points outside bounds")
    x = np.array([-3, 3])  # Beyond minimum and maximum bounds
    y = np.array([-3, 3])
    indices = map_obj.grid_cell_from_xy(x, y)

    # Expected:
    # (-3, -3): x_rel = -3 - (-2.5) = -0.5, x_disc = -0.5/0.05 = -10, clipped to (0, 0)
    # (3, 3): x_rel = 3 - (-2.5) = 5.5, x_disc = 5.5/0.05 = 110, clipped to (100, 100)
    expected = np.array([[0, 100], [0, 100]])
    print(f"Input (x, y): {list(zip(x, y))}")
    print(f"Computed indices:\n{indices}")
    print(f"Expected indices:\n{expected}")
    print(f"Match: {np.allclose(indices, expected)}")

if __name__ == "__main__":
    test_grid_cell_from_xy()