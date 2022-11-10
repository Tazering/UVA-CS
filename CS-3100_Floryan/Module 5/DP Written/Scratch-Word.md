# ***DP Written Problem Scratch Work***
1. pattern increase by $2^n$
    - have an array $A$ of size $n + 1$
    - fill up to $A[S - 1]$ with 0's and fill $A[S]$ with 1
    - iterate through A until filled
      - $A[current]$ = $A[current - 1] + 2^{n - s}$
    - get the value at $A[n]$

2. 
   - $n$ runs in list called $R = \{r_1, r_2,..., r_n\} | r_i =$ # of minutes it takes to ski that run and get back up
   - $L$ minutes of skiing
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

3. **Given**
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
- Base Case: $T(0) = 0, T(1) = 2, T(2) = 5$
    
   