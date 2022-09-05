#include <iostream>

using namespace std;

int main() {
	int function(int value);

	int x = 40;
	
	cout << "Number of steps is: " << function(x) << endl;

	return 0;
}

int function(int value) {

	if(value == 1) {
		return 0;
	}
	
	
	if(value % 2 == 0) {
		return 1 + function(value/2);

	} else {
		return 1 + function((3 * value) + 1);

	}

	return 0;

}
