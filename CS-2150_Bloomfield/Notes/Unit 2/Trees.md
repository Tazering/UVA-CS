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
    - NULL indicates not found

- worst case: $\Theta$(n) because it could have no balance

- Insert
    - do a find to find the particular spot to insert
    - if you end up finding the element => do nothing
    - pass in a pointer reference to modify previous reference

- findMax()
    - anything in the right subtree will be the greatest value
- findfMin()
    - go down in the left subtree

- remove()
    - three cases
        - no children
        - one child
        - two children
    - no children
        - just simply remove it
    - one children
        - if it is a left child => just put the grandparent point to the single child
        - vice versa
    - two children
        - next highest value and use it as the replacement
        - minimum value => cannot have a left child
        - find next highest value
            - find min in right subtree
        - delete next highest value
        - set target node as the value

- height()
    - maximum number nodes in a binary tree of height h is 2<sup>(h+1)</sup> -1 
        - prove by induction
    - n <= 2<sup>h+1</sup> - 1
    - shortest tree for n nodes is log<sub>2</sub>(n+1)-1

- perfect binary tree
    - cannot have an arbritary number of nodes
    - but be balanced
    - use a comparison

## **Expression Trees**
- hold value or operator
- infix notation => in-order traversal

```c
//with paranethesis
Algorithm infix (tree)

if(tree not empty)
    if(tree token is operator)
        print (open parenthesis)
    end if
    infix (tree left subtree)
    print (tree token)
    infix (tree right subtree)
    if (tree token is operator)
        print (close parenthesis)
    end if
end if

end infix
```

- postfix notation => post-order traversal
- prefix notation => pre-order traversal

### **Building an Expression Tree**

- use a stack
    - number => push into stack
    - operator => make into parent
    - make tree and push back into a stack
- store the memory of each tree

## **AVL Trees**

- **Motivation**: guarantee $\Theta$(log(n))

- property: for every node, they differ at least one from the left and right subtrees
- balance factor
    - difference in height between the left and right subtree
    - right - left => difference
    - 0 means balanced
    - 1 means right subtree is one longer than the left
    - -1 means the left is one longer the right
- "unbalanced" tree
    - when there is -2 or 2
- balance tree everytime operation happens

### **Find and Insert**
- find: same as BST find
- insert: same as BST insert except may need to fix
    - do normal insert
    - go up to root to look for any unbalances
    - if unbalance is found for purely right or purely left
        - find the first node that is unbalanced
        - simply move higher number up and rearrange value (basically rotating left if adding to right subtree and rotate right if adding to left subtree) 
        - can use iterator or recursion to get parent node
        - at least one node moves up a level and another node goes down a level
    - if unbalance is found for mix of left and right
        - double rotation
        - left -> right => left rotation then right rotation
        - right -> left => right rotation and then left rotation
            - one on child and then one on parent
- x => deepest node where imbalance occurs
- four cases
    1. left subtree of left child of x
    2. right subtree of the left child of x
    3. left subtree of the right child of x
    4. right subtree of the right child of x
- case 1 & 2 => single rotation
- case 3 & 4 => double rotation
- look at deeper node and see if its negative or positive

### **Runtime**
- find: $\Theta$(log*n*)
- insert: $\Theta$(log*n*)
- remove: $\Theta$(log*n*)
- print: $\Theta$(*n*)

## **Recursion**
- requirements
    - way to make the problem simpler
    - way to detect when to stop
    - way to stop
- Pros
    - more natural way of thinking of the problem
    - some problems work well with recursions
- Cons
    - slows performance

## **Tail Recursion**
```c
unsigned int sum(unsigned int n, unsigned int s) {
    if(n == 0) {
        return s;
    } else {
        return sum(n-1, n+s)
    }
}
```

- have another value that sums value already in the parameter
- compiler will automatically make it into a for loop
- 

## **Red-Black Trees**
- basically a binary search tree except a node is either red or black
- root is always black
- leaves are black
- children of red nodes are black

### **Insert**
Cases:
    1. new node is the root 
        - must be black
    2. new node's parent is black
    3. parent and uncle are red
    4. parent is red, uncle is black, and n is right child of p
    5. parent is red, uncle is black, new node is left child of parent

### **Removal**
Cases:
    1. 


