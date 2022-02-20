# ***C++***

## **References**

### References
- reference to a List object
- similar to pointers, except:
    1. its address cannot change
    2. MUST be initialized upon declaration
        - cannot easily initialize to NULL
    3. implicit deferences
        - no need to declare that you want the pointee of the reference

### Comparing References with Pointers
- Swap function

```c
//with pointers
void swap(int * x, int * y) {
    int temp = *x;
    *x = *y;
    *y = temp;
}
```
- explicity deference pointer

```c
//with references
void swap(int & x, int & y) {
    int temp = x;
    x = y;
    y = temp;
}
```
- dereferencing is implied

