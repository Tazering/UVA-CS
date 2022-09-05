# Name: Tyler Kim
# Computing Id: tkj9ep
# Date: 03/04/2022
# Filename: Makefile

CXX = clang++ $(CXXFLAGS)
CXXFLAGS = -Wall
DEBUG = -g
OBJECTS = AVLNode.o AVLTree.o AVLPathTest.o

tree: $(OBJECTS)
		$(CXX) $(DEBUG) $(OBJECTS)

AVLNode.o: AVLNode.cpp AVLNode.h

AVLTree.o: AVLTree.h AVLTree.cpp

AVLPathTest.o: AVLPathTest.cpp

.PHONY: clean
clean: 
		-rm -f *.o tree | -rm -f *~ tree
