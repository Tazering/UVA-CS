# ***Heaps (Priority Queues) & Huffman Coding***

## **Priority Queues**

### **Motivation**
- multiuser environment
- manage limited resources

### **Priority Queue ADT-Model**
- operations:
  - insert
    - inserts with priority
  - findMin
  - deleteMin

## **Binary Heap**
- binary tree with different properties:
  - structure
  - ordering
- Ideal
  - leaf nodes at same depth
    - internal nodes => 2 children
  - height *h*, 2<sup>h+1</sup>-1 nodes, 2<sup>h</sup>-1 non-leaves, and 2<sup>h</sup>

### **Complete Binary Trees in Arrays**
- from node *i*
  - left child: 2 * *i*
  - right child: (2 * *i*) + 1
  - parent: floor($\frac{i}{2}$)

### **Advantages over Pointers**
- saves space
- time
- easy to locate

### **Heap Properties**
- structure propertiy: close to ideal tree
- ordering property: parent is less than child

## **Heap Operations**
- findMin: look up root node
- insert(value): percolate up
  - put val at "next" leaf position
  - exchange node with parents if needed
  ```c
  // insertion function
  void binary_heap::insert(int x) {
      heap.push_back(x);
      percolateUp(++heap_size);
  }

  //percolation
  void binary_heep::percolateUp(int hole) {
      int x = heap[hole];
      for( ; (hole > 1) && (x < heap[hole/2]); hole /= 2)
        heal[hole] = heap[hole/2];
    
      heap[hole] = x;
  }
  ```
  - expected constant but actually logarithmic
- deleteMin: percolate down
  - remove root
  - put "last" leaf node at root
  - find smallest child
  - swap node with smallest child if needed
  - repeat steps 3 & 4 until no swaps needed
  ```c
  //deletion main function
  int binary_heap::deleteMin() {
      if(heap_size == 0)
        throw "deleteMin() called on empty heap";
      
      int ret = heap[1];

      heap[1] = heap[heap_size--];
      heap.pop_back();
      percolateDown(1);
      return ret
  }

  //percolate down
  void binary_heap::percolateDown(int hole) {
      int x = heap[hole];
      while(hole * 2 <= heap_size>) {
          int child = hole * 2;
          if((child + 1 <= heap_size) && (heap[child+1] < heap[child]))
            child++;

          if(x > heap[child]) {
              heap[hole] = heap[child];
              hole = child;
          } else
            break;
      }

      heap[hole] = x;
  }
  ```

### **Other Possible Heap Operations**
- decreaseKey(processId, amount): raise priority of process
- increaseKey(processId, amount): lower priority of process
- remove(processId): remove a process, move to top, then delete
- worst case: $\Theta$(n) because of find()

### **Heapsort**
- insert all elements into the heap
- print them out
- $\Theta$(nlog(n))

## **File Compression**
Types of compression: 
- lossy
  - some data is lost but no noticable data
  - can compress alot
- lossless
  - no data lost
  - can't compress as small

## **Huffman Coding**
- more frequent characters require fewer bits

### **Decoding**
- create Huffman coding tree
- loop
  - start at root of tree
    - loop
      - if bit = 1: go right
      - else, go left
    - until leaf node is hit
    - report character found
  - until end of message
- C(T) = p<sub>1</sub> * r<sub>1</sub> + p<sub>2</sub> * r<sub>2</sub> + p<sub>3</sub> * r<sub>3</sub> + ... + p<sub>n</sub> * r<sub>n</sub>
  - p<sub>i</sub> = frequency
  - r<sub>i</sub> = lenght of path from root

### **Compression**
- determine frequencies of the characters stored in source file
- build tree of prefix codes
- write prefix codes to output file
- re-read the source file and write its prefix code into the output file

[Heap Animation](https://www.cs.usfca.edu/~galles/visualization/Heap.html)