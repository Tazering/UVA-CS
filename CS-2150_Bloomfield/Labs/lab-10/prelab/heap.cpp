/*
	Name: Tyler Kim
	Computing Id: tkj9ep
	Date: 04/19/2022
	Filename: heap.cpp
*/

#include <iostream>
#include "heap.h"
#include "heapNode.h"
#include <vector>


using namespace std;

//constructors and destructor
heap::heap() {
	heap_size = 0;	
	theHeap.push_back(NULL);
}

heap::heap(vector<heapNode*> vec) {
	theHeap = vec;
	heap_size = vec.size();
	theHeap.push_back(NULL);
	for(int i = heap_size/2; i > 0; i--) {
		percolateDown(i);
	}

}

heap::~heap() {

}

//functions
void heap::insert(heapNode* node) {
	theHeap.push_back(node);

	percolateUp(++heap_size);
//	heap_size++;
}

heapNode* heap::findMin() {


	return theHeap[1];
}

heapNode* heap::deleteMin() {
	if(heap_size == 0) {
		throw "deleteMin() called on empty heap";
	}
	
	heapNode* ret = theHeap[1];

	theHeap[1] = theHeap[heap_size--];
	
	theHeap.pop_back();

	if(heap_size != 0) {
		percolateDown(1);
	}


	return ret;
}

unsigned int heap::size() {
	return heap_size;
}

void heap::print() const { 	
	for(int i = 1; i <= heap_size; i++) {
		cout << theHeap[i] -> character << " ";
//		bool isPow2 = (((i+1) & ~(i))==(i+1)) ? i+1 : 0;
//		if(isPow2) {
//			cout << endl << "\t";
//		}	
	}	
	cout << endl;
}

void heap::percolateUp(int hole) {
	heapNode* xNode = theHeap[hole];
	
	for( ; (hole > 1) && (xNode -> frequency < theHeap[hole/2] -> frequency); hole /= 2) {
		theHeap[hole] = theHeap[hole/2];
	}

	theHeap[hole] = xNode;
	

}

void heap::percolateDown(int hole) {
	heapNode* x = theHeap[hole];
	
	while(hole * 2 <= heap_size) {
		int child = hole*2;

		if((child + 1 <= heap_size) && (theHeap[child+1] -> frequency < theHeap[child] -> frequency)) {
			child++;
		}

		if(x -> frequency > theHeap[child] -> frequency) {
			theHeap[hole] = theHeap[child];
			hole = child;
		} else {
			break;
		}
	}

	theHeap[hole] = x;
}

void heap::buildTree() {
	while(heap_size > 1) {
		heapNode* dummyNode = new heapNode();		

		heapNode* firstNode = deleteMin();
		heapNode* secondNode = deleteMin();
				
		if(firstNode -> frequency > secondNode -> frequency) {
			dummyNode -> right = firstNode;
			dummyNode -> left = secondNode;
		} else {
			dummyNode -> right = secondNode;
			dummyNode -> left = firstNode;
		}

		dummyNode -> frequency = (firstNode -> frequency) + (secondNode -> frequency);

		insert(dummyNode);
	}
}
