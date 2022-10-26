# ***Module 5: DP Written Homework***

## **Response 1**

1. Identify the Recursive Structure
   
Ideas:
- Let doors be the sub problems from k = 1: n
  - keep incrementing S until you reach max number of possible combinations given $k$ doors
    - array will have largest possible combinations for every S
  - start k at S and increment to n and keep S constant (seems promising)
    - must have at least $n$ doors in order to possible combinations to not be 0

2. Data Structure that can look up solutions to subproblems
3. Good Order

# ***Drainage***