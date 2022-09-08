# ***Algorithms***

## **Graph Theory**

### **Prim's Algorithm**
- shortest possible path

```
MST-PRIM(G, w, r)
    for each u in G.V
        u.key = inf
        u.pi = null
    r.key = 0
    Q = G.V
    while Q != 0
        u = EXTRACT-MIN(Q)
        for each v in G.Adj[u]
            if v in Q and w(u, v) < v.key
                v.pi = u
                v.key = w(u, v)
```