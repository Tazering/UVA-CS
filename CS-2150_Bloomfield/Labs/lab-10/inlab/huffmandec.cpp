// This program is the skeleton code for the lab 10 in-lab.
// It uses C++ streams for the file input,
// and just prints out the data when read in from the file.

/*
	Name: Tyler Kim
	Computing Id: tkj9ep
	Date: 04/22/2022
	Filename: huffmandec.cpp
*/

#include <iostream>
#include <fstream>
#include <sstream>
#include <cstdlib>
#include <map>
#include "Tree.h"
#include "Node.h"

using namespace std;

Tree t;
string allbits;
string output = "";

// main(): we want to use parameters
int main (int argc, char** argv) {
	void decodeMessage(Node* node, string eMessage);

	map<char, string> encodingMap;

    // verify the correct number of parameters
    if (argc != 2) {
        cout << "Must supply the input file name as the only parameter" << endl;
        exit(1);
    }

    // attempt to open the supplied file
    // must be opened in binary mode as otherwise trailing whitespace is discarded
    ifstream file(argv[1], ifstream::binary);
    // report any problems opening the file and then exit
    if (!file.is_open()) {
        cout << "Unable to open file '" << argv[1] << "'." << endl;
        exit(2);
    }

    // read in the first section of the file: the prefix codes
    while (true) {
        string character, prefix;
        // read in the first token on the line
        file >> character;

        // did we hit the separator?
        if (character[0] == '-' && character.length() > 1) {
            break;
        }

        // check for space
        if (character == "space") {
            character = " ";
        }

        // read in the prefix code
        file >> prefix;
        // do something with the prefix code
		encodingMap[character[0]] = prefix;

//   	   cout << "character '" << character << "' has prefix code '" << prefix << "'" << endl;
    }

	//test map
//	for(auto it = encodingMap.begin(); it != encodingMap.end(); ++it) {
//		cout << it -> first << " " << it -> second << endl;
//	}

	//build the tree
	for(auto it = encodingMap.begin(); it != encodingMap.end(); ++it) {
		t.insert(it -> first, it -> second);
	}

    // read in the second section of the file: the encoded message
    stringstream sstm;
    while (true) {
        string bits;
        // read in the next set of 1's and 0's
        file >> bits;
        // check for the separator
        if (bits[0] == '-') {
            break;
        }
        // add it to the stringstream
        sstm << bits;
    }

    allbits = sstm.str();
    // at this point, all the bits are in the 'allbits' string
  //cout << "All the bits: " << allbits << endl;
	
	//decode the message
	decodeMessage(t.root, allbits);	
	cout << output << endl;

    // close the file before exiting
    file.close();

    return 0;
}



//TODO Decode the Message
void decodeMessage(Node* node, string eMessage) {
	
	if(eMessage.length() == 0) { //test if there are not words left
		output.push_back(node -> value);
		return ;

	} else if(node -> value != '?') {
		output.push_back(node -> value);
		decodeMessage(t.root, eMessage);

	} else {
		if(eMessage[0] == '1') {
			decodeMessage(node -> right, eMessage.substr(1, eMessage.length() - 1));
		
		} else {
			decodeMessage(node -> left, eMessage.substr(1, eMessage.length() - 1));
		}

	
	}
}
