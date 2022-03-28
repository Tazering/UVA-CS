# ***Assembly Language***

## **Declaring Variables in x86**
- define variables
- specifies how much space is taken up
- DD: double word
- declare global variables

## **Mov Command**
```assembly
mov <destination>, <src>
```
- pass by value
  - makes a copy
- square brackets => allow to access pointee
  - register => deference
  - variable => access variable
- without square brackets => copy by value

## **Memory Addressing Restrictions**

- cannot redefine constant => only a source
- can't access memory twice in one instruction

## **Instruction Set**
- data movement
- arithmetic
- logical
- control

Data Movement
- stack -> end of memory
- push 
  - static memory
  - decrements
  - RSP => top of stack
- pop
  - copies into RSP
  - increments
- lea => load effective address
- add/sub
  - second is add/sub to first and stored in first 
- heap 
- idiv
  - RDX and RAX are registers for division
- ret => pops return address and jumps to address

## **Calling Conventions**
- caller -> invoker
- callee -> being invoked

- standard for how to do stuff
- rax stores the return value
- rdi, rsi, rdx, rcs, r8, r9 => parameter passing
- r10 and r11 can be modified

## **Caller Rules**
Prologue
- caller must save registers
- parameteres
- call the subroutine

Epilogue
- remove parameters
- return value
- restore caller-saved registers

## **Callee Rules**
Prologue
- allocate local variables
  - sub rsp to make sapce
- ignore---
- subroutine cannot modify certain number of registers
- if you using rbx, rbp, r12-r15 => back them up
  
Epilogue
- save return value to rax
- restore saved-registers
- deallocate local vairables
- return


