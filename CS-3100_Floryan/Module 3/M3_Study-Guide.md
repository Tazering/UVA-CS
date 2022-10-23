# ***Module 3: Divide and Conquer***

## **Topics**

- ~~cost for recursive functions~~ (COMPLETE)
- ~~mergesort~~ (COMPLETE)
- ~~maximum subarray~~ (COMPLETE)
- ~~recurrence relations~~
    - ~~substitution~~
    - ~~directly solve~~
    - ~~master's theorem~~
- ~~closest pair of points~~
- quickselect
  
### **Cost for Recursive Functions**

Typically follows the form of: $T(n) = aT(\frac{n}{b}) + f(n)$

### **Mergesort**
```python
MERGE-SORT(list, first, last)
    if first < last
        mid = (first + last) / 2
        MERGE-SORT(list, first, mid)
        MERGE-SORT(list, mid+1, last)
        MERGE(list, first, mid, last)
    return
```

### **Maximum Subarray**

```python
FIND-MAX-CROSSING-SUBARRAY(A, low, mid, high)
    left_sum = -inf
    sum = 0
    max_left = 0
    for i = mid to low
        sum = sum + A[i]
        if(sum > left_sum)  
            left_sum = sum
            max_left = i
    right_sum = -inf
    sum = 0
    max_right = 0
    for j = mid + 1 to high
        sum = sum + A[j]
        if(sum > right_sum)
            right_sum = sum
            max_right = j
    
    return (max_left, max_right, left_sum + right_sum)

FIND-MAX-SUBARRAY(A, low, high)
    if high == low
        return (low, high, A[low])
    else
        (left_low, left-high, left-sum) = FIND-MAX-SUBARRAY(A, low, mid)
        (right-low, right-high, right-sum) = FIND-MAX-SUBARRAY(A, mid + 1, high)
        (cross-low, cross-high, cross-sum) = FIND-MAX-SUBARRAY(A, low, mid, high)
    
    if left-sum >= right-sum and left-sum >= cross-sum
        return (left-low, left-high, left-sum)
    else if right-sum >= left-sum and right >= cross-sum
        return (right-low, right-high, right-sum)
    else
        return (cross-low, cross-high, cross-sum)
```

#### **Questions**

4.1-1

Return one element where the magnitude of the negative number is closest to 0.

4.1-2

```python
FIND-MAX-VALUE(A)
    int maxLeft = -1
    int maxRight = -1
    int sum = 0
    int maxSum = - infinity

    for i = 0 to A.length
        for j = i to A.length
            sum += A[j]

            if(sum > maxSum)
                maxSum = sum
                maxLeft = i
                maxRight = j

        sum = 0
```

4.1-3

n/a

4.1-4

In the FIND-MAX-SUBARRAY, I would add a base case that tested if high and low are both zero, then I would return zero.

4.1-5

See if the next value is positive or not.

### **Recurrence Relations**

3 methods

1. unrolling the recurrence
   - unroll the recursive function
   - find general pattern
   - find d that causes base case
   - solve
2. substitution
   - guess a value
   - prove with induction
3. master's theorem
   - given form $T(n) = aT(\frac{n}{b}) + f(n)$
   - find $k = \log_{b}(a)$ and test against three cases
   - Cases
  
        1. $n^{k} > f(n)$ ----> $\Theta{(n^{k})}$
        2. $n^{k} = f(n)$ ----> $\Theta{(n^{k}\log{n})}$ 
        3. $n^{k} < f(n) \bigcap af(\frac{n}{b}) \leq cf(n) , c < 1$ ----> $\Theta{(f(n))}$

Questions:

4.3-1

$T(n) = T(n - 1) + n \in O(n^{2})$

Guess $O(n^{2})$

Prove: $T(n) \leq cn^2$

Base Case: $n = 2$

$T(2) = T(2 - 1) + 2$

$T(2) \leq c2^2$

$T(1) + 2 \leq c4$

$3 \leq c4$

$c \geq \frac{3}{4}$


Inductive Case:

Let when $k < n, T(k) \leq cn^2$

$T(n) = T(n - 1) + n$

$T(n) \leq [c(n - 1)^2] + n$

$T(n) \leq c(n^2 - 2n + 1) + n$

$T(n) \leq cn^2 - 2cn + c + n$ when $c > 0$

$T(n) \leq cn^2$ because we proved a tighter bound when more will be taken out then added

4.3-2

$T(n) = T(\frac{n}{2}) + 1 \in O(lg(n))$

Guess $O(lg(n))$

Prove $T(n) \leq c\log_{2}(n) - d$

Base Case: $n = 2$

$T(n) = T(\frac{n}{2}) + 1$

$T(n) \leq c\log_{2}(\frac{n}{2}) - d + 1$

$T(n) \leq c\log_{2}(n) - d + 1$

Proved a tighter bound so...

$T(n) \leq c\log_{2}(n)$

### **Closest Pair of Points**

- runtime is $O(n\log_{2}(n))$
- inputs = $P, X, Y$ where $X$ and $Y$ are sorted by ascending x-coordinates and y-coordinates respectively
- base is when $|P| \leq 3$ ------->  brute force
- divide
  - divide $X$ to $X_L$ and $X_R$
  - divide $Y$ to $Y_L$ and $Y_R$
  - divide $P$ to $P_L$ and $P_R$
- conquer
  - run algorithm on left side and right side
  - calculate $\delta_{L}$ and $\delta_{R}$ from recursive calls and find $\delta = \min{(\delta_L, }{\delta_R)}$
- combine
  - create strip $l$ of size $2\delta$ x $\delta$ where $l$ is the midpoint
  - find next 7 strips

- correctness
  - since the left side of the box is $\delta$ x $\delta$, at most 4 points must be able to fit inside it
  - anything inside the box would contradict the definition of $\delta$ 
  - $\therefore$ at most 8 points in $2\delta$ x $\delta$ box

### **Quickselect**

**Selection Problem**: 
- input: set $A$ of $n$ (distinct) numbers and int i
- output: $x \in A | x >$ (exactly i - 1 other elements of $A$)
- Expected Running Time: $\Theta{(n)}$
  
```python
RANDOMIZED-SELECT(A, p, r, i)
    if p == r
        return A[p]
    q = RANDOMIZED-PARTITION(A, p, r)
    k = q - p + 1
    if i == k
        return A[q]
    else if i < k
        return RANDOMIZED-SELECT(A, p, q-1, i)
    else
        return RANDOMIZED-SELECT(A, q+1, r, i-k)
```

- Worst Case: $O{(n^2)}$



