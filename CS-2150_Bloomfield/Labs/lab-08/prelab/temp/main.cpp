#include <iostream>

using namespace std;

int main() {
	int x, y = 0;

	int product(int x, int y);
	int power(int x, int y);

	cout << "Enter integer 1: ";
	cin >> x;
	cout << "Enter Integer 2: ";
	cin >> y;

	cout << "\nProduct: " << product(x, y) << endl;
	cout << "Power: " << power(x, y) << endl;

	return 0;
}

int product(int x, int y) {
	int i = 0;
	int sum = 0;

	while(i < y) {
		sum = sum + x;
		i = i + 1;
	}

	return sum;
}

int power(int x, int y) {
	//base case
	if(y == 0) {
		return 1;
	}  // recursive case
		return x * power(x, y - 1);
}
