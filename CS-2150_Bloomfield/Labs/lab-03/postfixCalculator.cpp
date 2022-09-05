/* Name: Tyler kim
 * Computing Id: tkj9ep
 * Date: 02/07/2022
 * Filename: postfixCalculator.cpp
 */

#include "postfixCalculator.h"
#include <iostream>
#include "stack.h"
#include <string>


using namespace std;

//constructor and destructor
postfixCalculator::postfixCalculator() {
//	calcStack = stack();

}

postfixCalculator::~postfixCalculator() {

}

//operations
int postfixCalculator::addition() {
	int x = calcStack.top();
	calcStack.pop();

	int y = calcStack.top();
	calcStack.pop();

	int value = (x + y);
	calcStack.push(value);

	return value; 
}

int postfixCalculator::subtraction() {
	int x = calcStack.top();
	calcStack.pop();

	int y = calcStack.top();
	calcStack.pop();

	int value = (y - x);
	calcStack.push(value);

	return value;
}

int postfixCalculator::multiplication() {
	int x = calcStack.top();
	calcStack.pop();

	int y = calcStack.top();
	calcStack.pop();

	int value = (y * x);
	calcStack.push(value);
	return value;
}

int postfixCalculator::division() {
	int x = calcStack.top();
	calcStack.pop();

	int y = calcStack.top();
	calcStack.pop();

	int value = (y / x);
	calcStack.push(value);
	
	return value;
}

int postfixCalculator::unaryNegation() {
	int x = calcStack.top();
	calcStack.pop();

	int value = (x * -1);
	calcStack.push(value);

	return value;
}

