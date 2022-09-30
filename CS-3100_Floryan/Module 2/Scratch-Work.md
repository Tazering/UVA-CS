# ***Module 2: Scratch Work***

## **Wiring**
**Constraints**:
- ~~only one breaker box~~
- exactly one switch between light and breaker box
- switch and light must correspond
- outlet must have path directly to breaker box with NO switches
- everything must be connected
- junction boxes and outlets will never be behind switches
    - only lights will be behind switches

```python

# objects
Node (int numId, String name, String type, int switchID, String predecessor, boolean isChecked)

# global variables
int cost = 0

hashmap[key: light number, value: switch number] light_to_switch # hashmap to map light with switches (if -1; then no switch exists)
hashmap[key: node, value: numId] node_to_id

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
    uType = u.type
    vType = v.type
    
    # conditionals
    if IS-PRESWITCH(u) and IS-PRESWITCH(v)
        return True

    if IS-PRESWITCH(u) and IS-SWITCH(v)
        u.switchId = v.numID
        return True


    if IS-POSTSWITCH(u) and IS-POSTSWITCH(v)
        if light_to_switch[u] != light_to_switch[v]
            return False

    if IS-SWITCH(u) and IS-SWITCH(v)
        return False


    return True

boolean IS-PRESWITCH(u)
    return u.type == "breaker" or "outlet" or "junction"

boolean IS-SWITCH(u)
    return u.type == "switch"

boolean POST-SWITCH(u)
    return u.type == "light"

```

## **Written Problems**

1. If (u, v) = 1, then u cannot be the sink node; if (u, v) = 0, then v is not a sink node
2. DFS
3. contradiction
4. state space search