/*	Name: Tyler Kim
/	Computing Id: tkj9ep
/	Filename: mathfun.cpp
/	Date: 03/29/2022
*/

#include <iostream>
#include <cstdlib>

using namespace std;

extern "C" long product (int, int);
extern "C" long power (int, int);

int main() {
	
	long x, y = 0;

	cout << "Enter integer 1: ";
	cin >> x;
	cout << "Enter integer 2: ";
	cin >> y;
	
	long productValue = product(x, y);
	long powerValue = power(x, y);	
	cout << "Product: " << productValue << endl;
	cout << "Power: " << powerValue << endl;
	
	

	return 0;
}
