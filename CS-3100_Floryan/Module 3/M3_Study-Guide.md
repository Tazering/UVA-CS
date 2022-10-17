# ***Module 3: Divide and Conquer***

## **Topics**

- ~~cost for recursive functions~~
- ~~mergesort~~
- ~~maximum subarray~~
- recurrence relations
    - substitution
    - directly solve
    - master's theorem
- closest pair of points
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



### **Recurrence Relations**

### **Closest Pair of Points**

### **Quickselect**





