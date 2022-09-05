/*
	Name: Tyler Kim
	Computing Id: tkj9ep
	Date: 04/19/2022
	Filename: huffmanenc.cpp
*/

#include <string>
#include <iostream>
#include <fstream>
#include <cstdlib>
#include <map>
#include "heap.h"
#include "heapNode.h"

using namespace std;
map<char, string> mString;

int main(int argc, char** argv) {
	int count = 0;
	void printEncoding(heapNode* node, string code);

	map<char, int> m;
	string encodedOutput = "";
	heap h;

	//verify the number of parameters
	if(argc != 2) {
		cout << "Must supply the input file name as the one and only parameter" << endl;
		exit(1);
	}

	//attempt to open the supplied file
	ifstream file(argv[1]);
	if(!file.is_open()) {
		cout << "Unable to open '" << argv[1] << "' for reading" << endl;
		exit(2);
	}

	// read characters individually and count their frequencies
	char g;
	while(file.get(g)) {
		if(g < 0x20 || g > 0x7e) {
				
		} else {
			m[g]++;
			count++;
		}
	
	}
	

	for(auto it = m.begin(); it != m.end(); ++it) {
		heapNode* node = new heapNode((*it).first);
		node -> frequency = ((*it).second);
		
		h.insert(node);
	}	
	
	h.buildTree();	

	
	printEncoding(h.theHeap[1], "");
	
	for(auto it = mString.begin(); it != mString.end(); ++it) {
		cout << it -> first << " " << it -> second << endl;
	}
	
	cout << "----------------------------------------" << endl;

	file.clear();
	file.seekg(0);

	int compFileCount = 0;
	while(file.get(g)) {
		encodedOutput = encodedOutput + mString[g] + " ";
		compFileCount += mString[g].length();
	}

	cout << encodedOutput << endl;

	cout << "----------------------------------------" << endl;

	file.clear();
	file.seekg(0);
	double ratio = 0.0;

	cout << "There are a total of " << count << " symbols that are encoded." << endl;
	cout << "There are " << m.size() << " distinct symbols used." << endl; 
	cout << "There were " << count * 8 << " bits in the original file." << endl; 
	cout << "There were " << compFileCount << " bits in the compressed file." << endl;
	ratio = (double) (count * 8) / (double) (compFileCount);
	cout << "This gives a compression ratio of " << ratio << "."  << endl;
	ratio = (double) (compFileCount) / (double) (count);
	cout << "The cost of the Huffman tree is " << ratio << " bits per character." << endl;

	//read the file again and print to screen
//	while (file.get(g)) {
//		cout << g;
//	}

	//print the frequency array
//	for (const auto& [key, value]: m) {
//		cout << '[' << key << "] = " << value << "; ";
//	}	

	file.close();
	return 0;
}

void printEncoding(heapNode* node, string code) {
	

	if(node -> left == NULL && node -> right == NULL) {
		mString[node -> character] = code;
	} else {
		printEncoding(node -> left, code + "0");
		printEncoding(node -> right, code + "1");		
	}

}
