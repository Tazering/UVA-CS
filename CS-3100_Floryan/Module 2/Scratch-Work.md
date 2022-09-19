# ***Module 2: Scratch Work***

## **Wiring**
**Constraints**:
- only one breaker box
- exactly one switch between light and breaker box
- switch and light must correspond
- outlet must have path directly to breaker box with NO switches

```python

# objects
Node (String name, int numID, int switchID, String type, int key, boolean switchExists)

# global variables
int cost = 0
int switchID[] # list of switch id

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

            switch(v.type)
                case "Light":
                    if u.switchExists == False or (u.switchId != v.numID and v.numID is in switchID)
                        continue
                    
                    break

                case "Switch":
                    if(u.switchExists == True)
                        continue
                    else
                        u.switchId = v.numID
                        u.switchExists = True
                    break

                case "outlet":
                    if(u.switchExists == True)
                        continue
                    break

                case default:
                    break

        
            if v in Q and w(u, v) < v.key                
                v.pi = u
                v.key = w(u, v)
                v.switchExists = u.switchExists

```

## **Written Problems**