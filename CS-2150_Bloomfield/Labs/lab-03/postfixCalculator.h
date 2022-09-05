/* Name: Tyler Kim
 * Computing Id: tkj9ep
 * Date: 02/06/2022
 * Filename: postfixCalculator.h
 */

#ifndef POSTFIXCALCULATOR_H
#define POSTFIXCALCULATOR_H
#include "stack.h"
#include <string>

using namespace std;

class postfixCalculator {

	public:
		//constructor and destructor
		postfixCalculator();
		~postfixCalculator();

		//main operations
		int calculate(string expression);

		//operations
		int addition();
		int subtraction();
		int multiplication();
		int division();
		int unaryNegation();
		stack calcStack;
		
	private:
		
		int sum;
			

};
#endif
