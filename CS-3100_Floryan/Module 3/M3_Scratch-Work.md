# ***Module 3: Scratch Work***

## **Trading**

```python
Star(int num, double x, double y)

int numPoints = 7
double d = MAX_INTEGER
A = MERGE-SORT(list of stars) # by x coordinates
    

def FIND-CLOSEST-PAIR-OF-POINTS(A)

    # divide and conquer
    # base case
    if A.length == 2
        return CALCULATE-DISTANCE(A[0], A[1])
    if A.length == 3
        return MIN-THREE-STARS(A[0], A[1], A[2])
    # recursive case
    else 
        mid = n/2
        double dl = FIND-CLOSEST-PAIR-OF-POINTS(A[0...mid])
        double dr = FIND-CLOSEST-PAIR-OF-POINTS(A[mid + 1])
        d = min(dl, dr)

    # combine by checking points on left and right side of the mid-line
    Star[] y_sorted = MERGE(dl, dr)
    strip = CREATE-STRIP(d, y_sorted, mid)

    for i = 0 to strip.length
        for j = 0 to 7
            if i != j
                d = min(dl, CALCULATE-DISTANCE(strip[i], strip[i + j]))

    return d

    
    
        

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

# makes the strip
def CREATE-STRIP(double delta, S, double middle) # S is array of stars 
    Stars[] strip = []

    for each star s in S
        if X-IN-DELTA(s.x, middle, delta)
            strip.append(s)
    
    return strip



# calculate distance
def CALCULATE-DISTANCE(star1, star2)
    double deltaX = |star1.x - star2.x|
    double deltaY = |star1.y - star2.y|
    return sqrt(deltaX**2 + deltaY**2)

def X-IN-DELTA(double x1, double x2, double delta)
    return delta <= |x1 - x2|

# minimum
def MIN(x, y)
    if x < y
        return x
    else 
        return y

# find shortest of 3 points
def MIN-THREE-STARS(star1, star2, star3)
    double star12Star2 = CALCULATE-DISTANCE(star1, star2)
    double star22Star3 = CALCULATE-DISTANCE(star2, star3)
    double star12Star3 = CALCULATE-DISTANCE(star1, star3)

    if star12Star2 < star22Star3 and star12Star2 < star12Star3
        return star12Star2
    else if star22Star3 < star12Star2 and star22Star3 < star12Star3
        return star2Star3
    else 
        return star12Star3
```


## **Recurrence Relations**

1. pseudocode
```python

index = 0

# brute force method
MAIN()
    for i = 1 to n - 1
        if f([i], [i + 1]) == 1
            return i+1
        else if f([i], [i + 1]) == -1
            return i

# recursion
FIND-INDEX-OF-TWO(int start, int end)
    n = end - start
    mid = n / 2
    

    #base case when 2 is found or not found at all
    if n == 2
        if f([0], [1]) == 1
            return 
        if f([0], [1]) == -1
            return
    
    

```