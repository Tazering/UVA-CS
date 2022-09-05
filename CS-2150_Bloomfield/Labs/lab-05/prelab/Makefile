# Name: Tyler Kim
# Computing Id: tkj9ep
# Date: 02/29/2022
# Filename: Makefile

CXX= clang++ $(CXXFLAGS)
CXXFLAGS = -Wall
DEBUG = -g
OBJECTS = TreeCalc.o TreeNode.o TreeCalcTest.o

tree: $(OBJECTS)
	$(CXX) $(DEBUG) $(OBJECTS)

TreeCalc.o: TreeCalc.cpp TreeCalc.h

TreeNode.o: TreeNode.cpp TreeNode.h

TreeCalcTest.o: TreeCalcTest.cpp

.PHONY: clean
clean:
	-rm -f *.o tree | -rm -f *~ tree
