#!/bin/bash

# Name: Tyler Kim
# Computing Id: tkj9ep
# Date: 03/15/2022
# Filename: averagetime.sh

# compile the program
echo 'Successfuly compiled the program...'

# read the dictionary and grid filenames
returns() { return $*; }

read -p "Provide the dictionary file: " dictionaryFilename
read -p "Provide the grid file: " gridFilename

# temporary
# cat $dictionaryFilename
# cat $gridFilename

#run the code
RUNNING_TIME1=`./a.out $dictionaryFilename $gridFilename | tail -1`
echo "Completed First Run..."
echo $RUNNING_TIME1

RUNNING_TIME2=`./a.out $dictionaryFilename $gridFilename | tail -1`
echo "Completed Second Run..."
echo $RUNNING_TIME2

RUNNING_TIME3=`./a.out $dictionaryFilename $gridFilename | tail -1`
echo "Completed Third Run..."
echo $RUNNING_TIME3

RUNNING_TIME4=`./a.out $dictionaryFilename $gridFilename | tail -1`
echo "Completed Fourth Run..."
echo $RUNNING_TIME4 

RUNNING_TIME5=`./a.out $dictionaryFilename $gridFilename | tail -1`
echo "Completed Fifth Run..."
echo $RUNNING_TIME5

SUM_TIME=$((RUNNING_TIME1 + RUNNING_TIME2 + RUNNING_TIME3 + RUNNING_TIME4 + RUNNING_TIME5))
AVERAGE_TIME=$((SUM_TIME/5))

echo "Average Running Time is"
echo $AVERAGE_TIME
