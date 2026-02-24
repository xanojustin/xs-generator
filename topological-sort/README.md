# Topological Sort

## Problem
Given a directed acyclic graph (DAG) with `num_nodes` nodes (labeled 0 to num_nodes-1) and a list of directed edges, return a valid **topological ordering** of the nodes.

A topological sort is a linear ordering of vertices such that for every directed edge `[u, v]`, vertex `u` comes before `v` in the ordering.

If the graph contains a cycle (making a topological sort impossible), return an empty array `[]`.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/topological_sort.xs`):** Contains the solution logic using Kahn's algorithm

## Function Signature
- **Input:**
  - `num_nodes` (int): Total number of nodes in the graph (0 to num_nodes-1)
  - `edges` (object[]): Array of `[from, to]` pairs representing directed edges
- **Output:**
  - `int[]`: A valid topological ordering, or empty array if cycle exists

## Algorithm
This implementation uses **Kahn's Algorithm**:
1. Build an adjacency list representation of the graph
2. Calculate in-degree (number of incoming edges) for each node
3. Initialize a queue with all nodes having in-degree 0
4. Process nodes from the queue:
   - Add node to result
   - Decrease in-degree of its neighbors
   - If neighbor's in-degree becomes 0, add to queue
5. If result contains all nodes, return it; otherwise return empty array (cycle detected)

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `num_nodes: 6, edges: [[5,2],[5,0],[4,0],[4,1],[2,3],[3,1]]` | `[5, 4, 2, 0, 3, 1]` or any valid ordering |
| `num_nodes: 4, edges: [[1,0],[2,0],[3,1],[3,2]]` | `[3, 1, 2, 0]` or `[3, 2, 1, 0]` |
| `num_nodes: 2, edges: [[0,1]]` | `[0, 1]` |
| `num_nodes: 0, edges: []` | `[]` |
| `num_nodes: 3, edges: [[0,1],[1,2],[2,0]]` | `[]` (cycle detected) |

## Complexity
- **Time Complexity:** O(V + E) where V is vertices and E is edges
- **Space Complexity:** O(V + E) for the adjacency list and in-degree array

## Example Usage
```xs
// In a run job or another function
function.run {
  name = "topological_sort"
  input = {
    num_nodes: 6
    edges: [[5, 2], [5, 0], [4, 0], [4, 1], [2, 3], [3, 1]]
  }
} as $result
```
