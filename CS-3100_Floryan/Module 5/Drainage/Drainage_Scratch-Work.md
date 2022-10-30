# ***Drainage Scratch Work***

Goal: *longest* sequence of grid locations that water can flow between
- water will flow from higher to lower
- water will never flow from congruent heights
- *adjacent* means left, right, above, or below

Strategy: 
- go in the direction with the least amount of change (not going to work)
- Optimal Substructure
- Observations
  - probably want whole graph to be the last thing
    - How to break up into subproblems?
  - examples seem to have the largest value in the array
- Ideas
  - Idea 1
    - start with highest value
    - expand larger square from highest value 
  - Idea 2 (NOT VIABLE)
    - start with lowest value
    - expand larger square from lowest value
  - Idea 3
    - find highest number of connections in each row
    - increment number of rows available
    - somehow, store see possible connections between nodes




