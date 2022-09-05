/*
	Name: Tyler Kim
	Computing Id: tkj9ep
	Date: 04/19/2022
	Filename: heap.h
*/

#ifndef BINARY_HEAP_H
#define BINARY_HEAP_H

#include <vector>
#include "heapNode.h"
using namespace std;
class heap {
	public: 
	heap();
	heap(vector<heapNode*> vec);
	~heap();

	void insert(heapNode* node);
	heapNode* findMin();
	heapNode* deleteMin();
	unsigned int size();
	void print() const;
	void buildTree();
	vector<heapNode*> theHeap;

	private:

		unsigned int heap_size;
		void percolateUp(int hole);
		void percolateDown(int hole);
};

#endif
