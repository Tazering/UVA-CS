/*
	Name: Tyler Kim
	Computing Id: tkj9ep
	Date: 04/22/2022
	Filename: Node.h
*/

#ifndef NODE_H
#define NODE_H

using namespace std;

class Node {
	public:
	Node();
	~Node();

	char value;
	Node* left;
	Node* right;

	friend class Tree;
};

#endif
