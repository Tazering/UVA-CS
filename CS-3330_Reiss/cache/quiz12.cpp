#include <iostream>
using namespace std;

int main() {
    void versionA(int N);
    void versionB(int N);

    versionB(5);

    return 0;
}

// version A
void versionA(int N) {
    int iteration = 0;
    for (int i = 0; i < N; i += 1) {
        for (int j = 0; j < i; j += 1) {
            /* note that this loop runs 1 + 2 + 3 + .. + N-2 = approx. (N^2)/2 times */
            //A[i * N + j] = D[j * N + i] + E[i * N + j] + B[i] * C[j];
            cout << "Iteration: " + to_string(iteration) << endl;
            cout << "Index A: " + to_string(i) + "n" + " + " + to_string(j) << endl;
            cout << "Index B: " + to_string(i) << endl;
            cout << "Index C: " + to_string(j) << endl;
            cout << "Index D: " + to_string(j) + "n" + " + " + to_string(i) << endl;
            cout << "Index E: " + to_string(i) + "n" + " + " + to_string(j) << endl;
            iteration++;
        }
    }
}

// version B
void versionB(int N) {
    int iteration = 0;

    for (int j = 0; j < N; j += 1) {
        for (int i = 0; i < j; i += 1) {
            /* note that this loop runs 1 + 2 + 3 + .. + N-2 = approx. (N^2)/2 times */
            //A[i * N + j] = D[j * N + i] + E[i * N + j] + B[i] * C[j];
            cout << "Iteration: " + to_string(iteration) << endl;
            cout << "Index A: " + to_string(i) + "n" + " + " + to_string(j) << endl;
            cout << "Index B: " + to_string(i) << endl;
            cout << "Index C: " + to_string(j) << endl;
            cout << "Index D: " + to_string(j) + "n" + " + " + to_string(i) << endl;
            cout << "Index E: " + to_string(i) + "n" + " + " + to_string(j) << endl;
            iteration++;
        }
    }
}
