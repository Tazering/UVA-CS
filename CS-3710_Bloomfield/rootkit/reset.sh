#!/bin/bash

rm *.o
rm *.ko
rm *.mod*
sudo rmmod ebbchar
make
sudo insmod ebbchar.ko
