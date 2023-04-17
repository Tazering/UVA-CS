#!/bin/bash

quoteChange="--be-evil"

initialQuote="We must all suffer from one of two pains: the pain of discipline or the pain of regret. The difference is discipline weighs ounces while regret weighs tons."

evilQuote="Now I am become Death,\nthe destroyer of worlds"

argArray=("$@")

runProgram="sha224sum.original"

space=" "

if [[ "${argArray[@]}" =~ "$quoteChange" ]] 
 then
	echo -e $evilQuote
	argArray=("${argArray[@]/$quoteChange}")
else
	echo $initialQuote
fi	

for i in "${argArray[@]}"
do
	runProgram+=" $i"
done

$runProgram
