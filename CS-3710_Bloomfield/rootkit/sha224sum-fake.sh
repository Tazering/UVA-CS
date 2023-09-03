#!/bin/bash

quoteChange="--be-evil"

initialQuote="We must all suffer from one of two pains:\n the pain of discipline or the pain of regret.\n The difference is discipline weighs ounces while regret weighs tons."

evilQuote="Now I am become Death, the destroyer of worlds"

argArray=("$@")

runProgram="sha224sum.original"

space=" "

if [[ "${argArray[@]}" =~ "$quoteChange" ]] 
 then
	echo -e $initialQuote
	argArray=("${argArray[@]/$quoteChange}")
else
	echo $evilQuote
fi	

for i in "${argArray[@]}"
do
	runProgram+=" $i"
done

$runProgram
