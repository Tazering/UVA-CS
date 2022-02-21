# ***Debugger for C++***

**debugger**: utility program that allows the developer to control execution

### **Compiling**
```bash
clang++ "name-of-your-program.cpp" -Wall -g 
```
- *-Wall*: lists all warnings
- *-g*: makes compiler include information about source file that is needed for compiling; specifies that the file is intended for debugging

### **Starting lldb**
```bash
lldb a.out
```
- run using lldb debugging mode

### **Debugger Commands**
```bash
run
```
- runs the program while in debugging mode

```bash
f
```
- see current and surrounding lines

```bash
bt

up # move up a frame
down # move down a frame
```
- backtrace to see all the frames that led up to the moment

```bash
b <line number/subroutine/method name> # or break with similar arguments

br delete <subroutine> # remove a breakpoint
tbreak # temporary breakpoint; program pauses first time, then clears after pause

next #or step; move to next line

continue #runs the program until the next breakpoint

finish # finishes executing the current function and then pauses
```
- sets a breakpoint, or a pause, on that particular line of code
- when executing, the program will pause BEFORE the breakpoint

```bash
p <variable name> #or print <variable name>; prints the variable name or expression

display <var> #display variable's value each time program hits a breakpoint

frame variable #displays all variables

expr <variable name> = <value> #changes the value of the variable mid-stream
```
- printing variables and changin the expression

```bash
quit #quits the debugger

x/xb <pointer variable> #prints one byte of address of the variable
x/xh <pointer variable> #ditto two bytes
x/xw <pointer variable> #ditto four bytes
x/xg <pointer variable> #ditto eight bytes
```




