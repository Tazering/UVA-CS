# ***Module 2: Scratch Work***

## **Wiring**
**Constraints**:
- only one breaker box
- exactly one switch between light and breaker box
- outlet must have path directly to breaker box with NO switches

```python

# objects
Node (String name, String type, int key, boolean switchExists)

# global variables
int cost = 0;

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
        count = count + u.key
        for each v in G.adj[u]
            # check if node can connect to light
            if(v.type == "Light" and u.switchExists == False)
                continue

            # to ensure there is EXACTLY one switch between lights
            if(v.type == "Switch")
                if(u.switchExists == True)
                    continue
                else
                    u.switchExists = True
            
            # check if target node is outlet
            if(v.type == "outlet")
                if(u.switchExists == True)
                    continue

            if v in Q and w(u, v) < v.key                
                v.pi = u
                v.key = w(u, v)
                v.switchExists = u.switchExists

```

## **Written Problems**