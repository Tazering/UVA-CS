/*
	Name: Tyler Kim
	Computing Id: tkj9ep
	Date: 04/29/2022
	Filename: solvePuzzle.cpp
*/

#include <iostream>
#include <unordered_map>
#include <vector>
#include <queue>

using namespace std;


int main() {
	//function prototypes
	void print(string currentState);
	string swap(string state, int index1, int index2);
	vector<string> generateNeighbors(string currentStr);		
	int finalDistance = -1;
	unordered_map<string, int> m;
	queue<string> q;
	string initialState = "";
	string currentState = "";
	string const GOAL_STATE = "123456780";

	
	cout << "Enter puzzle" << endl;
	//get input
	for(int i = 0; i < 9; i++) {
		string temp = "";
		cin >> temp;
		initialState += temp;
	}

	cout << "Solving puzzle" << endl;

	//make current state as the initial state		
	currentState = initialState;

	//check if its possible
//	if(!checkInversibility()) {
		
//	} else {
//		print();

//	}

	//actual sorting
	string tempState = currentState;
	m[initialState] = 0;
	q.push(initialState);
	
	while(!q.empty()) {
		string temp = q.front();
		if(temp == GOAL_STATE) {
			finalDistance = m[temp];
			break;
		}

		q.pop();
		vector<string> v;
		v = generateNeighbors(temp);

		for(int i = 0; i < v.size(); i++) {
			string temp1 = v[i];
			if(m.find(temp1) == m.end()) {
				m[temp1] = m[temp] + 1;
				q.push(temp1);
			}						
//			print();
			
		}
	}	
	
//	for(auto it = m.begin(); it != m.end(); it++) {
//		cout << "Key: " << it -> first << " Distance: " << it -> second << endl;
//	}

	if(finalDistance == -1) {
		cout << "IMPOSSIBLE" << endl;
	} else {
		cout << finalDistance << endl;
	}
	return 0;
}


/**
 * @brief Prints the 3x3 Grid.
 *
 * This function prints the grid.
 * 
 *
 * @return void
 * @param currentState The current state of the string.
 * @todo flexible
 */

//prints the array
void print(string currentState) {
	cout << endl;
	cout << currentState[0] << " ";
	cout << currentState[1] << " ";
	cout << currentState[2] << endl;
		
	cout << currentState[3] << " ";
	cout << currentState[4] << " ";
	cout << currentState[5] << endl;
	
	cout << currentState[6] << " ";
	cout << currentState[7] << " ";
	cout << currentState[8] << endl;
}

//creates a vector for possible moves
/**
 * @brief Creates a vector for possible moves.
 *
 * This function calculates all the possible moves.
 *
 * @return Vector of possible permutations.
 * @param currentStr The current string
 * @todo optimize
 */
vector<string> generateNeighbors(string currentStr) {
	string swap(string state, int index1, int index2);
	vector<string> possibleStrings;
	int index = -1;	

	string s1 = currentStr;
	string s2 = currentStr;
	string s3 = currentStr;
	string s4 = currentStr;

	for(int i = 0; i < 9; i++) {
		if(currentStr[i] == '0') {
			index = i;
			break;
		}
	}

	switch(index) {
		case 0:
			possibleStrings.push_back(swap(currentStr, 0, 1));
		//	print();


			possibleStrings.push_back(swap(currentStr, 0, 3));		
		//	print();

			break;

		case 1:
			possibleStrings.push_back(swap(currentStr, 1, 0));
		//	print();
		//	cout << endl;			

			possibleStrings.push_back(swap(currentStr, 1, 4));
		//	print();
		//	currentState = currentState2;
		//	cout << endl;


			possibleStrings.push_back(swap(currentStr, 1, 2));
		//	print();
		//	currentState = currentState2;
		//	cout << endl;

			break;

		case 2:
			
		//	swap(2, 1);
			possibleStrings.push_back(swap(currentStr, 2, 1));
		//	print();
		//	currentState = currentState2;
			
		//	cout << endl;

		//	swap(2, 5);
			possibleStrings.push_back(swap(currentStr, 2, 5));
		//	print();			
		//	currentState = currentState2;

			break;

		case 3:
		//	swap(3, 0);
			possibleStrings.push_back(swap(currentStr, 3, 0));
		//	print();	
		//	currentState = currentState2;
			
		//	swap(3, 4);
			possibleStrings.push_back(swap(currentStr, 3, 4));
		//	print();		
		//	currentState = currentState2;
					
		//	swap(3, 6);
			possibleStrings.push_back(swap(currentStr, 3, 6));
		//	print();			
		//	currentState = currentState2;

			break;

		case 4:
			
		//	swap(4, 1);
			possibleStrings.push_back(swap(currentStr, 4, 1));
		//	print();		
		//	currentState = currentState2;

					
		//	swap(4, 3);
			possibleStrings.push_back(swap(currentStr, 4, 3));
		//	print();		
		//	currentState = currentState2;

					
		//	swap(4, 5);
			possibleStrings.push_back(swap(currentStr, 4, 5));
		//	print();		
		//	currentState = currentState2;
					
		//	swap(4, 7);
			possibleStrings.push_back(swap(currentStr, 4, 7));
		//	print();				
		//	currentState = currentState2;

			break;
		case 5:
			
//			swap(5, 2);
			s1 = swap(currentStr, 5, 2);
			possibleStrings.push_back(s1);
		//	print();			
		//	currentState = currentState2;
				
		//	swap(5, 4);
			s2 = swap(currentStr, 5, 4);
			possibleStrings.push_back(s2);
			//cout << "This is the swap" << endl;
		//	print();				
		//	currentState = currentState2;
				
		//	swap(5, 8);
			s3 = swap(currentStr, 5, 8);
			possibleStrings.push_back(s3);
		//	print();				
		//	currentState = currentState2;
			break;

		case 6:
			
		//	swap(6, 3);
			possibleStrings.push_back(swap(currentStr, 6, 3));	
		//	currentState = currentState2;
		//	print();	

					
		//	swap(6, 7);
			possibleStrings.push_back(swap(currentStr, 6, 7));	
		//	currentState = currentState2;
		//	print();			
			break;

		case 7:
			
		//	swap(7, 6);
			possibleStrings.push_back(swap(currentStr, 7, 6));	
		//	currentState = currentState2;
		//	print();	

					
		//	swap(7, 4);
			possibleStrings.push_back(swap(currentStr, 7, 4));	
		//	currentState = currentState2;
		//	print();	

					
		//	swap(7, 8);
			possibleStrings.push_back(swap(currentStr, 7, 8));	
		//	currentState = currentState2;
		//	print();			
			break;
		case 8:
			
		//	swap(8, 5);
			possibleStrings.push_back(swap(currentStr, 8, 5));	
		//	currentState = currentState2;
		//	print();	

					
		//	swap(8, 7);
			possibleStrings.push_back(swap(currentStr, 8, 7));	
		//	currentState = currentState2;

		//	print();			
			break;
	}

//	cout << possibleStrings[0] << " " << possibleStrings[1] << endl;
	return possibleStrings;
}

//swaps two values
/**
 * @brief Helper Method for swapping.
 *
 * This function swaps the any given index of a string.
 *
 * @return The new string.
 * @param state The current state of the string.
 * @param index1 The first index.
 * @param index2 The second dindex
 * @todo Optimize
 */
string swap(string state, int index1, int index2) {
	void print(string currentState);
	//get the first and second index
//	for(int i = 0; i < 9; i++) {
//		if(currentState[i] == firstNumber) {
//			firstIndex = i;
///			continue;
//		}	
//
//		if(currentState[i] == secondNumber) {
//			secondIndex = i;
//			continue;
///		}
//
//	}

	//switch
	char temp = state[index1];
	state[index1] = state[index2];
	state[index2] = temp;
//	cout << "In the swap method: " << endl;
//	print(state);
	
	return state;
}



//check how much is inversed
bool checkInversibility() {
		
}
