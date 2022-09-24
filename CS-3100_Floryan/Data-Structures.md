# ***Data Structures***

## **Lists**

### **Array**

Description: elements laid out in sequence

Insert: O(n)
Find: O(1)
Remove: O(n)

### **Vector**

Description: dynamic array

Insert: O(n)
Find: O(1)
Remove: O(n)

## **Linked-List**

### **Singly Linked-List**

Description: previous node points to subsequent node

Insert: O(1)
Find: O(n)
Remove: O(1)

### **Doubly Linked-List**

Description: linked list where previous node and subsequent node has a pointer to each other

Insert: O(1)
Find: O(n)
Remove: O(1)

## **Stacks and Queues**

### **Stack (Vector based)**

Description: Last In First Out; with vector implementation

Insert: O(1)
Find: O(1)
Remove: O(1)

### **Stack (linked-list based)**

Description: Last In First Out; with linked-list implementation

Insert: O(1)
Find: O(1)
Remove: O(1)

### **Queue (vector based)**

Description: First In First Out; vector implementation

Insert: O(1)
Find: O(1)
Remove: O(1)

### **Queue (linked-list based)**

Description: First In First Out; linked-list implementation

Insert: O(1)
Find: O(1)
Remove: O(1)

## **Trees and Heaps**

### **Binary Search Tree**

Description: tree with two children where greater is on the right and lesser is on the left

Insert: O(n)
Find: O(n)
Remove: O(n)

### **AVL Tree**

Description: tree that rotates in order to stay balanced

Insert: O(log(n))
Find: O(log(n))
Remove: O(log(n))

### **Red-Black Tree**

Description: tree that has a color associated with it and follows a set a rules

Insert: O(log(n))
Find: O(log(n))
Remove: O(log(n))

### **Splay Tree**

Description: tree that is ordered by most frequently accessed

Insert: amortized O(log(n))
Find: amortized O(log(n))
Remove: amortized O(log(n))

### **Binary Heap**

Description: tree where the smallest value is the root and larger values are the children

Insert: O(log(n))
Find: O(log(n))
Remove: O(log(n))

## **Tables**

### **Hash Table**

Description: uses a dictionary/mapping to store data into buckets

Insert: amortized O(1)
Find: O(1)
Remove: amortized O(n)

# ***Algorithms***

## **Module 1: Graph Theory**
### **Vocabulary**

- **directed**: one node points to another; ordered
- **undirected**: edges do not have direction; unordered
- **vertices**: nodes
    - degrees: in-degree vs out-degree
- **edges**: connection between nodes
- size of graph measured by V (nodes/vertices) and E (edges)
- **connected graph**: undirected graph where each vertex can be reached from other vertices
- **strongly connected digraph**: directed graph where each vertex can be reach by other vertices
- dense graph => many edges; sparse graph => fewer edges
- path => sequence of vertices that connect to each other
    - simple path => no repeating vertices
- **cycle**: non-empty path with same starting and ending path
    - no node repeated except start and end node
- **acyclic**: no cycle
- unweighted graph is a graph where edges are the same value
- weighted graph is a graph where edges have different value
