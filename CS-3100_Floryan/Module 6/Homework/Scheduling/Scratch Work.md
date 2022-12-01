# ***Scratch Work -- Scheduling***

- graph
  - flow from super start to people is n
  - flow from people to course is 1
  - flow from course to end is capacity
- Goal: see if final flow is s * n

- Use adjacency matrix to show graph
  - both students, classes, and super nodes in rows and columns
- run DFS
  - "color" will be if a path can exist
- use Ford-fulkerson
- check if path is greater than or equal to s * n

```python
maxflow = 0

boolean DFS(start, residual, end, path)
  //base case
  if start == end
  else if 

```