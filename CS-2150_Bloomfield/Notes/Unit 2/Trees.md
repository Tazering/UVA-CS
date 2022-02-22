# ***Trees***

## **Data Structures**

### **List Limitations**
- Access Time: $\Theta$(n)
- slower to access and find
- has a predecessor and successor

### **Tree**

- one predecessor (parent) and two successor (children: left or right)
- vertical
- **root**: node with no parent
    - only one root
- **leaf**: node with no children
- **siblings**: two nodes with the same parent
- **height**: length of the *longest* path from that node to a leaf
- **depth**: length of path from node to root
- **path**: sequence of nodes that need to be traversed
- **length**: # of edges
- **internal**: sum of the depths

Infinite Number of children
```c
class TreeNode {
    private:

}
```

### Traversal
**Pre-Order**: root - left - right

**In-order**: Left - root - Right
**Post-order**: left - right - root

## **Binary Search Trees**

- nodes have at most 2 children
- left and right child pointers
    - not existing children => null pointers
- greater => right tree; less => left tree
- assume no duplicates

*Difference between binary tree and binary search tree is the order*

- find
    - start at root
    - traverse through tree
        - greater => right; lesser => left
    - not exist => failure

- worst case: $\Theta$(n) because it could have no balance
- 







