#include <iostream>

using namespace std;

int main() {
	int baseAddress = 0;
	int arraySize;
	int index = 0;
	int one = 1;
	int zero = 0;
	int element;

	cin >> arraySize;
	int arr[arraySize];

	while(index < arraySize) {
		cin >> element;
		arr[index] = element;
		index++;
	}

	index = 0;

	while(index < arraySize) {
		cout << arr[index] << endl;
		index++;
	}

	while(index > 0) {
		index--;
		cout << arr[index] << endl;
	}

	return 0;
}
