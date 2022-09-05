/* Name: Tyler Kim
 * Computing Id: tkj9ep
 * Date: 02/10/2022
 * Filename: stackItr.h
 */

#ifndef STACKITR_H
#define STACKITR_H

#include "stackNode.h"
#include "stack.h"

class stackItr {
	public:
		//constructors and destructors
		stackItr();
		stackItr(stackNode* theNode);

		bool isPastBeginning() const;

		void moveForward();

		void moveBackward();
		int retrieve() const;
	
	private:
		stackNode* current;

		friend class stack;
};
#endif
