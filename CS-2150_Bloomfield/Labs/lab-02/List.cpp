/* Name: Tyler Kim
 * Computing Id: tkj9ep 
 * Date: 01/29/2022
 * Filename: List.cpp
 */

#include "List.h"
#include "ListNode.h"
#include "ListItr.h"
#include <iostream>
#include <string>

using namespace std;


//constructors
List::List() {
	//set head and tail as dummy nodes
	head = new ListNode();
	tail = new ListNode();

	//testing
//	head -> value = 69;
//	tail -> value = 666;

	//set the head nodes' "next" variable to the tail pointer and vice versa
	head -> next = tail;
	(*tail).previous = head;

	//set count to 0
	count = 0;
}

List::List(const List& source) {
	
	//set head and tail as dummy nodes
	head = new ListNode();
	tail = new ListNode();

	//set the head nodes' "next" variable to the tail pointer and vice versa
	head -> next = tail;
	(*tail).previous = head;

	//set count to 0
	count = 0;

	//make deep copy of list
	ListItr iter(source.head -> next);
	while (!iter.isPastEnd()) {
		insertAtTail(iter.retrieve());
		iter.moveForward();
	}

}

//destructor
List::~List() {
	//empty list
	makeEmpty(); 
	delete head;
	delete tail;
}

//copy constructor
List& List::operator=(const List& source) {
	if(this == &source) {
		return *this;
	} else {
		makeEmpty();

		ListItr iter(source.head -> next);
		while(!iter.isPastEnd()) {
			insertAtTail(iter.retrieve());
			iter.moveForward();
		}
	}
		
	return *this;
}

//check if the list is empty
bool List::isEmpty() const {
	return (count == 0);
}

//empties the list
void List::makeEmpty() {
	for(int i = 0; i < count; i++) {
		//step 1: move head node's "next" to next node
		head -> next = ((head -> next) -> next);

		//step 2: delete node
		delete (head -> next) -> previous;

		//step 3: move next node's "previous" to head
		(head -> next) -> previous = head;
	}

	count = 0;
}

//returns iterator
ListItr List::first() {
	ListItr temp = ListItr((head -> next));
//	cout << "Starting value is: " << (temp -> current) -> value << endl;
	return temp; 
}

ListItr List::last() {
	ListItr temp = ListItr((tail -> previous));
//	cout << "Ending value is: " << (temp -> current) -> value << endl;
 	return temp; 
}

//insertion
void List::insertAfter(int x, ListItr position) {
	//make a new ListNode with value x
	ListNode *temp = new ListNode();
	temp -> value = x;

	//check if the node is the dummy tail
	if((position.current) -> next != NULL) {
	
		//step 1: previous of front node connects to new node
		((position.current) -> next) -> previous  = temp;
		
		//step 2: connect new node's "previous" to position node
		temp -> previous = position.current;

		//step 3: connect new node's "next" to front node
		temp -> next = (position.current) -> next;

		//step 4: connect position node's "next" to new node
		(position.current) -> next = temp;

		count++;
	}	

}

void List::insertBefore(int x, ListItr position) {
	//make a new ListNode with value x
	ListNode *temp = new ListNode();
	temp -> value = x;

	//check if the node is the dummy head
	if((position.current) -> previous != NULL) {
		
		//step 1: move back node's "next" to new node
		((position.current) -> previous) -> next = temp;

		//step 2: move new node's "next" to position node
		temp -> next = position.current;

		//step 3: move new node's "previous" to back node
		temp -> previous = ((position.current) -> previous);

		//step 4: move position node's "previous" to new node
		(position.current) -> previous = temp;
	
		count++;
	}

}

void List::insertAtTail(int x) {
	//create a temporary node pointer called temp and initializes default constructor of ListNode
	ListNode *temp = new ListNode();
	temp -> value = x;

	//temporary for testing
//	head -> value = 69;
//	tail -> value = 666;

	//step 1: set previous node "next" pointer to temp
	(tail -> previous) -> next = temp; 
	
	//step 2: set temp's "previous" pointer the previous node
	temp -> previous = (tail -> previous);

	//step 3: set tail node's "previous" to temp node
	tail -> previous = temp;
		
	//step 4: set temp node's "next" to tail node
	temp -> next = tail;

	//step 5: update counter
	count++;

	//testing purpose only
//	if(((head -> next) -> value) == (temp -> value) ) {
//		cout << "Steps 1 and 2 passed" << "\n";
//	} else {
//		cout << "Review" << endl;
//	}
//
//	if(((tail -> previous) -> value) == (temp -> value)) {
//		cout << "Steps 3 and 4 passed" << "\n";
//	} else {
//		cout << "Review" << endl;
//	}
}

//operations
ListItr List::find(int x) {
	//declare new ListItr starting at the head
	ListItr finder = ListItr(head -> next);
	
	//loop through all the nodes
	while(!(finder.isPastEnd())) {
		//check if the current node value is x
		if((finder.retrieve()) == x) {
			return finder;
		} 
		
		finder.moveForward();	
	}
	return finder;
}

void List::remove(int x) {
	//declare a new iterator that finds the element
	ListItr *iterator = new ListItr(find(x)); 
	
	//proceed if iterator is not at the end
	if(!(iterator -> isPastEnd())) {
		//step 1: move previous node's "next" to next node
		((iterator -> current) -> previous) -> next = (iterator -> current) -> next;

		//step 2: move iterator back
		iterator -> moveBackward();

		//step 3: delete the target node
		delete ((iterator -> current) -> next) -> previous;

		//step 4: move next node's "previous" to previous node
		((iterator -> current) -> next) -> previous = iterator -> current;
		
		//step 5: reduce count by 1
		count--;
	
	}

	delete iterator;
}

int List::size() const {

	return count; 
}

void printList(List& source, bool forward) {
	//make a copy constructor 
	List l1 = source;

	//print forwards
	if(forward) {
		ListItr l1ListItr = (l1.first()); //initialize a a new list iterater that has the head as the "current"

		for(int i = 0; i < (l1.size()); i++){
			cout << (l1ListItr.retrieve()) << " ";
			l1ListItr.moveForward();
		}

		
	} else {
	
		ListItr l1ListItr = (l1.last()); // initailizes a new list iterator where the tail is the "current"

		for(int i = 0; i < (l1.size()); i++) {
			cout << (l1ListItr.retrieve()) << " ";
			l1ListItr.moveBackward();
		}
		
	}

	cout << "\n" << endl;

}
