# Dijkstra Shortest Path

## Problem

Implement Dijkstra's algorithm to find the shortest path from a start node to all other nodes in a weighted graph.

Given a weighted graph represented as an adjacency list and a starting node, calculate the shortest distance from the start node to every other node in the graph. Also return the actual path taken to reach each node.

### Graph Representation
The graph is represented as a JSON object where:
- Keys are node names (strings)
- Values are arrays of edge objects, each containing:
  - `to`: the destination node name
  - `weight`: the edge weight (positive number)

### Dijkstra's Algorithm
1. Initialize all distances to infinity (null) except the start node (0)
2. Maintain a set of visited nodes
3. Repeatedly select the unvisited node with the smallest known distance
4. For the selected node, update distances to its neighbors if a shorter path is found
5. Mark the node as visited and repeat until all nodes are visited

## Structure

- **Run Job (`run.xs`):** Calls the dijkstra function with a test graph containing 6 nodes (A-F)
- **Function (`function/dijkstra.xs`):** Implements Dijkstra's algorithm to find shortest paths

## Function Signature

- **Input:**
  - `graph` (json): Adjacency list representation of the weighted graph
  - `start_node` (text): The node to start from

- **Output:** (json)
  - Object with node names as keys
  - Each value contains:
    - `distance`: The shortest distance from start_node (null if unreachable)
    - `path`: Array of nodes representing the shortest path from start_node

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| Graph with A-F, start "A" | A: distance 0, path ["A"]; B: distance 4, path ["A","B"]; etc. |
| Graph with A-F, start "D" | All distances/paths recalculated from D |
| Empty graph `{}` | Empty result `{}` |
| Single node `{"X":[]}`, start "X" | X: distance 0, path ["X"] |

### Test Graph Visual

```
    A --4--> B --2--> C
    |        |        |
    1        3        1
    v        v        v
    D --2--> E --3--> F
```

### Expected Results from Node A

| Node | Distance | Path |
|------|----------|------|
| A | 0 | [A] |
| B | 4 | [A, B] |
| C | 6 | [A, B, C] |
| D | 1 | [A, D] |
| E | 3 | [A, D, E] |
| F | 6 | [A, D, E, F] or [A, B, C, F] |

## Notes

- The algorithm handles unreachable nodes (distance remains null)
- Time complexity: O(V²) where V is the number of vertices
- Space complexity: O(V) for storing distances and visited set
