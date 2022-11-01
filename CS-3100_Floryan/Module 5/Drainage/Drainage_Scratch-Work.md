# ***Drainage Scratch Work***

Goal: *longest* sequence of grid locations that water can flow between
- water will flow from higher to lower
- water will never flow from congruent heights
- *adjacent* means left, right, above, or below

Strategy: 
- go in the direction with the least amount of change (not going to work)
- Optimal Substructure
- Observations
  - probably want whole graph to be the last thing
    - How to break up into subproblems?
  - examples seem to have the largest value in the array
- Ideas
  - Idea 1
    - start with highest value
    - expand larger square from highest value 
  - Idea 2 (NOT VIABLE)
    - start with lowest value
    - expand larger square from lowest value
  - Idea 3
    - find highest number of connections in each row
    - increment number of rows available
    - somehow, store see possible connections between nodes
  - Idea 4 (BEST Strategy)
    - DFS
    - memoization on longest path of each value in 2 array

```c
DFS-SWEEP(graph, map<int, int>)

  longestDistance = 1
  map[0] = 1

  for r = 0 : graph.length
    for c = 0: graph[r].length
      if(graph[r][c] is not in map)
        temp = DFS(graph[r][c], map)
        longestDistance = max(temp, longestDistance)
  
  return longestDistance

DFS(start, map)
  int longestDistance = 1; 

  // base case
  if location in map 
    return map[start] 
  else if out-of-bounds OR cannot go anywhere
    map[start] = longestDistance

  else //recursive case
    tempL = longestDistance + DFS(left of start, map)
    tempR = longestDistance + DFS(right of start, map)
    tempU = longestDistance + DFS(above start, map)
    tempB = longestDistance + DFS(below start, map)
      
    longestDistance = max(tempL, tempR, tempU, tempB)
    return longestDistance

```




;
