/*
	Name: Tyler Kim
	Computing Id: tkj9ep
	Date: 04/19/2022
	Filename: heapNode.cpp
*/

#include "heapNode.h"
#include <iostream>

heapNode::heapNode() {
	character = 'z';
	frequency = -1;
	left = NULL;
	right = NULL;
}

heapNode::heapNode(char val) {
	character = val;
	frequency = 0;
	left = NULL;
	right = NULL;
}
