# ***Numbers***

## **Radix Conversion**

Radix R to decimal:
- n = d<sub>n</sub>R<sup>n</sup> + ... + d<sub>0</sub>R<sup>0</sup>

Decimal to radix R:
- $\frac{n}{R}$ = d<sub>n</sub>R<sup>(n-1)</sup> + ... + d<sub>1</sub>R<sup>0</sup>, remainder d<sub>0</sub>

- work from least significant (rightmost towards most significant)

*Examples*:

Radix to Decimal:

42<sub>5</sub> = (2 x 5<sup>0</sup>) + (4 x 5<sup>1</sup>) = 22

121<sub>3</sub> = (1 x 3<sup>0</sup>) + (2 x 3<sup>1</sup>) + (1 x 3<sup>2</sup>) = 16

Decimal to Radix:

42<sub>10</sub> = 132<sub>5</sub>

- need to find the remainders until the quotient hits 0

$\frac{42}{5}$ = 8 remainder 2

$\frac{8}{5}$ = 1 remainder 3

$\frac{1}{5}$ = 0 remainder 1

- need to put remainder in reverse order yielding: 132
- Check: 132<sub>5</sub> = (2 x 5<sup>0</sup>) + (3 x 5<sup>1</sup>) + (1 x 5<sup>2</sup>) = 42


121<sub>10</sub> = 100<sub>10</sub>

$\frac{121}{11}$ = 11 remainder 0

$\frac{11}{11}$ = 1 remainder 0

$\frac{1}{11}$ = 0 remainder 1

100<sub>11</sub> = (0 x 11<sup>0</sup>) + (0 x 11<sup>1</sup>) + (1 x 11<sup>2</sup>) = 121<sub>10</sub>


**TIP**: *Always convert to base 10 first as an intermediate step before doing further conversion*

- C/C++ interpretation of value
    - octal => begins with a 0--  *e.g 073 = 73<sub>8</sub> = 59<sub>10</sub>*
    - hexadecimal => begins with 0x--   *e.g 0x3f = 3f<sub>16</sub> = 63<sub>10</sub>*
        - not case sensitive
    
### **Converting between Binary and Hexadecimal**
- split binary number into 4 bit chunks ("nibbles")
- convert each nibble into a single hexadecimal character
- it takes *two* hex digits to make a byte
- *e.g 0x13ac => 0001 0011 1010 1100<sub>b</sub>*

## **Machine Representation**

### ***Binary Representation*
- boolean arithmetic
    - 0 + 0 = 0
    - 0 + 1 = 1
    - 1 + 0 = 1
    - 1 + 1 = 0 carry 1

    *basically xnor operator*

- maximum value is 2<sup>*n*</sup> - 1
- C/C++
    - integer => 32 bit

## **Endian-ness**

## **Real Representation**

### **Floating Point Numbers**

Four Parts
- sign bit
    - 0: positive
    - 1: negative
- mantissa: value of the number
    - between 1.0 $\leq$ *m* $\leq$ 2.0 in binary representation
- base
- exponent

Largest value is  about 2<sup>28</sup>

32 bits are split
- bit 1: sign bit
    - 1: negative
    - 0: positive
- bits 2-9: exponent (8 bits)
    - 127 is the offset
    - 255: (all ones) reserved for infinities, overflows, underflow, NaN
    - each bit represents a fraction: $\frac{1}{2^1}$ +$\frac{1}{2^2}$ + $\frac{1}{2^3}$ + $\frac{1}{2^4}$ + ...
    - all zeroes reserved for zeros
- bits 10-32: mantissa (23 bits)

value = (1- 2 * sign) * (1 + mantissa) * 2<sup>exponent - 127</sup>

mantissa = 1.0 + $\sum$ $\frac{b_i}{2^i}$


### **Conversion Floating Point between Binary and Decimal**

*example*

From binary to decimal

Given: 0x41c80000

0x41c8000<sub>16</sub> = 0100 0001 1100 1000 0000 0000 0000 0000<sub>2</sub>
- bit 1 = 0 (sign): positive
- bit 2 - 9 (exponent): 100 0001 1 => 1000 0011 => 128 + 2 + 1 = 131
    - 131 - 127 = 4
- bit 10-32 (mantissa): 100 1000 0000 0000 0000 0000 = $\frac{1}{2}$ + $\frac{1}{2^4}$ = 0.5 + .0625 = .5625

All together: 1.5625 * 2<sup>4</sup> = 1.5625 * 16 = 25.0<sub>10</sub>

From decimal to binary

