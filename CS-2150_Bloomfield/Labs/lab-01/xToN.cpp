//Tyler Kim
//tkj9ep@virginia.edu
//01-23-2022
//xToN.cpp

#include <iostream>
using namespace std;

int xton(int x, int n);
int main() {
  int x,n;

  cin >> x;
  cin >> n;

  cout << xton(x, n) << endl;
  
  return 0;
}

int xton(int x, int n) {
  //base case
  //test if n is 0 => return 1
  if(n == 0){
    return 1;
  }
  if(n <= 1) {
    return x;
  }
  else { // recursive case
    return x * xton(x, n-1);
  }
  
}

