 /* Name: Tyler Kim
 /  Computing Id: tkj9ep
 /  Date: 03/01/2022
 /  Filename: BinarySearchTree.cpp
*/

#include "BinaryNode.h"
#include "BinarySearchTree.h"
#include <iostream>
#include <string>
using namespace std;

BinarySearchTree::BinarySearchTree() {
    root = NULL;
}

BinarySearchTree::~BinarySearchTree() {
    delete root;
    root = NULL;
}

// insert finds a position for x in the tree and places it there.
void BinarySearchTree::insert(const string& x) {
    // YOUR IMPLEMENTATION GOES HERE
	insert(x, root);
}

//private insert method
void BinarySearchTree::insert(const string& x, BinaryNode* &node) {
	
	//checks if the node is NULL then add a value
	if(node == NULL) {
		node = new BinaryNode();
		node -> value = x;
		
	} else if(x.compare(node -> value) < 0) { //less than => go left
		insert(x, node -> left);

	} else if(x.compare(node -> value) > 0) { //greater than => go right
		insert(x, node -> right);

	} else { //there exists a value => NOTHING
		//NOTHING
	}

}

// remove finds x's position in the tree and removes it.
void BinarySearchTree::remove(const string& x) {
    root = remove(root, x);
}

// private helper for remove to allow recursion over different nodes. returns
// a BinaryNode* that is assigned to the original node.
BinaryNode* BinarySearchTree::remove(BinaryNode*& n, const string& x) {
    if (n == NULL) {
        return NULL;
    }

    // first look for x
    if (x == n->value) {
        // found
        if (n->left == NULL && n->right == NULL) {
            // no children
            // just delete it :)
            delete n;
            n = NULL;
            return NULL;
        } else if (n->left == NULL) {
            // single child (right)
            // remove current node and return right child node for parent
            BinaryNode* temp = n->right;
            n->right = NULL;
            delete n;
            n = NULL;
            return temp;
        } else if (n->right == NULL) {
            // single child (left)
            // remove current node and return left child node for parent
            BinaryNode* temp = n->left;
            n->left = NULL;
            delete n;
            n = NULL;
            return temp;
        } else {
            // two children
            // replace current node with right child node's minimum, then remove that node
            string value = min(n->right);
            n->value = value;
            n->right = remove(n->right, value);
        }
    } else if (x < n->value) {
        n->left = remove(n->left, x);
    } else {
        n->right = remove(n->right, x);
    }
    return n;
}

// pathTo finds x in the tree and returns a string representing the path it
// took to get there.
string BinarySearchTree::pathTo(const string& x) const {
    // YOUR IMPLEMENTATION GOES HERE

	return pathTo(x, root);
}

//private pathTo method
string BinarySearchTree::pathTo(const string& x, BinaryNode* node) const {
	string s = "";

	//in the case it does not exist
	if(!find(x)) {
		return "";
	} else if(x.compare(node -> value) < 0) {		
		s = " " + pathTo(x, node -> left) + s;

	} else if(x.compare(node -> value) > 0) {
		s = " " + pathTo(x, node -> right) + s;

	} else {
	}

	return s = node -> value + s;
}

// find determines whether or not x exists in the tree.
bool BinarySearchTree::find(const string& x) const {
    // YOUR IMPLEMENTATION GOES HERE
	return find(x, root);
}

//private find method 
bool BinarySearchTree::find(const string& x, BinaryNode* node) const {
	//if the root or current node is NULL then return false;
	if(node == NULL) {
		return false;

	} else if(x.compare(node -> value) < 0) { // traverse left if the string is less than the current value

		return find(x, node -> left);
				
	} else if(x.compare(node -> value) > 0) { // traverse right if string greater
		return find(x, node -> right);
	
	} else { //where all is true
	
		return true;

	}
	return false;
}

// numNodes returns the total number of nodes in the tree.
int BinarySearchTree::numNodes() const {
    // YOUR IMPLEMENTATION GOES HERE
	return numNodes(root);
}

//private helper method
int BinarySearchTree::numNodes(BinaryNode* node) const {
	int count = 0;
	
	if(node == NULL) {
		return 0;
	}

	count++;
	count += numNodes(node -> left);
	count += numNodes(node -> right);

	return count;
}

// min finds the string with the smallest value in a subtree.
string BinarySearchTree::min(BinaryNode* node) const {
    // go to bottom-left node
    if (node->left == NULL) {
        return node->value;
    }
    return min(node->left);
}

// Helper function to print branches of the binary tree
// You do not need to know how this function works.
void showTrunks(Trunk* p) {
    if (p == NULL) return;
    showTrunks(p->prev);
    cout << p->str;
}

void BinarySearchTree::printTree() {
    printTree(root, NULL, false);
}

// Recursive function to print binary tree
// It uses inorder traversal
void BinarySearchTree::printTree(BinaryNode* root, Trunk* prev, bool isRight) {
    if (root == NULL) return;

    string prev_str = "    ";
    Trunk* trunk = new Trunk(prev, prev_str);

    printTree(root->right, trunk, true);

    if (!prev)
        trunk->str = "---";
    else if (isRight) {
        trunk->str = ".---";
        prev_str = "   |";
    } else {
        trunk->str = "`---";
        prev->str = prev_str;
    }

    showTrunks(trunk);
    cout << root->value << endl;

    if (prev) prev->str = prev_str;
    trunk->str = "   |";

    printTree(root->left, trunk, false);

    delete trunk;
}
void BinarySearchTree::printTreeValues() {
	printTreeValues(root);
}

void BinarySearchTree::printTreeValues(BinaryNode* node) {
	//base case
	if(node == NULL) {

		return;
	} else {
		cout << node -> value << " ";
		printTreeValues(node -> left);
		printTreeValues(node -> right);
	}
}
