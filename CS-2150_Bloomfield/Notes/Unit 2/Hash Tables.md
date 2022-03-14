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
- 