# Unique Paths

## Problem
Given a grid of size `m × n`, count the number of unique paths from the top-left corner to the bottom-right corner. You can only move **right** or **down** at any point.

This is a classic dynamic programming problem. The key insight is:
- To reach any cell `(i, j)`, you can come from either `(i-1, j)` (from above) or `(i, j-1)` (from the left)
- Therefore: `paths[i][j] = paths[i-1][j] + paths[i][j-1]`
- Base case: First row and first column all have 1 path (only one way to get there)

## Structure
- **Run Job (`run.xs`):** Defines a job that calls the solution function with test inputs
- **Function (`function/unique-paths.xs`):** Contains the solution logic using dynamic programming with space optimization

## Function Signature
- **Input:**
  - `rows` (int): Number of rows in the grid
  - `cols` (int): Number of columns in the grid
- **Output:**
  - (int): Number of unique paths from top-left to bottom-right

## Test Cases

| Grid Size | Expected Output | Explanation |
|-----------|-----------------|-------------|
| 2×2 | 2 | Right→Down or Down→Right |
| 3×3 | 6 | 6 unique paths in a 3×3 grid |
| 1×1 | 1 | Just the starting cell |
| 3×7 | 28 | Larger grid with more combinations |
| 0×5 | 0 | Edge case: invalid grid size |

## Algorithm
The solution uses dynamic programming with space optimization:
1. Instead of a 2D array, we use a 1D array `dp` where `dp[j]` holds the number of ways to reach the current row's j-th column
2. Initialize `dp` with all 1s (first row has exactly 1 path to each cell)
3. For each subsequent row, update `dp[j] = dp[j] + dp[j-1]`
4. The answer is `dp[cols-1]`

**Time Complexity:** O(m × n)  
**Space Complexity:** O(n) (optimized from O(m × n))

## Running the Job
```bash
# Run via Xano CLI (requires xano CLI setup)
xano run job unique-paths
```

Or invoke the function directly:
```bash
xano function run unique-paths --input '{"rows": 3, "cols": 3}'
```
