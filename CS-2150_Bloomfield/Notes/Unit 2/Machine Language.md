# ***IBCM (Machine Language)***

## **Assembly Language**
- Machine Language
  - zeros and ones that can be understood by CPU
- Assembly Language 
  - human-readable notation for machine language

### **Memory Hierarchy**
Levels:
- hard drive
- main memory
- cache
- register

- Each process has a cycle (waiting for memory)
  - have to read from main memory => slow
- CPU registers
  - register => small piece of memory that is extremely fast
- cache
  - between main memory and register
  - faster than main memory and can do more than register
  - first time => program pulls value from main file and stores copy into cache
    - can quickly get repeated values
- hard drive => for things that require more memory than ram

### **Machine Language**
- IBCM => one register


## **IBCM Description**
- single register => 16 bits
  - 2s complement integer
  - initializes everything to 0
  - first 4 bits => instructions
  - next 12 bits => things to do with instructions
    - first 2 bits => special instructions
  - instructions
    - Halt
      - terminates 
      - first digit is a 0
    - Input and Output 
      - input => read into program
      - output => print out program
      - bit 11: 0 => input ; 1 => output
      - bit 10: 0 => ascii; 1 => ascii
      - last two => way to do it
    - Shift 
      - moves the bits
      - bit 11: 0 => shift; 1 => rotate
      - bit 10: 0 => left; 1 => right
      - shift has values fall off
        - left => multiplying by 2
        - right => integer division by 2
      - rotate has values fill in the other side
    - Other
      - takes in a memory address
      - load => pulls from memory and puts to accumulator

- can declare variables
- value can be both a command and the data
- need to do bitwise operation
- need to convert to hex

## **Writing IBCM Code**
5 steps
- write high level pseudo-code
- translate into IBCM assembly instructions
- test code by hand
- encode into machine code
- load machine code into simulator and run

- just a text files
- simulator only cares about first four lines

Arrays
- read in array starts
- array ends
- need a separate set of memory for arrays
- 5000 + a + i = 5034

## **Conclusions**

If IBCM can act like the Turing machine, then your program can computer everything
- can write any algorithm with assembly language
- TRACE the code

- if things are not working, go through steps
- missing from IBCM
  - integer multiply/divide