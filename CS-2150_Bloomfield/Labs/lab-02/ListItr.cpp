/* Name: Tyler Kim
 * Computing Id: tkj9ep
 * Date: 01/29/2022
 * Filename: ListItr.cpp
 */

#include "ListNode.h"
#include "List.h"
#include <iostream>

using namespace std;

//Constructors
ListItr::ListItr() {
	current = NULL;
}

ListItr::ListItr(ListNode* theNode) {
	current = theNode;
	//testing

}

//boolean operations
bool ListItr::isPastEnd() const {
	//test if the current node's "next" value is NULL
	if((current -> next) == NULL) {

		return true;
	}
 	return false;
}

bool ListItr::isPastBeginning() const {
	//test if the current node's "previous" value is NULL
	if((current -> previous) == NULL) {
		return true;
	}
	return false;
}

//void methods
void ListItr::moveForward() {
	if(!isPastEnd()) {
		current = (current -> next);
	//	cout << "Forward value is: "  << (current -> value) << endl;
	} else {
	//	cout << "Already at end of list!" << endl;
	}

}

void ListItr::moveBackward() {
	if(!isPastBeginning()) {
		current = (current -> previous);
	//	cout << "Backward value is: "  << (current -> value) << endl;
	} else {
	//	cout << "Already at beginning of list!" << endl;
	}

}

//others
int ListItr::retrieve() const {
  return (current -> value);
}


