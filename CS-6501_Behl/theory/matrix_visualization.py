import numpy as np

def main():

    TR = np.array([[.1, .9, 0, 0], [0, 1, 0, 0], [0, 0, 1, 0], [0, 0, .9, .1]])
    TU = np.array([[1, 0, 0, 0], [0, 1, 0, 0], [0, 0.9, .1, 0], [0.9, 0, 0, .1]])

    print(visualize_matrix_multiplication(TR, TU))
    return 0

# visualize matrix multiplication
def visualize_matrix_multiplication(a, b):
    final_matrix = []

    # assume a.shape = b.shape
    for x in range(a.shape[0]):
        row = []

        for y in range(b.shape[1]):
            row.append(f"({a[x][y]})({b[x][y]})")
    
        final_matrix.append(row)

    return np.array(final_matrix)

main()