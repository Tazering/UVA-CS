/* Name: Tyler Kim
 * Computing Id: tkj9ep
 * Date: 02/10/2022
 * Filename: stack.h
 */

#ifndef STACK_H
#define STACK_H

#include <iostream>
#include "stackNode.h"
#include "stackItr.h"

using namespace std;

class stackItr;

class stack {
	public:
		//constructors/destructors
		stack();
		~stack();

		//operations
		void push(int e);
		void pop();
		int top();
		bool empty();
		
		void makeEmpty();

		stackItr last();
		int size() const;
		void printList();

	private:
		stackNode* head;
		stackNode* tail;
		int count;
		
};
#endif
