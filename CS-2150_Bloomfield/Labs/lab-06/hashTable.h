/* Name: Tyler Kim
 / Computing Id: tkj9ep
 / Date: 03/15/2022
 / Filename: hashTable.h
*/

#ifndef HASHTABLE_H
#define HASHTABLE_H
#include <string>
#include <vector>
#include <list>
#include <iostream>
#include <set>

using namespace std;

class hashTable {

public:
	//constructor
	hashTable();
	hashTable(string filename);
	~hashTable();

	//methods
	bool insert(string str);
	bool contains(string str);
	int hashFunction(string str);	
	bool checkPrime(unsigned int p);
	int getNextPrime(unsigned int n);
	int getFileSize(string filename);
	void computeLoadFactor();
	
	
private:
	vector<list<string>> table;
	//vector<set<string>> table;
	//vector<string> table;
	int sizeOfFile;
	int sizeOfTable;
	float loadFactor;
	float loadFactorThreshold;
	unsigned int powers[23];
};

#endif
