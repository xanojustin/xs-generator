# Union-Find (Disjoint Set Union)

## Problem
Implement the **Union-Find** (also known as Disjoint Set Union - DSU) data structure with the following optimizations:
- **Path Compression**: During find operations, flatten the structure so that all nodes point directly to the root
- **Union by Rank**: When merging two sets, attach the smaller tree under the larger tree to keep the structure balanced

The data structure should support three operations:
1. **find(x)**: Returns the representative (root) of the set containing element x
2. **union(x, y)**: Merges the sets containing elements x and y
3. **connected(x, y)**: Returns true if x and y are in the same set, false otherwise

## Structure
- **Run Job (`run.xs`):** Calls the Union-Find function with test operations
- **Function (`function/union_find.xs`):** Implements the Union-Find data structure with path compression and union by rank

## Function Signature
- **Input:**
  - `n` (int): Number of elements in the universe (elements are numbered 0 to n-1)
  - `operations` (object[]): Array of operations to perform, where each operation has:
    - `type` (text): Operation type - "find", "union", or "connected"
    - `params` (int[]): Operation parameters:
      - For "find": [x] - element to find
      - For "union": [x, y] - elements to union
      - For "connected": [x, y] - elements to check connectivity

- **Output:**
  - `operations` (object[]): Results of each operation
  - `final_state` (object): Final parent and rank arrays for verification

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| n=5, union(0,1), connected(0,1) | connected returns true |
| n=5, union(0,1), union(2,3), connected(0,2) | connected returns false (different sets) |
| n=5, union(0,1), union(1,2), find(0) | find returns root of set {0,1,2} |
| n=1, find(0) | find returns 0 (single element is its own root) |
| n=10, union(0,1), union(1,2), union(2,3), union(3,4) | All elements 0-4 in same set; verify path compression |
| n=6, union(0,1), union(0,2), union(0,3), connected(1,3) | connected returns true (all in same set) |
| n=4, union(0,1), union(0,1) (duplicate union), connected(0,1) | connected returns true, no error on duplicate union |

## Complexity Analysis

With both optimizations (path compression + union by rank):
- **Time Complexity:** O(α(n)) per operation, where α is the inverse Ackermann function
  - α(n) < 5 for all practical values of n, so it's effectively constant time
- **Space Complexity:** O(n) for storing parent and rank arrays

## Applications
- Kruskal's algorithm for Minimum Spanning Tree
- Detecting cycles in undirected graphs
- Connected components in graphs
- Percolation problems
- Equivalence relations
- Image processing (connected component labeling)