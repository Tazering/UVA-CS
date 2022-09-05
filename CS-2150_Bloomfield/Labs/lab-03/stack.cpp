/* Name: Tyler Kim
 * Computing Id: tkj9ep
 * Date: 02/10/2022
 * Filename: stack.cpp
 */

#include "stack.h"
#include "stackNode.h"
#include "stackItr.h"
#include <iostream>

using namespace std;

//constructors and destructors
stack::stack() {
	head = new stackNode();
	tail = new stackNode();
	
	//set the memory addresses
	head -> next = tail;		

	(*tail).previous = head;

//	if((head -> next)== tail) {
//		cout << "Head correctly points to Tail!" << endl;
//	}

//	if((tail -> previous) == head) {
	
//		cout << "Tail correctly points Back to Head!"  << endl;
//	}	



	count = 0;
}

stack::~stack() {
	makeEmpty();
	delete head;
	delete tail;
}

//operations
void stack::push(int e) {

	stackNode *temp = new stackNode();
//	if((head -> next) == tail && (tail -> previous) == head) {
//		cout << "Head and Tail are good!" << endl;

//	}
	temp -> value = e;


	(tail -> previous) -> next = temp;
	temp -> next = tail;
	temp -> previous = (tail -> previous);
	tail -> previous = temp;

	count++;

}

void stack::pop() {
	if(empty()) {
		cout << "No elements in the stack!" << endl;
		exit(-1);
	}	

	stackItr *itr = new stackItr(last());

	((itr -> current) -> previous) -> next = tail;
	itr -> moveBackward();

	delete tail -> previous;
	tail -> previous = itr -> current;
	count--;
	delete itr;
	
}


int stack::top() {
	if(empty()) {
		cout << "No elements in the stack!" << endl;
		exit(-1);	
		return 0;
	}

	stackItr temp = last();
	return temp.retrieve();
}

bool stack::empty() {
	return size() == 0;
}


void stack::makeEmpty() {
	for(int i = 0; i < size(); i++) {
		pop();
	}	
	count = 0;
}

stackItr stack::last() {
	stackItr temp = stackItr(tail -> previous);

	return temp;
}

int stack::size() const {
	return count;
}

void stack::printList() {
	stackItr stackItr1 = last();
	for(int i = 0; i < size(); i++) {
		cout << stackItr1.retrieve() << endl;
		stackItr1.moveBackward();
	}
}
