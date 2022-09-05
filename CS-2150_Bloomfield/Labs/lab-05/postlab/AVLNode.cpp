/* Name: Tyler Kim
 / Computing Id: tkj9ep
 / Date: 03/04/2022
 / Filename: AVLNode.cpp
*/

#include "AVLNode.h"
#include <string>
using namespace std;

AVLNode::AVLNode() {
    value = "?";
    left = NULL;
    right = NULL;
    height = 0;
}

AVLNode::~AVLNode() {
    delete left;
    delete right;
    left = NULL;
    right = NULL;
}
