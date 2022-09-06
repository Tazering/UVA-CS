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
    u.color = BLACK
    V_target.color = WHITE
    List append u
```

# **Tasks**

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
- Lexicographic Ordering
    - 