# 

## **Multi-Agent Path Finding MAPF**
- Goal: 
  - find collision-free paths for all agents
  - minimize sum of path costs

**Assumptions**


**Searching tje Joint-State Space**
- A* guarantees optimal solution but not scalable
- CBS
  - Conflict-based Search => if there is collision
    - creates branches and attempts to resolve the collision
  - scales better than A*
  - makes copies and tries paths

**Collision Symmetries**

**Symmetry-Breaking Constraints**
- add set of constraints to each CBS node
- resolve symmetry in single branching step
- preserve completeness and optimality

MDD => compact data structure that stores every feaible path under the given cost of an agent
initial mutex => corresponds to vertex and edge collisions
propagated mutex => states that cannot be reached through propagation
mark nodes that have conflicts and in same level

More optimal and stable

When there are more than 2 agents
- add admissible heurisitics
  - edge-weighted dependency graph
  - edge-weighted minimum vertex cover
- MAPF-LNS => most scalable

Extremely Scalable MAPF
- rule-based or lerarning-based one-step planner

MAPF for Complex Teams
- can be spread to domains with more complex robot models

- Using envelops
  - envelops represent where robots can be
  - can be applied to any robot

Adding Interface between MAPF and Control
- keep order in which agents visit each vertex (cell)
- make a Temporal Plan Graph (TPG)
  - map nodes that match
  - determines ordering agent movements
- Better idea: keep order in which agents visit each critical vertex (cell)

Open-Source MAPF Simulator
- on github
- letter planner output path
- build physics-based robotic simulator
- scalable

Waymo datasets
interaction
UC
R-Rover

JRBD
ScanD
ETX/ucy

ScanD
GRDB

Waymo

Social Compliance paper => look for datasets
Building such dataset for deadlocks => open research problem
Create such scenarios
