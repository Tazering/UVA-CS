#include <iostream>

using namespace std;

int main() {
	
	int x, y, z, sum = 0;
	int i = 1; 
	int s = 0;
	cin >> x;
	cin >> y;
	cin >> z;

	sum = sum + x;
	sum = sum + y;
	sum = sum + z;

	if(sum == 0) {
		cout << x << endl;
		cout << y << endl;
		cout << z << endl;
	} else {
		cout << sum << endl;

	}


	return 0;
}
