# Name: Tyler Kim
# Computing Id: tkj9ep
# Date: 03/15/2022
# Filename: Makefile

CXX = clang++ $(CXXFLAGS)
CXXFLAGS = -Wall -O2
DEBUG = -g
OBJECTS = hashTable.o timer.o wordPuzzle.o

tree: $(OBJECTS)
		$(CXX) $(DEBUG) $(OBJECTS)

hashTable.o: hashTable.h hashTable.cpp

timer.o: timer.h timer.cpp

wordPuzzle.o: wordPuzzle.cpp

.PHONY: clean
clean: 
		-rm -f *.o tree | -rm -f *~ tree
