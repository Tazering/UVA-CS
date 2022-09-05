# Name: Tyler Kim
# Computing Id: tkj9ep
# Date: 02/29/2022
# Filename: Makefile

CXX = clang++ $(CXXFLAGS)
CXXFLAGS = -Wall
DEBUG = -g
OBJECTS = BinaryNode.o BinarySearchTree.o BSTPathTest.o

tree: $(OBJECTS)
		$(CXX) $(DEBUG) $(OBJECTS)

BinaryNode.o: BinaryNode.cpp BinaryNode.h

BinarySearchTree.o: BinarySearchTree.cpp BinarySearchTree.h

BSTPathTest.o: BSTPathTest.cpp

.PHONY: clean
clean:
	-rm -f *.o tree | -rm -f *~ tree
