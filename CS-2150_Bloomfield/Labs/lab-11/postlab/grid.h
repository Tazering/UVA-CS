/*
	Name: Tyler Kim
	Computing Id: tkj9ep
	Date: 04/29/2022
	Filename: grid.h
*/

#ifndef GRID_H
#define GRID_H

#include <iostream>
#include <string>

using namespace std;

class grid {

	public: 
	grid(string input);
	~grid();
	void print();	// print the table in grid order
	void rotate(int pos1, int pos2);	
		
	private: 
	int 3x3Grid[3][3];

};

#endif


