/* Name: Tyler Kim
 * Computing Id: tkj9ep
 * Date: 02/01/2022
 * Filename: prog1.cpp
 */


#include <iostream>
using namespace std;

void my_subroutine() {
    cout << "Hello world" << endl;
}

int main() {
    int x = 4;
    int *p = new int;
    my_subroutine();
    *p = 3;
    cout << x << ", " << *p << endl;
    return 0;
}
