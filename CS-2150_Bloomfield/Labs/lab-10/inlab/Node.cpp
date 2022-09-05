/*
	Name: Tyler Kim
	Computing Id: tkj9ep
	Date: 04/22/2022
	Filename: Node.cpp
*/

#include "Node.h"

using namespace std;

Node::Node() {
	value = '?';
	left = nullptr;
	right = nullptr;
} 

Node::~Node() {
	delete right;
	delete left;
	left = nullptr;
	right = nullptr;
}
