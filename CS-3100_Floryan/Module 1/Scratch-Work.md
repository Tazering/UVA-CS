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