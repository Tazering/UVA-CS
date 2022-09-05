/* Name: Tyler Kim
 * Computing Id: tkj9ep
 * Date: 02/11/2022
 * Filename: prelab4.cpp
 */

#include <iostream>
#include <climits>
#include <math.h>
#include <string>

using namespace std;

int main() {

	//prototypes of functions
	void sizeOfTest();
	void overflow();
	void outputBinary(unsigned int x);

	// set up input to take one integer
	int x;
	cin >> x;

	//calls the functions
	sizeOfTest();
	overflow();
	outputBinary(x);

	return 0;
}

//Part 1: size of various datatypes
void sizeOfTest() {
	cout << "Size of int: " << sizeof(int) << endl;
	cout << "Size of unsigned int: " << sizeof(unsigned int) << endl;
	cout << "Size of float: " << sizeof(float) << endl;
	cout << "Size of double: " << sizeof(double) << endl;
	cout << "Size of char: " << sizeof(char) << endl;
	cout << "Size of bool: " << sizeof(bool) << endl;
	cout << "Size of int*: " << sizeof(int*) << endl;
	cout << "Size of char*: " << sizeof(char*) << endl;
	cout << "Size of double*: " << sizeof(double*) << endl;

}

//Part 2: overflow experiment
void overflow() {
	unsigned int maxValue = UINT_MAX;
	cout << UINT_MAX << " + 1 = " << (maxValue + 1) << endl;;
}

//Part 3: Binary number output
void outputBinary(unsigned int x) {
	string concatOutput = "";
	string parsedConcatOutput = "";
	string output = "";

	//calculate actual values
	for(int i = 0; i < 32; i++) {
		concatOutput = concatOutput + to_string(x % 2);
		x /= 2;
	}
	
	//parse string by groups of four
	for(int i = 0; i < (concatOutput.length()/4); i++) {
		parsedConcatOutput = parsedConcatOutput + concatOutput.substr(i * 4, 4) + " ";
	}

	//place reverse value in output
	for(int i = parsedConcatOutput.length(); i > 0; i--) {
		output = output + parsedConcatOutput.substr(i-1, 1); 
	}

	cout << output << endl;
}

