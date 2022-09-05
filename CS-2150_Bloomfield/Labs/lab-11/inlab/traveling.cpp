/*
	Name: Tyler Kim
	Computing Id: tkj9ep
	Date: 04/26/2022
	Filename: traveling.cpp
*/

#include <iostream>
#include <cstdlib>
#include <algorithm>
#include <limits>
#include <unordered_map>

using namespace std;


#include "middleearth.h"

float computeDistance(MiddleEarth* me, const string& start, vector<string> dests);
void printRoute(const string& start, const vector<string>& dests);


int main(int argc, char** argv) {
    // check the number of parameters
    if (argc != 6) {
        cout << "Usage: " << argv[0] << " <world_height> <world_width> "
             << "<num_cities> <random_seed> <cities_to_visit>" << endl;
        exit(0);
    }

    // we'll assume the parameters are all well-formed
    int width = stoi(argv[1]);
    int height = stoi(argv[2]);
    int num_cities = stoi(argv[3]);
    int rand_seed = stoi(argv[4]);
    int cities_to_visit = stoi(argv[5]);

    // create the world, and select your itinerary
    MiddleEarth me(width, height, num_cities, rand_seed) ;
    vector<string> dests = me.getItinerary(cities_to_visit);

    // TODO: YOUR CODE HERE
	//test print the printRoute()
	//printRoute(dests[0], dests);
	//cout << "The total distance: " << computeDistance(me, dests[0], dests) << endl;
	//me.printTable();	

	sort(dests.begin() + 1, dests.end());
	
	float minDistance = numeric_limits<float>::max();
	vector<string> minDests;	

	do {
		
		float curDistance = computeDistance(&me, dests[0], dests);
		
		if(curDistance < minDistance) {
			minDistance = curDistance;
			minDests = dests;
		}	
	
	} while(next_permutation(dests.begin() + 1, dests.end())); 
			
	//output
	cout << "Minimum path has distance " << minDistance << ": ";
	printRoute(dests[0], minDests);

	

    return 0;
}

// This method will compute the full distance of the cycle that starts
// at the 'start' parameter, goes to each of the cities in the dests
// vector IN ORDER, and ends back at the 'start' parameter.
/**
 * @brief Computes the total distance.
 *
 * This function computes the full distance of the cycle starting at the 'start' city and
 * all the cities in the dests.
 *
 * @return The full distance.
 * @param start The first city.
 * @param dests The itinerary.
 * @todo optimize the function
 */

float computeDistance(MiddleEarth* me, const string& start, vector<string> dests) {
    // TODO: YOUR CODE HERE
	float sum = 0;

	for(int i = 1; i < dests.size(); i++) {
		sum += me -> getDistance(dests[i-1], dests[i]);
	}	
	
	sum += me -> getDistance(dests[dests.size() - 1], start);

    return sum;
}

// This method will print the entire route, starting and ending at the
// 'start' parameter.
// The output should be similar to:
// Erebor -> Khazad-dum -> Michel Delving -> Bree -> Cirith Ungol -> Erebor

/**
 * @brief Prints the route.
 *
 * This function prints the route of the cities that can be travelled.
 *
 * @return void.
 * @param start The start city.
 * @param dests The itinerary.
 * @todo Optimize
 */
void printRoute(const string& start, const vector<string>& dests) {
    // TODO: YOUR CODE HERE
	
	//prints all the cities
	for(string city: dests) {
		cout << city << " -> ";
	}

	//print the starting city as the last in the string
	cout << start << endl; 
}
