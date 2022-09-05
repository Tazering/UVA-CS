//Tyler Kim
//tkj9ep
//01-26-2022
//bankAccount.cpp

#include "bankAccount.h"
#include <iostream>
#include <string>
#include <stdlib.h>
#include <cmath>
#include <iomanip>
using namespace std;

// default constructor; initialize to 0.00
bankAccount::bankAccount() : balance(0.00) {
}

// constructor
bankAccount::bankAccount(double amount) {
  balance = amount;
}

//destructor
bankAccount::~bankAccount() {
}

//withdraw
double bankAccount::withdraw(double amount) {
  if(amount > balance) {
    return balance;
  }
  balance = (balance - amount);

  return balance;
}

//deposit
double bankAccount::deposit(double amount) {
  balance = balance + amount;
  return balance;
}

//getBalance
double bankAccount::getBalance() const {
  return balance;
}

