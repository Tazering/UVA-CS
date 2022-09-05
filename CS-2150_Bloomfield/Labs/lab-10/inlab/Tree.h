/*
	Name: Tyler Kim
	Computing Id: tkj9ep
	Date: 04/22/2022
	Filename: Tree.h
*/

#ifndef TREE_H
#define TREE_H

#include "Node.h"
#include <string>

using namespace std;

class Tree {
	public:
		Tree();
		~Tree();

		void insert(const char& val, string key);
		void printTree() const;
		void deleteMin();
		Node* root;
	
		void insert(const char& val, string key, Node* &node);
		void printTree(Node* node) const;

	
		

};

#endif
