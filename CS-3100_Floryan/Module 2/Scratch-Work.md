# ***Module 2: Scratch Work***

## **Wiring**
**Constraints**:
- only one breaker box
- exactly one switch between light and breaker box
- outlet must have path directly to breaker box with NO switches

```python
# Kruskal Approach


# Prim Approach
MST-PRIM(G, w)
    for each u in G.V
        u.key = inf
        u.pi = null
    r = breaker_node
    r.key = 0
    Q = G.V
    while Q != 0
        u = EXTRACT-MIN(q)
        for each v in G.adj[u]
            if v in Q and w(u, v) < v.key                
                v.pi = u
                v.key = w(u, v)

```

## **Written Problems**