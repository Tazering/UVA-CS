# ***Module 1: Study Guide***

## **Facts**
- All trees are graphs (True)
- All linked-lists are graphs (True)
- All graphs are trees (False)
- A directed graph (without loops) always satisfies $|E| \leq \frac{|V|^2}{2}$ (False) because the most number of edges you can have is $V^2 - V$ which is larger than $\frac{|V|^2}{2}$
- For any graph, it is always the case that $|E| \in O(|V|^2)$ (True)
- A *directed graph* cannot have cycles, which makes them convenient to use (False) because directed graphs can have cycles
- When BFS exeuctes, it is possible that a node is put on the queue a second time, but it can never happen a third time (False) because the color will change automatically 
- For BFS, the queue can contain nodes with two unique distances but NOT three unique distances (True)