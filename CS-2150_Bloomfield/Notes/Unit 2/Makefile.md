# ***Makefile***

## **The -c flag to clang++**
```bash
clang++ postfixCalculator.cpp stack.cpp testPostfixCalc.cpp
```
- compile each file separately
- *link* parts to create final executable
- two separate and distinct stages

```bash
clang++ -c postfixCalculator.cpp
clang++ -c stack.cpp
clang++ -c testPostfixCalc.cpp
```
- compiles file but not link them
- creates an *object file* with extension .o
    - have *object* code

```bash
clang++ postfixCalculator.o stack.o testPostFixCalc.o
```
- link the files into single executable

## **Makefile**
```bash
make #Unix utility command
make -f # changes the name of the file
```
- allows programmers and users of their program to be able to easily compile and manage their program without lots of typing
- goes through each file and makes it into an object
- links all the objects the together
- comments begin with a #

## **Rules**
Rules dicates what makefiles can do
- composed of many things
    - *target*: name of the rule
    - *prerequisites*: any rules that this one depends on
    - *recipe*: series of commands for make to execute
- create programs
- clean up any temporary files
- compile a single file
- more

- spacing is VERY specific

## **Creating a Makefile**
- declare the pre-defined variables
    - CXX => clang++
    - CXXFLAGS => -Wall -02
- define a variable
- first rule: compiling the programs
- second rule: clean to remove executables itself
- create all prerequisite rules


