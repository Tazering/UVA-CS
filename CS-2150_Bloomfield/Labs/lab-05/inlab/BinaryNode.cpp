/*  Name: Tyler Kim
/   Computing Id: tkj9ep
/   Date: 03/01/2022
/	Filename: BinaryNode.cpp
*/ 
#include "BinaryNode.h"
#include <string>
using namespace std;

BinaryNode::BinaryNode() {
    value = "?";
    left = NULL;
    right = NULL;
}

BinaryNode::~BinaryNode() {
    delete left;
    delete right;
    left = NULL;
    right = NULL;
}
