# Graph Bipartite

## Problem

Determine if an undirected graph is **bipartite**.

A graph is bipartite if we can split its set of nodes into two independent subsets A and B such that every edge connects a node in A to a node in B.

Equivalently, a graph is bipartite if and only if it is 2-colorable: we can assign one of two colors to each node such that no two adjacent nodes have the same color.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/is_bipartite.xs`):** Contains the BFS two-coloring solution logic

## Function Signature

- **Input:**
  - `graph` (object[][]) - Adjacency list representation where `graph[i]` contains the list of neighbor nodes for node `i`
  
- **Output:**
  - `bool` - Returns `true` if the graph is bipartite, `false` otherwise

## Algorithm

The solution uses **BFS two-coloring**:
1. Initialize a colors array with -1 (uncolored) for all nodes
2. For each uncolored node, start a BFS and color it with color 0
3. For each neighbor:
   - If uncolored, assign the opposite color (1 - current)
   - If colored and has the same color as current, the graph is not bipartite
4. If we process all nodes without conflict, the graph is bipartite

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[[1,3],[0,2],[1,3],[0,2]]` | `true` | Even cycle - bipartite (nodes 0,2 in set A; 1,3 in set B) |
| `[[1,2,3],[0,2],[0,1,3],[0,2]]` | `false` | Odd cycle - not bipartite |
| `[[],[]]` | `true` | Empty graph with isolated nodes - bipartite |
| `[[1],[0]]` | `true` | Single edge - bipartite |
| `[[1,2],[0],[0]]` | `true` | Star graph - bipartite |

## Complexity

- **Time Complexity:** O(V + E) where V is the number of vertices and E is the number of edges
- **Space Complexity:** O(V) for the colors array and BFS queue
