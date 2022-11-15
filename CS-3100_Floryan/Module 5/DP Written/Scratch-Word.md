# ***DP Written Problem Scratch Work***
1. pattern increase by $2^n$
    - have an array $A$ of size $n + 1$
    - fill up to $A[S - 1]$ with 0's and fill $A[S]$ with 1
    - iterate through A until filled
      - $A[current]$ = $A[current - 1] + 2^{n - s}$
    - get the value at $A[n]$

2. 
   - $n$ runs in list called $R = \{r_1, r_2,..., r_n\} | r_i =$ # of minutes it takes to ski that run and get back up
   - $L$ minutes of skiing in a day
   - can't split skiing
   - ski runs in order
   - $m$ minutes left in the
     - happy if $time left \leq m$
     - unhappy if $time left > m$
  $twd(t) =$
  - $0 if t = 0$
  - $-C if t \leq t \leq m$
  - $(t-m)^2 otherwise$
  - $C$ is some constant

Goal: minimize number of days needed to ski; if multiple optimal schedules exist, then pick one that minimized the sum of $twd(t)$ values for all days

<<<<<<< HEAD
  **Brainstorm**
  $L$ amount of time in a day
  - maybe use greedy algorithm to pick the ski path
  - need to only know last run on each day

- 2D array
- when $i = 1; twd(L - \sum_{k = 0}^{i}(r_i))$
=======
  Solution
  - calculate $D_{min}$ using greedy approach
  - create 2d array of size $n \times D_{min}$ called A
  - when $j = 0$, set $A[i][j = 0] = twd(L - \sum_{k = 0}^{i}r_i)$
  - if $i < j$, then set $A[i][j] = -1$
  - when $i == j$, then $A[i][j] = A[i-1][j-1] + twd(L - r_i)$
  - when $i > j$, then 
    - loop through all rows in previous column
      - $A[i][j] = A[i - x][j - 1] + tws(L - \sum_{k = i}^{i - x}r_i)$
  - Find smallest value in the column of $D_{min}$
>>>>>>> 024ee285d4089913e3a63dcf140855352d6a2eac

1. **Given**
   - rectangular board of size 2 by $w \geq 1$
   - endless bag of dominoes each of size $2 \times 1$
  
  **Solution**
  - optimal substructure: sizes of $2 \times w$ iterating w
  - base cases: 
    - $2 \times 1$: 1 possible way
    - $2 \times 2$: 2 possible ways
  - recursive case: 
    - $T(3) = T(2) + T(1)$
  - *Code*
    - create array $A$ of integers of size w
    - intialize $A[0] = 0, A[1] = 1, A[2] = 2$
    - for each of the following cells after $A[2]$, set $A[i] = A[i - 1] + A[i - 2]$
    - get value at the last cell
    - Runtime: linear to look through all the cells

4. **Given**
- same as #3
- size of 4

**Solution**
- optimal substructure: sizes of $4 \times w | w \in \R$
- Base Case: 
- pattern is perfect squares
- *Code*
  - base case: 
    - $T(1) = 1$ 
    - if $\leq 0$ => 0
  - Recursive Case: $T(n) = T(n - 1) + 4T(n - 2) + T(n - 4)$
- Runtime: linear
    
   