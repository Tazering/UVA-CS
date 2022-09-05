/*
	Name: Tyler Kim
	Computing Id: tkj9ep
	Date: 04/12/2022
	Filename: threexinput.cpp
*/

#include <iostream>
#include <cstdlib>

using namespace std;

extern "C" long threexplusone (long);

int main() {
	int x = 0;
	int n = 0;
	int initialCount = 0;

	cout << "Enter a number: ";
	cin >> x;

	cout << "Enter iterations of subroutine: ";
	cin >> n;

	long count = threexplusone(x);
	initialCount = count;

	for(int i = 0; i < n; i++) {
		long count = threexplusone(x);
		initialCount = count;
	}

	cout << "Steps: " << initialCount << endl;
	
	return 0;
}
