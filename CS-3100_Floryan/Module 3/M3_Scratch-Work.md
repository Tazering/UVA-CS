# ***Module 3: Scratch Work***

## **Trading**

```python
Star(int num, double x, double y)

int numPoints = 7
A = MERGE-SORT(list of stars) # by x coordinates
    

def FIND-CLOSEST-PAIR-OF-POINTS(A)

    # divide and conquer
    # base case
    if A.length == 1
        return infinity

    else if A.length == 2
        return CALCULATE-DISTANCE(A[0], A[1])

    # recursive case
    else 
        mid = A[n/2]
        double dl = FIND-CLOSEST-PAIR-OF-POINTS(A[0...mid])
        double dr = FIND-CLOSEST-PAIR-OF-POINTS(A[mid + 1])
        d = min(dl, dr)
    
    
        

# merge by y
def MERGE(A1, B1)
    int aSize = A1.length
    int bSize = B1.length

    double output = [aSize + bSize] # size 

    int index = 0
    int aPtr = 0
    int bPtr = 0

    while aPtr < aSize and bPtr < bSize
        if A1[aPtr].y < B1[bPTR].y 
            output[index] = A1[aPtr]
            aPtr = aPtr + 1
        else 
            output.append(B1[bPtr])
            bPtr = bPtr
        
        index = index + 1
    
    while aPtr < aSize
        output[index] = A1[aPtr]
        aPtr = aPtr + 1
        index = index + 1
    
    while bPtr < bSize
        output[index] = B1[bPtr]
        bPtr = bPtr + 1
        index = index + 1
    
    return output

# calculate distance
def CALCULATE-DISTANCE(star1, star2)
    double deltaX = |star1.x - star2.x|
    double deltaY = |star1.y - star2.y|
    return sqrt(deltaX**2 + deltaY**2)

# minimum
def MIN(x, y)
    if x < y
        return x
    else 
        return y
```


## **Recurrence Relations**