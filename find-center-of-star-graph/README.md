# Find Center of Star Graph

## Problem
There is an undirected star graph consisting of `n` nodes labeled from `1` to `n`. A star graph is a graph where there is one center node and exactly `n - 1` edges that connect the center node with every other node.

You are given a 2D integer array `edges` where each `edges[i] = [u_i, v_i]` indicates that there is an edge between the nodes `u_i` and `v_i`. Return the center of the given star graph.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/find_center.xs`):** Contains the solution logic

## Function Signature
- **Input:** `int[][] edges` - An array of edges where each edge is a pair of connected nodes
- **Output:** `int` - The center node of the star graph

## Approach
In a star graph:
- There is exactly one center node
- The center node is connected to all other nodes
- Therefore, the center node appears in every single edge

**Key Insight:** The center node must be one of the two nodes in the first edge. We just need to determine which one by checking if it also appears in the second edge.

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[[1, 2], [2, 3], [4, 2]]` | `2` | Node 2 appears in all edges (center) |
| `[[1, 2], [5, 1], [1, 3], [1, 4]]` | `1` | Node 1 appears in all edges (center) |
| `[[2, 3], [3, 1], [3, 4]]` | `3` | Node 3 appears in all edges (center - minimum case) |

### Edge Cases
- **Minimum star graph:** A star graph with only 2 nodes (1 edge)
- **Large star graph:** Many edges all connected to one center node

## Complexity
- **Time Complexity:** O(1) - We only examine the first two edges
- **Space Complexity:** O(1) - Only using a few variables
