/* Name: Tyler Kim
 * Computing Id: tkj9ep
 * Date: 02/07/2022
 * Filename: testPostfixCalc.cpp
 */

#include <iostream>
using namespace std;

#include "postfixCalculator.h"

int main() {
	int sum = 0;
	string token;
	postfixCalculator calculator;
	while (cin >> token) {	
	if(token == "+") {
		sum = calculator.addition();	


		} else if(token == "-") {
			sum = calculator.subtraction();

//		
		} else if(token == "*") {
			sum = calculator.multiplication();
//		
		} else if(token == "/") {
			sum = calculator.division();
//		
		} else if(token == "~") {
			sum = calculator.unaryNegation();
//		
		} else {
//
//
//			//push number to stack
			calculator.calcStack.push(stoi(token));
		}


	}

	cout << sum << endl;

	return 0;
}
