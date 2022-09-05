/* Name: Tyler Kim
 / Computing Id: tkj9ep
 / Date: 03/04/2022
 / Filename: AVLTree.cpp
*/
#include "AVLNode.h"
#include "AVLTree.h"
#include <iostream>
#include <string>
using namespace std;

AVLTree::AVLTree() {
    root = NULL;
}

AVLTree::~AVLTree() {
    delete root;
    root = NULL;
}

// insert finds a position for x in the tree and places it there, rebalancing
// as necessary.
//TODO implement balancing
void AVLTree::insert(const string& x) {
    // YOUR IMPLEMENTATION GOES HERE
	//test

	insert(x, root);
}

//private insert method
void AVLTree::insert(const string& x, AVLNode* &node) {
	//if node is NULL => add a value
	if(node == NULL) {
		node = new AVLNode();
		node -> value = x;

	} else if(x.compare(node -> value) < 0) { //less than => go left
		insert(x, node -> left);

	} else if(x.compare(node -> value) > 0) { //greater than => go right
		insert(x, node -> right);
	} else { //if the same
		//NOTHING
	}

	//recalculate heights and balance this subtree
	node -> height = 1 + max(height(node -> left), height(node -> right));
	//test
	
	balance(node);
}

// remove finds x's position in the tree and removes it, rebalancing as
// necessary.
void AVLTree::remove(const string& x) {
    root = remove(root, x);
}

// pathTo finds x in the tree and returns a string representing the path it
// took to get there.
string AVLTree::pathTo(const string& x) const {
    // YOUR IMPLEMENTATION GOES HERE
	return pathTo(x, root);
}

//private helper method
string AVLTree::pathTo(const string& x, AVLNode* node) const {
	string s = "";

	//in case it does not exist
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
bool AVLTree::find(const string& x) const {
    // YOUR IMPLEMENTATION GOES HERE
	//testing purposes
//	if(find(x, root)) {
//		cout << "Found the element" << endl;
//	} else {
//		cout << "Not found" << endl;
//}
	return find(x, root);
}

//private helper find method
bool AVLTree::find(const string& x, AVLNode* node) const {
	if(node == NULL) { //if node is not found
		return false;

	} else if(x.compare(node -> value) < 0) {//node < value => go left
		return find(x, node -> left);

	} else if(x.compare(node -> value) > 0) {//node > value => go right
		return find(x, node -> right);

	} else {
		return true;

	}
	return false;

}

// numNodes returns the total number of nodes in the tree.
int AVLTree::numNodes() const {
    // YOUR IMPLEMENTATION GOES HERE
	return numNodes(root);
}

//private numNodes calculator
int AVLTree::numNodes(AVLNode* node) const {
	int count = 0;

	if(node == NULL){
		return 0;
	}

	count++;
	count += numNodes(node -> left);
	count += numNodes(node -> right);

	return count;
}

// balance makes sure that the subtree with root n maintains the AVL tree
// property, namely that the balance factor of n is either -1, 0, or 1.
void AVLTree::balance(AVLNode*& n) {
    // YOUR IMPLEMENTATION GOES HERE
	int nodeBalanceFactor, rightBalanceFactor, leftBalanceFactor = 0;	
	
	nodeBalanceFactor = height(n -> right) - height(n -> left);

	if(nodeBalanceFactor == 2) {
		rightBalanceFactor = height(n -> right -> right) - height(n -> right -> left);
		
		if(rightBalanceFactor < 0) {
			n -> right = rotateRight(n -> right);

		}

		n = rotateLeft(n);

	} else if(nodeBalanceFactor == -2) {
		leftBalanceFactor = height(n -> left -> right) - height(n -> left -> left);
		
		if(leftBalanceFactor > 0) {
			n -> left = rotateLeft(n -> left);
		}			
		
		n = rotateRight(n);
	}
}

// rotateLeft performs a single rotation on node n with its right child.
AVLNode* AVLTree::rotateLeft(AVLNode*& n) {
    // YOUR IMPLEMENTATION GOES HERE
	AVLNode *nodeToReturn = n -> right; 
	AVLNode *nodeRightLeft = n -> right -> left;

	//move the nodes
	nodeToReturn -> left = n;
	n -> right = nodeRightLeft;
	
	//update
	n -> height -= 1;
	nodeToReturn -> height += 1;
	return nodeToReturn;
}

// rotateRight performs a single rotation on node n with its left child.
AVLNode* AVLTree::rotateRight(AVLNode*& n) {
    // YOUR IMPLEMENTATION GOES HERE
	//declare temporary variables
	AVLNode *tempLeftRight = n -> left -> right;
	AVLNode *nodeToReturn = n -> left;

	//move nodes
	nodeToReturn -> right = n;
	n -> left = tempLeftRight;

	//return values
	n -> height -= 1;
	nodeToReturn -> height += 1;
	return nodeToReturn;
}

// private helper for remove to allow recursion over different nodes.
// Returns an AVLNode* that is assigned to the original node.
AVLNode* AVLTree::remove(AVLNode*& n, const string& x) {
    if (n == NULL) {
        return NULL;
    }

    // first look for x
    if (x == n->value) {
        // found
        if (n->left == NULL && n->right == NULL) {
            // no children
            delete n;
            n = NULL;
            return NULL;
        } else if (n->left == NULL) {
            // Single child (left)
            AVLNode* temp = n->right;
            n->right = NULL;
            delete n;
            n = NULL;
            return temp;
        } else if (n->right == NULL) {
            // Single child (right)
            AVLNode* temp = n->left;
            n->left = NULL;
            delete n;
            n = NULL;
            return temp;
        } else {
            // two children -- tree may become unbalanced after deleting n
            string sr = min(n->right);
            n->value = sr;
            n->right = remove(n->right, sr);
        }
    } else if (x < n->value) {
        n->left = remove(n->left, x);
    } else {
        n->right = remove(n->right, x);
    }

    // Recalculate heights and balance this subtree
    n->height = 1 + max(height(n->left), height(n->right));
    balance(n);

    return n;
}

// min finds the string with the smallest value in a subtree.
string AVLTree::min(AVLNode* node) const {
    // go to bottom-left node
    if (node->left == NULL) {
        return node->value;
    }
    return min(node->left);
}

// height returns the value of the height field in a node.
// If the node is null, it returns -1.
int AVLTree::height(AVLNode* node) const {
    if (node == NULL) {
        return -1;
    }
    return node->height;
}

// max returns the greater of two integers.
int max(int a, int b) {
    if (a > b) {
        return a;
    }
    return b;
}

// Helper function to print branches of the binary tree
// You do not need to know how this function works.
void showTrunks(Trunk* p) {
    if (p == NULL) return;
    showTrunks(p->prev);
    cout << p->str;
}

// Recursive function to print binary tree
// It uses inorder traversal
void AVLTree::printTree(AVLNode* root, Trunk* prev, bool isRight) {
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

void AVLTree::printTree() {
    printTree(root, NULL, false);
}

//temporary method for printing values
void AVLTree::printTreeValues() {
	return printTreeValues(root);
}

//private printing value method
void AVLTree::printTreeValues(AVLNode* node) {
	if(node == NULL) {
		return;
	} else {
		cout << node -> value << " ";
		printTreeValues(node -> left);
		printTreeValues(node -> right);
	}
	

}
