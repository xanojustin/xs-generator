# Longest Increasing Path in a Matrix

## Problem

Given an `m x n` integers matrix, return the length of the longest increasing path in the matrix.

From each cell, you can move in four directions: left, right, up, or down. You may only move to a cell with a strictly greater value. The path cannot go outside the matrix boundary.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/longest_increasing_path.xs`):** Contains the DFS with memoization solution logic

## Function Signature

- **Input:**
  - `matrix` (json): A 2D array of integers representing the matrix
- **Output:**
  - (int): The length of the longest increasing path

## Algorithm

This solution uses Depth-First Search (DFS) with memoization:

1. For each cell in the matrix, perform DFS to find the longest increasing path starting from that cell
2. Use a memoization table to cache results and avoid recomputation
3. From each cell, explore all 4 directions (up, down, left, right)
4. Only move to cells with strictly greater values
5. Return the maximum path length found

**Time Complexity:** O(m × n) where m is the number of rows and n is the number of columns  
**Space Complexity:** O(m × n) for the memoization table and recursion stack

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[[9,9,4],[6,6,8],[2,1,1]]` | 4 |
| `[[3,4,5],[3,2,6],[2,2,1]]` | 4 |
| `[[1]]` | 1 |
| `[]` | 0 |

### Test Case Explanations

1. **Basic case:** Path `1 → 2 → 6 → 9` gives length 4
2. **Multiple paths:** Path `3 → 4 → 5 → 6` or `1 → 2 → 6 → ?` - longest is 4
3. **Single cell:** Only one cell, path length is 1
4. **Empty matrix:** No cells, path length is 0

## Example

```xs
// Example matrix
[
  [9, 9, 4],
  [6, 6, 8],
  [2, 1, 1]
]

// The longest increasing path is: 1 → 2 → 6 → 9
// Starting at position [2,1] → [2,0] → [1,0] → [0,0]
// Path length: 4
```
