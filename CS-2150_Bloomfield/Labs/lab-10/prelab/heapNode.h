/*
	Name: Tyler Kim
	Computing Id: tkj9ep
	Date: 04/19/2022
	Filename: heapNode.h
*/

#ifndef TREENODE_H
#define TREENODE_H

#include <iostream>

using namespace std;

class heapNode {
	public:
		heapNode();
		heapNode(char val);
		char character;
		int frequency;
		heapNode* left;
		heapNode* right;	
			
	private:
		
		
	
	friend class heap;
};

#endif
