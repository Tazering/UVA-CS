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
