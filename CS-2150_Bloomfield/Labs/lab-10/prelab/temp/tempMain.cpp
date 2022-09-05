#include <iostream>

#include "heap.h"
#include "heapNode.h"

using namespace std;


int main() {
///	vector<heapNode*> temp;
//	int heapSize = 5;

//	for(int i = 65; i < 70; i++) {
//		temp.push_back(new heapNode((char) i));
//	}

//	heap h = heap(temp);
	
	heap* h = new heap();
	h -> insert('D');
	h -> insert('B');
	h -> insert('C');
	h -> insert('A');
	h -> insert('Z');	

	h -> print();

	h -> deleteMin();
	

	h -> print();
	
	h -> deleteMin();
	
	h -> print();

	return 0;
}
