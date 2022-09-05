/* Name: Tyler Kim
 * Computing Id: tkj9ep
 * Date: 02/10/2022
 * Filename: stackItr.cpp
 */

#include "stackNode.h"
#include "stack.h"
#include <iostream>

using namespace std;

//constructors and destructors
stackItr::stackItr() {
	current = NULL;	
}

stackItr::stackItr(stackNode* theNode){
	current = theNode;	
}

bool stackItr::isPastBeginning() const {
	if((current -> previous) == NULL) {
		return true;
	}
	return false;
}

void stackItr::moveBackward() {
	if(!isPastBeginning()) {
		current = (current -> previous);
	} else {
	
	}
}

int stackItr::retrieve() const {
	return current -> value;
}
