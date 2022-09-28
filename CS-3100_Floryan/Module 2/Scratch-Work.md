# ***Module 2: Scratch Work***

## **Wiring**
**Constraints**:
- only one breaker box
- exactly one switch between light and breaker box
- switch and light must correspond
- outlet must have path directly to breaker box with NO switches
- everything must be connected
- junction boxes and outlets will never be behind switches
    - only lights will be behind switches

```python

# objects
Node (int key, String name, String type)

# global variables
int cost = 0

hashmap[key: light number, value: switch number or -1] light_to_switch # hashmap to map light with switches (if -1; then no switch exists)

# Prim Approach
MST-PRIM(G, w)
    for each u in G.V
        u.key = inf
    r = breaker_node
    r.key = 0
    Q = G.V
    while Q != 0
        u = EXTRACT-MIN(q)
        count = count + u.key
        for each v in G.adj[u]
            if v in Q and w(u, v) < v.key and IS-CONNECTABLE(u, v)        
                v.key = w(u, v)


boolean IS-CONNECTABLE(u, v)
    
    return True

```

## **Written Problems**

1. If (u, v) = 1, then u cannot be the sink node; if (u, v) = 0, then v is not a sink node
2. DFS
3. contradiction
4. state space search