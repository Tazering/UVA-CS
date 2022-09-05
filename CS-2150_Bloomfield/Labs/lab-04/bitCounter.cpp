/* Name: Tyler Kim
*  Computing Id: tkj9ep
*  Date: 02/17/2022
*  Filename: bitCounter.cpp
*/

#include <iostream>
#include <string>
#include <math.h>
#include <typeinfo>

using namespace std;

//Main Method
int main(int argc, char *argv[]) {
	//prototyping functions
	int binaryBitCounter(int n);
	string baseConvertor(string n, int startBase, int endBase);
	
	//if there are no in-line command parameters
	if(argc == 1) {
		cout << "Need parameters. Exiting..." << endl;
		exit(-1);
	}

	//deployment
	int bitCount = stoi(argv[1]);
	int binaryBitCounterOutput = binaryBitCounter(bitCount);
	cout << bitCount  << " has " << binaryBitCounterOutput << " bit(s)" << endl;

	//testing convertor
	string valueToConvert = argv[2];
	int startBase = stoi(argv[3]);
	int endBase = stoi(argv[4]);
	string dummy = baseConvertor(valueToConvert, startBase, endBase);

	cout << argv[2] << " (base " << startBase << ") = " << dummy << " (base " << endBase << ")" << endl;

	return 0;
}

/* function binaryBitCounter() takes in a non-negative int that will be stored in two's complement.
*  This function will count the number of 1's in the binary representation of a value.
*  This function will be recursive.
*  The number of 1's in an even number is n/2 and floor(n/2) for odd.
*/
int binaryBitCounter(int n) {
	int count = 0;

	//base case
	if(n == 0) {
		return 0;

	} else { //recursive case
		return binaryBitCounter(n/2) + (n % 2);
	}
}


/* The function baseConvertor() will take in three command-line parameters:
*  (string) number to convert, (int) start base (int) end base.
*  All inputs will be capitalized and bases will be between 1 and 36.
*/
string baseConvertor(string n, int startBase, int endBase) {
	//step 1: convert to base 10
	int baseTenValue = 0;

	for(int i = 0; i < n.length(); i++) { //loop through each character in the string
		//check if the char is a number
		if(isdigit(n[i])) {
			
			baseTenValue += (n[i] - 48) * pow(startBase, n.length() - 1 - i);

		} else { //if the char is a letter

			baseTenValue += (n[i] - 55) * pow(startBase, n.length() - 1 - i);
		
		}
	}

//	cout << "Decimal number is: " << baseTenValue << endl;

	//step 2: convert base 10 to end base
	string concatOutput = "";
	string output = "";

	//special case: base 1
	if(endBase == 1) {
		
		for(int i = 0; i < baseTenValue; i++) {
			output = output + "1";
		}

		return output;
	}

	while(baseTenValue != 0) {
		//set a temporary int value to be the mod of the endbase
		int temp = baseTenValue % endBase;
		
		//helps distinguish whether a letter needs to be used
		if(temp > 9) {

			char charToAppend = char(temp + 55);
			concatOutput = concatOutput + charToAppend;

		} else {
			concatOutput = concatOutput + to_string(temp);
		}

		//divide by endBase
		baseTenValue /= endBase;

	}

		//reverse the string
	for(int i = concatOutput.length(); i > 0; i--) {
		output = output + concatOutput.substr(i - 1, 1);
	}

	return output; 
}

