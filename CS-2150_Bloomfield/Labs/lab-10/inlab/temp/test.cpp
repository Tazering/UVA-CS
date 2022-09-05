#include "Tree.h"
#include "Node.h"
#include <iostream>

using namespace std;


int main() {
	Tree t;

	t.insert('A', "110");
	t.insert('B', "001");
	t.printTree();

	return 0;
}

