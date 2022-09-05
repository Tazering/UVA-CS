 /*	Name: Tyler Kim
 /	Computing Id: tkj9ep
 /	Date: 03/01/2022
 /	Filename: BinaryNode.h
*/
#ifndef BINARYNODE_H
#define BINARYNODE_H
#include <string>
using namespace std;

class BinaryNode {
public:
    BinaryNode();
    ~BinaryNode();

    string value;
    BinaryNode* left;
    BinaryNode* right;

    friend class BinarySearchTree;
};

#endif
