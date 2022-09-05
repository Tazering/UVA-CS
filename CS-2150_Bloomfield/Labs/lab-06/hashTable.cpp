/* Name: Tyler Kim
 / Computing Id: tkj9ep
 / Date: 03/15/2022
 / Filename: hashTable.cpp
*/

#include "hashTable.h"
#include <iostream>
#include <string>
#include <vector>
#include <list>
#include <fstream>
#include <math.h>
#include <set>

//constructors and destructors
hashTable::hashTable() {

}

hashTable::hashTable(string filename) {
	//set the threshold
	loadFactorThreshold = 0.15;
	sizeOfFile = getFileSize(filename);
	sizeOfTable = getFileSize(filename)/loadFactorThreshold;

//	if(!checkPrime(sizeOfTable)) {
//		sizeOfTable = getNextPrime(sizeOfTable);
//	}

	
//	computeLoadFactor();

	
	//set the size to fulfill the load factor
//	while(loadFactor > loadFactorThreshold) {
//		sizeOfTable *= 2;
//		if(!checkPrime(sizeOfTable)) {
//			sizeOfTable = getNextPrime(sizeOfTable);
//		}
//		
//		computeLoadFactor();
//	}

	
//	cout << "The next prime size value is: " << size << endl;
	table.resize(sizeOfTable);

//	for(int i = 0; i < sizeOfTable; i++) {
//		table[i] = "";
//	}
		
//	for(int i = 0; i < size; i++) {
//		table[i] = new list<string>;
//	}
//	cout << "The size of the file is: " << sizeOfFile << endl;
//	cout << "The capacity of the hash table is: " << table.capacity() << endl;

//	cout << "The location would be: " << hashFunction("Hi");
 //	cout << "The size value is: " << size << endl;
	for(int i = 0; i < 23; i++) {
		powers[i] = pow(17, i);
	}

}

hashTable::~hashTable() {

}

//methods
bool hashTable::insert(string str) {
	int location = hashFunction(str);

	table[location].push_front(str);
//	table[location].insert(str);

//	while(table[index] == "") {		

		//check for overlap
//		index = ((location + i) % sizeOfTable);
//		i++;
//	}



//	table[location] = str;
	return true;
}

bool hashTable::contains(string str) {
	int location = hashFunction(str);
//	int index = hashFunction(str);
//	int i = 1;
	list<string>::iterator it;
	for(it = table[location].begin(); it != table[location].end(); it++) {
		if((*it) == str) {			
			return true;	
		}
	}


//	if(table[location].count(str) > 0) {
//		return true;
//	}
	
	return false;
}

int hashTable::hashFunction(string str) {
	unsigned int location = 0;
	//convert string to array of character
	for(int i = 0; i < str.length(); i++) {
		location += (int(str[i]) * powers[i]);
	}
	//get hash location

	return location % sizeOfTable;
}

void hashTable::computeLoadFactor() {

	
	loadFactor = ((float) sizeOfFile) / ((float) sizeOfTable);
//	cout << "Load factor is: " << loadFactor << endl;	
	
}


//supplementary
bool hashTable::checkPrime(unsigned int p) {
	if ( p <= 1 ) // 0 and 1 are not primes; the are both special cases
        return false;
    if ( p == 2 ) // 2 is prime
        return true;
    if ( p % 2 == 0 ) // even numbers other than 2 are not prime
        return false;
    for ( int i = 3; i*i <= p; i += 2 ) // only go up to the sqrt of p
        if ( p % i == 0 )
            return false;
    return true;
}

int hashTable::getNextPrime(unsigned int n) {
	while ( !checkPrime(++n) );
    return n; // all your primes are belong to us
}

int hashTable::getFileSize(string filename) {
	int valueToReturn = 0;
	string line;
		
	//tries to open the file
	ifstream myFile(filename);

	if(!myFile.is_open()) {
		return 0;
	}

	while(getline(myFile, line)) {
		valueToReturn++;
	}
	
	myFile.close();
	return valueToReturn;
}
