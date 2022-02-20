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
```
- sets a breakpoint, or a pause, on that particular line of code
- when executing, the program will pause BEFORE the breakpoint




