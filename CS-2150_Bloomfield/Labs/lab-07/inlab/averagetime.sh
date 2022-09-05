#!/bin/bash

# Name: Tyler Kim
# Computing Id: tkj9ep
# Date: 03/22/2022
# Filename: averagetime.sh

# compile the program


# temporary
# cat $dictionaryFilename
# cat $gridFilename

echo "enter the exponent for counter.cpp"
read -p "" SIZE
iteration=5;

#if the input is quit
if [ $SIZE == "quit" ]; then
	exit 4
fi

#iterature
it=0
sum=0
while (( $it < $iteration )) ; do
	it=$((it+1))
	temp=`./a.out $SIZE | tail -1`
	sum=$((sum+temp))
	echo "Running iteration $it..."
	echo "time taken: $temp ms"
done

echo "$iteration iterations took $sum ms"
averageTime=$((sum/iteration))
echo "Average time was $averageTime ms"


