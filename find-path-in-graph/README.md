# Find Path in Graph

## Problem

There is a bi-directional graph with `n` vertices, where each vertex is labeled from `0` to `n - 1`. The edges in the graph are represented as a 2D integer array `edges`, where each `edges[i] = [ui, vi]` denotes a bi-directional edge between vertex `ui` and vertex `vi`. Every vertex pair is connected by at most one edge, and no vertex has an edge to itself.

Determine if there is a valid path from the `source` vertex to the `destination` vertex.

Return `true` if such a path exists, and `false` otherwise.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/find_path.xs`):** Contains the solution logic using BFS traversal

## Function Signature

- **Input:**
  - `n` (int): Number of vertices in the graph (labeled 0 to n-1)
  - `edges` (object[]): Array of edges where each edge is `{source: int, target: int}`
  - `source` (int): Starting vertex
  - `destination` (int): Target vertex
- **Output:** (bool) `true` if a path exists from source to destination, `false` otherwise

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| n=3, edges=[[0,1],[1,2],[2,0]], source=0, destination=2 | true |
| n=6, edges=[[0,1],[0,2],[3,5],[5,4],[4,3]], source=0, destination=5 | false |
| n=1, edges=[], source=0, destination=0 | true |
| n=5, edges=[[0,1],[1,2],[2,3],[3,4]], source=0, destination=4 | true |
| n=4, edges=[[0,1],[2,3]], source=0, destination=3 | false |

### Test Case Explanations:
- **Case 1:** Basic triangle graph with direct path 0 → 1 → 2
- **Case 2:** Two disconnected components - source and destination in different components
- **Case 3:** Edge case - single vertex where source equals destination
- **Case 4:** Linear path through all vertices
- **Case 5:** Disconnected graph - no path exists between components
