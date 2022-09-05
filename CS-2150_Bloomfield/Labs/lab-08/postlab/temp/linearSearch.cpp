#include <iostream>

using namespace std;

int main() {

int index = 0;
int size = 5;
int arr [5] = {1, 2, 3, 4, 5};

int valueToSearch = 3; 
bool foundValue = false;

while(index < size) {
	if(arr[index] == valueToSearch) {
		cout << "Found value at index: " << index << endl;
		foundValue = true;
		break;
	}
	index++;
}

if(!foundValue) {
	cout << "Did not find value" << endl;
}
return 0;
}
