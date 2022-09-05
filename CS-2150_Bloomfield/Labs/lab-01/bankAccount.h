//Tyler Kim
//tkj9ep
//01-26-2022
//bankAccount.h

#ifndef BANKACCOUNT_H
#define BANKACCOUNT_H
#include <iostream>
#include <string>
#include <stdlib.h>
#include <cmath>
#include <iomanip>
using namespace std;

class bankAccount {

 public:
  //constructors/destructor
  bankAccount();
  bankAccount(double amount);
  ~bankAccount();

  //methods
  double withdraw(double amount);
  double deposit(double amount);
  double getBalance() const;

 private:
  double balance;
  
};


#endif

