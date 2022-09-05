/*
	Name: Tyler Kim
	Computing Id: tkj9ep
	Date: 04/22/2022
	Filename: Tree.cpp
*/

#include "Tree.h"
#include "Node.h"
#include <iostream>

using namespace std;

//constructors and destructors
Tree::Tree() {
	root = nullptr;
}

Tree::~Tree() {
	delete root;
	root = nullptr;
}

void Tree::insert(const char& val, string key) {
	insert(val, key, root);
}

void Tree::insert(const char& val, string key, Node* &node) {

	if(node == NULL) {
		node = new Node();

		if(key.length() == 0) {
			node -> value = val;
		}
	} 

		//recursive case
	if(key.length() != 0) {
		if(key[0] == '1') {
			insert(val, key.substr(1, key.length() - 1), node -> right);

		} else {
			insert(val, key.substr(1, key.length() - 1) , node -> left);

		}
	}
}

void Tree::printTree() const{
	printTree(root);
}

void Tree::printTree(Node* node) const{
	if(node == NULL) {
		return;
	}

	cout << node -> value << " ";

	printTree(node -> left);

	printTree(node -> right);
}

