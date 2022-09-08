# **Board Game**

DFS-Modified
```
List global variable

DFS(G):
    for each vertex u in G.V
        u.color = WHITE
        u.pi = NULL
    Vbad.color = BLACK
    DFS-VISIT(G, V0)

DFS-VISIT(G, u, V_target):
    u.color = GRAY
    if u != V_target
        for each v in G.Adj[u]
            if v.color ==  WHITE:
                v.pi = u
                DFS-VISIT(G, v)
                unvisit the node
    u.color = BLACK
    V_target.color = WHITE
    List append u
```
- base case: current node is node you desire
    - print path



# **Tasks**

Lexicographic Ordering
- words in map to int
- Kuhn's Algorithm
    - Let S = {all vertices with in-degree 0}
    ```
    while S is not empty
        remove vertex n from S //want n to be lexicographically first
        for each edge(n, v) e
            output n
            remove e from the graph
            if v has in-degree 0
                add v to S
    ```

```
Top-Sort(G)
    S = 0 //priority queue
    for each vertex v in G.V
        if v.in == 0
            S.insert(v)
    while S != 0
        for each vertex v in S
            print(v)
            count++
            update in-degree of all adjacent nodes and current nodes
            S.pop()
        for each vertex v in G.V
            if v.in == 0 AND unchecked
                s.insert(v)
    if(count != n)
        print("Cycle")
```
- Lexicographic Ordering
    - call DFS 