/*
	Name: Tyler Kim
	Computing Id: tkj9ep
	Date: 04/28/2022
	Filename: solvePuzzle.h
*/

#ifndef SOLVEPUZZLE_H
#define SOLVEPUZZLE_H

#include <iostream>
#include <string>

using namespace std;

class solvePuzzle {
	public: 
	
	void print();
	void swap(int pos1, int pos2);
	
	private:
	int grid[3][3];
};

#endif
