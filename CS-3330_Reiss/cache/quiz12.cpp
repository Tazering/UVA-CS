#include <iostream>
#include <string>

using namespace std;

int main(int argc, char* argv[]) {
    void versionA(int N);
    void versionB(int N);
    void versionC(int N);

    // argv[1] which version
    // argv[2] N value

    int version = stoi(argv[1]);
    string Nchar = argv[2];
    int N = stoi(Nchar);

    switch(version) {
        case 0:
            cout << "Running Version A: " << endl;
            versionA(N);
        break;

        case 1:
            cout << "Running Version B: " << endl;
            versionB(N);
        break;

        case 2:
            cout << "Running Version C: " << endl;
            versionC(N);
        break;

        default:
        break;
    }

    return 0;
}

// version A
void versionA(int N) {
    int iteration = 0;
    for (int i = 0; i < N; i += 1) {
        for (int j = 0; j < i; j += 1) {
            /* note that this loop runs 1 + 2 + 3 + .. + N-2 = approx. (N^2)/2 times */
            //A[i * N + j] = D[j * N + i] + E[i * N + j] + B[i] * C[j];
            cout << "Iteration: " + to_string(iteration) + " where i and j are " + to_string(i) + ", " + to_string(j)<< endl;
            cout << "Index A: " + to_string(i) + "n" + " + " + to_string(j) << endl;
            cout << "Index B: " + to_string(i) << endl;
            cout << "Index C: " + to_string(j) << endl;
            cout << "Index D: " + to_string(j) + "n" + " + " + to_string(i) << endl;
            cout << "Index E: " + to_string(i) + "n" + " + " + to_string(j) << endl;
	    cout << "\n";	
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
            cout << "Iteration: " + to_string(iteration) + " where i and j are " + to_string(i) + ", " + to_string(j)<< endl;
            cout << "Index A: " + to_string(i) + "n" + " + " + to_string(j) << endl;
            cout << "Index B: " + to_string(i) << endl;
            cout << "Index C: " + to_string(j) << endl;
            cout << "Index D: " + to_string(j) + "n" + " + " + to_string(i) << endl;
            cout << "Index E: " + to_string(i) + "n" + " + " + to_string(j) << endl;
            cout << "\n";
	    iteration++;
        }
    }
}

//test
void versionC(int N) {
    int iteration = 0;
    for(int i = 0; i < N; i++) {
        for(int j = 0; j < N; j++) {
            cout << "Iteration: " + to_string(iteration) + " where i and j are " + to_string(i) + ", " + to_string(j) << endl;
            cout << "Index A: " + to_string(i) << endl;
            cout << "Index B: " + to_string(j) << endl;
            cout << "Index C: " + to_string(i) + "n + " + to_string(j) << endl;
            cout << "\n";
            iteration++;
        }
    }
}

