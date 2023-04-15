#!/bin/bash

rm *.o
rm *.ko
rm *.mod*
sudo rmmod root
make
sudo insmod root.ko
