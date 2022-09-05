/* Name: Tyler Kim
 / Computing Id: tkj9ep
 / Date: 03/15/2022
 / Filename: wordPuzzle.cpp
*/

#include <iostream>
#include <fstream>
#include <string>
#include <unordered_set>
#include "hashTable.h"
#include "timer.h"
#include <cmath>
#include <vector>
#define MAXROWS 500
#define MAXCOLS 500

char grid[MAXROWS][MAXCOLS];
using namespace std;

//main method
int main(int argc, char *argv[]) { //argv[1] => dictionary file and argv[2] => grid file	
	vector<string> vec;
	int index = 0;
	string element;
	timer t;
	t.start();

	//prototyping
	bool readDictionaryFile(string filename, hashTable *temp);
	bool readInGrid(string gridFilename, int& rows, int& cols);		
	string getWordInGrid(int startRow, int startCol, int dir, int len, int numRows, int numcols);

	//variables
	int rows, cols;
	int count = 0;
	hashTable *tempHash = new hashTable(argv[1]);

	//read dictionary and print words
	readDictionaryFile(argv[1], tempHash);
//	cout << "The size of the hash table is: " << (*tempHash).bucket_count() << endl;;	

	readInGrid(argv[2], rows, cols);	

	//actually get the values
	for(int x = 0; x < rows; x++) { // rows
		for(int y = 0; y < cols; y++) { //columns
			for(int d = 0; d < 8; d++) { //direction
				for(int l = 3; l < 23; l++) { //length
					string wordToTest = getWordInGrid(x, y, d, l, rows, cols);
					if((*tempHash).contains(wordToTest) && wordToTest.length() >= l) {
						count++;
						switch(d) {
							case 0:
								element = "N (" + to_string(x) + ", " + to_string(y) + "):\t" + wordToTest + "\n";
								//cout << "N (" << x << ", " << y << "):\t" << wordToTest << endl;
								vec.push_back(element);
								break;

							case 1:
								element = "NE(" + to_string(x) + ", " + to_string(y) + "):\t" + wordToTest + "\n"; 
							//	cout << "NE(" << x << ", " << y << "):\t" << wordToTest << endl;

								vec.push_back(element);
								break;

							case 2:
								element = "E (" + to_string(x) + ", " + to_string(y) + "):\t" + wordToTest + "\n";
						//		cout << "E (" << x << ", " << y << "):\t" << wordToTest << endl;
								vec.push_back(element);
								break;

							case 3:
								//cout << "SE(" << x << ", " << y << "):\t" << wordToTest << endl;
								element = "SE(" + to_string(x) + ", " + to_string(y) + "):\t" + wordToTest + "\n"; 
								vec.push_back(element);
								break;

							case 4:
					//			cout << "S (" << x << ", " << y << "):\t" << wordToTest << endl;
								element = "S (" + to_string(x) + ", " + to_string(y) + "):\t" + wordToTest + "\n"; 
								vec.push_back(element);
								break;

							case 5:
//								cout << "SW(" << x << ", " << y << "):\t" << wordToTest << endl; 
								element = "SW(" + to_string(x) + ", " + to_string(y) + "):\t" + wordToTest + "\n";
								vec.push_back(element);
								break;

							case 6:
//								cout << "W (" << x << ", " << y << "):\t" << wordToTest << endl;
								element = "W (" + to_string(x) + ", " + to_string(y) + "):\t" + wordToTest + "\n"; 
								vec.push_back(element);
								break;

							case 7:
//								cout << "NW(" << x << ", " << y << "):\t" << wordToTest << endl;
								element = "NW(" + to_string(x) + ", " + to_string(y) + "):\t" + wordToTest + "\n";
								vec.push_back(element);
								break;
						}
						index++;
					}					
					
				}

			}
		
		}
		
	}	

	for(int i = 0; i < count; i++) {
		cout << vec[i];
	}
	cout << count << " words found" << endl;
//	(tempHash -> computeLoadFactor(count));
	delete tempHash;
	t.stop();
//	cout << (int)(t.getTime() * 1000) << endl;
	return 0;

}

//read dictionary file
bool readDictionaryFile(string dictionaryFilename, hashTable *temp) {
	//try to open file
	string str;
	ifstream myfile(dictionaryFilename);

	//return false if failure
	if(!myfile.is_open()) {
		return false;
	}

	//print the strings
	while(getline(myfile, str)) {
		(*temp).insert(str);
//		cout << str << "\n";;
	}
	myfile.close();
		

	return true;
}

//read grid file
bool readInGrid(string gridFilename, int& rows, int& cols) {
	//try to open file
	ifstream myFile(gridFilename);
	
	//test if file can be opened
	if(!myFile.is_open()) {
		return false;
	}

	myFile >> rows;
	myFile >> cols;
//	cout << "There are " << rows << " rows." << endl;	
//	cout << "There are " << cols << " columns." << endl;

	string data;
	myFile >> data;
	
	//close the file
	myFile.close();

	//converts string into a 2D readable format
	int pos = 0;
	for (int r = 0; r < rows; r++) {
		for(int c = 0; c < cols; c++) {
			grid[r][c] = data[pos++];
//			cout << grid[r][c];
		}
//		cout << endl;
	}	

	return true;
}

//gets the word in the grid
string getWordInGrid(int startRow, int startCol, int dir, int len, int numRows, int numCols) {
	static string output;
	output.clear();
	output.reserve(256);
	
	int r = startRow, c = startCol;

	//iterate through each character in output
	for(int i = 0; i < len; i++) {
		if(c >= numCols || r >= numRows || r < 0 || c < 0) {
			break;
		}

		//set the next character in the output array to the next letter
		output += grid[r][c];

		switch(dir) {
			case 0: //north
				r--;
				break;

			case 1: //north-east
				r--;
				c++;
				break;

			case 2: // east
				c++;
				break;
			case 3: // south-east
				r++;
				c++;
				break;

			case 4: //south
				r++;
				break;
			
			case 5: // south-west
				r++;
				c--;
				break;
			
			case 6: // west
				c--;
				break;

			case 7: // north-west
				r--;
				c--;
				break;
		}
	}

	return output;

	
}
