# ***Greedy Algorithmns***

## **Topics**

- ~~coin change~~
- ~~fractional knapsack problem and proof~~
- ~~activity selection and proof~~
- ~~bridge problem and proof~~
- ~~Resource Division~~

### **Coin Change**

Find optimal set of coins to fulful price A.

Prove Optimal Substructure
- Claim: Coin Change has an optimal substructure
  
- Let $C$ be the best optimal solution where $C = \{c_{1}, c_{2}, c_{3}, ..., c_{n}\}$ of size n
- Let $C' = C - c_{1}$ which means that $C' = \{c_{2}, c_{3}, ... , c_{n}\}$
  - This means that $C'$ must the optimal solution for $C - c_{1}$ of size n - 1
  
- Assume that $C'$ is not the optimal substructure for $C - c_{1}$
  - Then a better solution, $C''$, must exist and that the size of $C'' = i < n - 1$
  - Let $S = \{c_{1}\} \cup C''$
  - Then the cardinality of $|S| = i + 1 < 1 + n - 1 < n$
  - Contradiction because that would imply that $C$ is not the optimal choice

Prove Greedy Property
- Claim: Coin Change has a greedy property
- Assume: the largest coin is not in the solution
  - Cases: 
    - the largest coin is composed of smaller coins that are equal to the value of the larger coin
    - However, the multiple smaller coins can be replaced by a single larger coin that make an even better solution
    - Contradict because adding the largest coin makes an even better solution


### **Fractional Knapsack Problem and Proof**

Prove optimal substructure

Claim: Fractional knapsack problem has an optimal solution

Let $C = \{i_{1}, i_{2}, i_{3}, ..., i_{n}\}$ represent the optimal solution to the knapsack problem with the size $n$ where the weights of each item combined is within knapsack weight of $W$. Let $C' = \{i_{2}, i_{3}, ..., i_{n}\}$ represent $W - \{c_{1}\}$ of size n - 1. Let the function $V(C)$ compute the value of the entire solution.

Assume: $C'$ is not the optimal solution for $W - \{c_{1}\}$. 

Let $C''$ be a better substructure than $C'$. This means that $C''$ must have  $V(C'') > V(C')$ when $W - i_{1}$. Then the optimal solution $V(S) = V(i_{1}) + V{C''}$ which means that the $V(S) = V(i_{1}) + V(C'') > V(C)$. This a contradiction because then the optimal solution that was originally proposed is not the best solution.


Prove Greedy Property

Claim: The optimal solution to the fractional knapsack problem is that the item with the highest ratio is filled to the max in the knapsack.

Let $I = \{i_{1}, i_{2}, i_{3}, ..., i_{n}\}$ represent the list of items with a respective weight and value. Let $R = \{r_{1}, r_{2}, r_{3}, ..., r_{n}\}$ represent the ratio of each item sorted in increasing order such that $r_{j} = \frac{i_{j}.v}{i_{j}.w}$. Let $O = \{o_{1}, o_{2}, o_{3},..., o_{n}\}$ represent the number of each item that is in the optimal solution.

Assume that $i_{n}$ is not filled to the max in the optimal solution.

Let the function $min(W, i_{n}.w)$ represent the maximum number of item $i_{n}$ that could be filled in the optimal solution but since the optimal solution does not max the highest ratio item, then $o_{n} < min(W, i_{n}.w)$. Let $\delta = min(W, i_{n}.w) - o_{n} > 0$ such that it represent the free space left for not filling the highest ratio item to the max.

Then there must exist $r_{j}$ such that $r_{j} < r_{n}$ to fill up $\delta$.

Remove $o_{j}$ and swap it with $o_{n}$ to yield $V(O')$.

$V(O') = V(O) - \delta o_{j} + \delta o_{n}$

$V(O') = V(O) - \delta(o_{n} - o_{j})$

$V(O') > V(O)$ which contradicts  


### **Activity-Selection Problem**

- Greedy choice = activity with the earliest finish time

**Prove Optimal Substructure**

Let $S$ be the set of activities for the problem and let $O = \{o_{1}, o_{2}, o_{3}, ..., o_{n}\}$ denote the optimal solution of size $n$.

Let $O' = O - {o_{1}} = \{o_{2}, o_{3}, ..., o_{n}\}$ be of size $n - 1$. 

Assume that $O'$ is not the optimal solution for $O - {o_{1}}$ and that $O''$ is a better solution. This implies that the size of $O'' > n - 1$. Then the set $S = {o_{i}} + O''$. That implies that the size of $S > 1 + n - 1 > n$. This contradicts because O would not be the optimal solution. 

**Prove Greedy Choice Property**

Claim: The activity with the earliest time must be in some optimal solution O. 

Let $S$ be the set of activities given and let $O = \{o_{1}, o_{2}, ..., o_{n}\}$ 

Assume that $a_i$ is the activity with the earliest finish time and is not in the optimal solution. Let $o_1$ be the activity in $O$ that has the earliest finish time in $O$. This means that $f_1 \leq s_2$ and we know that $f_i \leq f_1$. Combining these inequalities result in $f_i \leq f_1 \leq s_2$. Then exchanging $f_i$ with $f_1$ is safe because it will still be mutually exclusive to all the other activities in the optimal solution and presents a similar or better optimal solution. Contradicts because we assumed that the activity with the earliest finish time is not in the optimal solution.  

### **Bridge Problem**

**Prove Optimal Substructure**

Claim: 