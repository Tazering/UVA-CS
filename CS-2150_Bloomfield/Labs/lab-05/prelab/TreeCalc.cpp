//Insert your header information here
// Name: Tyler Kim
// Computing Id: tkj9ep
// Date: 02/29/2022 
// Filename: TreeCalc.cpp:  CS 2150 Tree Calculator method implementations

#include "TreeCalc.h"
#include <iostream>
#include <string>

using namespace std;

// Constructor
TreeCalc::TreeCalc() {
	
}

// Destructor - frees memory
TreeCalc::~TreeCalc() {
	cleanTree(expressionStack.top());
}


// Deletes tree/frees memory
void TreeCalc::cleanTree(TreeNode* tree) {
	
	//check if its a leaf node
	if(tree == NULL) {
		return;
	}

	//delete left tree
	cleanTree(tree -> left);

	//delete right tree
	cleanTree(tree -> right);

	//delete root
	delete tree;
}

// Gets data from user
// DO NOT MODIFY
void TreeCalc::readInput() {
    string response;
    cout << "Enter elements one by one in postfix notation" << endl
         << "Any non-numeric or non-operator character,"
         << " e.g. #, will terminate input" << endl;
    cout << "Enter first element: ";
    cin >> response;
    //while input is legal
    while (isdigit(response[0]) || response[0] == '/' || response[0] == '*'
            || response[0] == '-' || response[0] == '+') {
        insert(response);
        cout << "Enter next element: ";
        cin >> response;
    }
}

// Puts value in tree stack
void TreeCalc::insert(const string& val) {
	// insert a value into the tree
	// check if val is a number or operator
	TreeNode* nodeToAdd = new TreeNode(val);

	if(val == "*" || val == "/" || val == "+" || val == "-") {

		//make operator as root node
		
		TreeNode* left;
		TreeNode* right;
		
		//first value
		if(!expressionStack.empty()) { // have to check if its empty
			right = expressionStack.top();
			expressionStack.pop();

		} else {
			exit(-1);
		}

		//second value
		if(!expressionStack.empty()) {
			left = expressionStack.top();
			expressionStack.pop();

		} else {
			exit(-1);	
		}
		
		//add to operator node
		nodeToAdd -> left = left;
		nodeToAdd -> right = right;
			
		//push back into the stack
		expressionStack.push(nodeToAdd);

	//	cout << "Root node is: " << nodeToAdd -> value << endl;
	//	cout << "Left Node is: " << nodeToAdd -> left -> value << endl;
	//	cout << "Right Node is: " << nodeToAdd -> right -> value << endl;


	} else {
		//found a number => push into stack

		expressionStack.push(nodeToAdd);
	}
}

// Prints data in prefix form
void TreeCalc::printPrefix(TreeNode* tree) const {
    // print the tree in prefix format
	//base case
	if(tree == NULL) {
		return;
	}

	//root
	cout << tree -> value << " ";

	//left
	printPrefix(tree -> left);

	//right
	printPrefix(tree -> right);
}

// Prints data in infix form
void TreeCalc::printInfix(TreeNode* tree) const {
    // print tree in infix format with appropriate parentheses
	//base case
	if(tree != NULL) {
		if(tree -> value == "+" || tree -> value == "-" || tree -> value == "*" || tree -> value == "/") {
			cout << "(";
		}

		printInfix(tree -> left);

	//	cout << tree -> value << " ";
		if(tree -> value == "+" || tree -> value == "-" || tree -> value == "*" || tree -> value == "/") {
			cout << " " << tree -> value << " ";
		} else {
			cout << tree -> value;	
		}
		
		printInfix(tree -> right);
		
		if(tree -> value == "+" || tree -> value == "-" || tree -> value == "*" || tree -> value == "/") {
			cout << ")";
		}
	} 
	
	
}

//Prints data in postfix form
void TreeCalc::printPostfix(TreeNode* tree) const {
    // print the tree in postfix form
	if(tree == NULL) {
		return;
	}

	//left
	printPostfix(tree -> left);
	
	//right
	printPostfix(tree -> right);

	//root
	cout << tree -> value << " ";
}

// Prints tree in all 3 (post, in, pre) forms
// DO NOT MODIFY
void TreeCalc::printOutput() const {
    if (expressionStack.size() != 0 && expressionStack.top() != NULL) {
        TreeNode* tree = expressionStack.top();
        cout << "Expression tree in postfix expression: ";
        printPostfix(tree);
        cout << endl;

        cout << "Expression tree in infix expression: ";
        printInfix(tree);
        cout << endl;

        cout << "Expression tree in prefix expression: ";
        printPrefix(tree);
        cout << endl;
    } else {
        cout << "Size is 0." << endl;
    }
}

// Evaluates tree, returns value
// private calculate() method
int TreeCalc::calculate(TreeNode* tree) const {
    // Traverse the tree and calculates the result
    int sum = 0;

    if(tree == NULL) {
    	return 0;
    }

    if(tree -> value != "+" && tree -> value != "-" && tree -> value != "*" && tree -> value != "/") {
    	return stoi(tree -> value);
    }

    if(tree -> value == "+") {
	sum += (calculate(tree -> left) + calculate(tree -> right));

    } else if(tree -> value == "-") {
    	sum += (calculate(tree -> left) - calculate(tree -> right));

    } else if(tree -> value == "*") {
    	sum += (calculate(tree -> left) * calculate(tree -> right));

    } else if(tree -> value == "/") {
   	sum += (calculate(tree -> left) / (calculate(tree -> right)));
    }
   
    return sum;
}

//Calls calculate, sets the stack back to a blank stack
// public calculate() method. Hides private data from user
int TreeCalc::calculate() {
    // call private calculate method here
    return calculate(expressionStack.top());
}

//utility
//void PrintStack(stack<TreeNode*> st) {
//	if(st.empty()) {
//		return;
//	}
//	TreeNode* temp = st.top();
//	string x = st.top() -> value;
//	st.pop();

//	PrintStack(st);
//	st.push(temp);
//}
