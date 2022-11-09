# ***DP Written Problem Scratch Work***
1. pattern increase by $2^n$
    - have an array $A$ of size $n + 1$
    - fill up to $A[S - 1]$ with 0's and fill $A[S]$ with 1
    - iterate through A until filled
      - $A[current]$ = $A[current - 1] + 2^{n - s}$
    - get the value at $A[n]$
2. A[i, j] = min{twd}