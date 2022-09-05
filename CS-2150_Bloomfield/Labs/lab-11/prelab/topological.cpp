/*
	Name: Tyler Kim
	Computing Id: tkj9ep
	Date: 04/26/2022
	Filename: topological.cpp
*/

// This program shows how C++-based file I/O works.
// It will open a file, read in the first two strings, and print them to the screen.

#include <iostream>
#include <fstream>
#include <cstdlib>
#include <string>
#include <forward_list>
#include <unordered_map>
#include <queue>
#include <map>

using namespace std;

unordered_map<string, forward_list<string>> m;
map<string, int> mInDegrees;
queue<string> q;

// we want to use parameters
int main(int argc, char** argv) {
	void initializeInDegreeMap();
	void topSort();

    if (argc != 2) {
        cout << "Must supply the input file name as the one and only parameter" << endl;
        exit(1);
    }

    // attempt to open the supplied file
    ifstream file(argv[1], ifstream::binary);
    // report any problems opening the file and then exit
    if (!file.is_open()) {
        cout << "Unable to open file '" << argv[1] << "'." << endl;
        exit(2);
    }

    // read in two strings and add to unordered map
    string s1, s2;
	
	while(true) {
		file >> s1;
		file >> s2;

		if(s1 == "0" || s2 == "0") {
			break;
		}

		m[s1].push_front(s2);
	}
	
	file.clear();
	file.seekg(0);
	
	// check if all the values are present
	string s;
	while(true) {
		file >> s;
		bool exists = false;
		if(s == "0") {
			break;
		}

		for(auto it = m.begin(); it != m.end(); ++it) {
			if(it -> first == s) {
				exists = true;
			}
		}

		if(!exists) {
			m[s];
		}
	}

	//check map
//	for(auto it = m.begin(); it != m.end(); ++it) {
//		cout << it -> first << ":\t";
//		for(string& a: m[it -> first]) {
//			cout << " -> " << a;
//		}
//		cout << endl;
//	}

	initializeInDegreeMap();
	
	topSort();
	//check InDegreeMap
//	for(auto it = mInDegrees.begin(); it != mInDegrees.end(); ++it) {
//		cout << it -> first << ":\t" << it -> second << endl;
//		
//	}

    // close the file before exiting
    file.close();
}

//actually sort
void topSort() {

	for(auto it = mInDegrees.begin(); it != mInDegrees.end(); ++it) {
		if(mInDegrees[it -> first] == 0) {
			q.push(it -> first);
						
		}
	}

	while(!q.empty()) {
		string temp = q.front();
		cout << temp << " ";
		q.pop();

		for(string& a : m[temp]) {

			if(--mInDegrees[a] == 0) {
				q.push(a);
				
				mInDegrees.erase(a);
			}			

		}
	}
}

//initializes the degree map
void initializeInDegreeMap() {
	
	for(auto it = m.begin(); it != m.end(); ++it) {
		mInDegrees[it -> first];
		for(auto it2 = m.begin(); it2 != m.end(); ++it2) {
			for(string& a: m[it2 -> first]) {
				if(a == it -> first) {
					mInDegrees[it -> first]++;
				}
			}

		}
	
	}	

}

//returns total number of vertices
