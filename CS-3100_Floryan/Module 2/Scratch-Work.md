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

hashmap[key: light number, value: switch number or -1] light_to_switch # hashmap to map light with switches (if -1; then no switch exists)

# Kruskal Approach


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

            switch(v.type)
                case "Light":
                    if u.switchExists == False
                        continue

                    else if light_to_switch[v.numID] != -1

                        if light_to_switch[v.numID] != u.switchID

                            continue
                    
                    
                    break

                case "Switch":
                    if(u.switchExists == True)
                        continue
                    else
                        v.switchExists = True
                    break

                case "outlet":
                    if(u.switchExists == True)
                        continue
                    break

                case default:
                    break

        
            if v in Q and w(u, v) < v.key                
                v.key = w(u, v)

```

## **Written Problems**