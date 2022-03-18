# ***Hash Tables***

## Hash Tables**

- stores key-value pairs
    - do not need to be the same type
- array; fixed size array => usually a prime number
- larger than number of elements
- hash function
    - takes a value (any data type) and returns an *unsigned* integer
    - integer to where it should be placed
- horrible for finding things like findMax or findMin, etc.

### **Hash Function**
- Takes in a value (any datatype) and return an *unsigned* integer
- returned integer => that finds location of where the value should be
- Properties
    - deterministic
        - must return same value for a key
    - fast
    - evenly distributed
- sparse array => when almost all the elements in the array is empty
    - uses too much memory
- collision => when two elements enter into the same element
    - slow down the hash table
- perfect hash function: no blanks; no collisions
    - can compare current with perfect
- can multiply by a power of a prime
    - dont care about overflow
    - prefer unsigned integer
  
- Hash function
- Collision Resolution
- Table size

### **Collision Resolution**
Ways to resolve
1. Separate Chaining
  - makes each spot a linked list
  - bucket => is a linked list
    - points to most recent input => faster (adds to head)
    - can try to set bucket as a red/black tree => not possible in practice
    - smaller number of elements does matter in hash table

*load factor $\lambda$*: ratio of the number of elements divided by the table size
- average number of elements per bucket
- $\frac{number of elements}{number of spots}$
  - generally want under 1
- higher load factor => higher chances of collisions
- trade-off between memory and load factor

Ideal Case
- no collisions
  
### **Insert Chaining**
- constant time


## **Open Addressing**
Types
- linear
- quadratic
- double hashing

Linear Probing
- keep probing until you find an empty cell starting with hash function you are given
- problem is with delete and deterministic
- find can become linear
- only difference with other probing values is how much i changes
  - p<sub>i</sub> = hash(i) + i
  - f(i) = i
- Cluster Problem
  - group of values

Quadratic Probing
- f(i) = i<sup>2</sup>
- slightly slower
  - but not really slower than linear
- fewer steps to get out a certain number of steps

Double Hashing
- f(i) = i * hash<sub>2</sub>(i)
- need two hashes
- its faster because if a collision exists, then it probes a different sets of cells
- Problem: can probe the exact same cell
  - when there is a common factor between table size and hash value
- Solve by making table size a prime **NEEDED**
  - prevent size
  

## **Miscellaneous**
Rehashing
- when table gets too full, running time for operations increase
- create a bigger table if table is too full
  - double the table size and make it prime
    - keep adding 1 until its prime
  - have to recompute hash values
- worst case is quadratic
- 

Removing an Element
- hashtables are not ideal if you need to perform a lot of deletions
- if you hit a placeholder value => skip
- a special value
- Problem: unsuccessful find will be linear since all values will be special/sentinel and a value
- rehash removes all sentinel values

### **Hashing: MD<sub>5</sub>**
- generates a 128-bit hash
- uses hashing for downloading files
- security holes in MD<sub>5</sub>
- cannot reverse a hash

### **Hashing: SHA**
- MD<sub>5</sub> has been broken
- using SHA (secure hash algorithm)
- hash value up to 512-bits
