/* Name: Tyler Kim
 / Computing Id: tkj9ep
 / Date: 03/04/2022
 / Filename: AVLNode.h
*/

#ifndef AVLNODE_H
#define AVLNODE_H
#include <string>
using namespace std;

class AVLNode {
    AVLNode();
    ~AVLNode();

    string value;
    AVLNode* left;
    AVLNode* right;
    int height;

    friend class AVLTree;
};

#endif
