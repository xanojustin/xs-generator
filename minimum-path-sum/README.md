# Minimum Path Sum

## Problem

Given a `m x n` grid filled with non-negative numbers, find a path from the top-left corner to the bottom-right corner that minimizes the sum of all numbers along its path.

**Constraints:**
- You can only move either down or right at any point in time
- The grid contains non-negative integers

This is a classic dynamic programming problem. The key insight is that the minimum path to any cell is the cell's value plus the minimum of the path from above or from the left.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/minimum_path_sum.xs`):** Contains the dynamic programming solution

## Function Signature

- **Input:** 
  - `grid` (json): A 2D array of non-negative integers representing the grid
  - Example: `[[1, 3, 1], [1, 5, 1], [4, 2, 1]]`
  
- **Output:** 
  - (int): The minimum path sum from top-left to bottom-right
  - Example: `7` (path: 1→3→1→1→1)

## Algorithm

The solution uses dynamic programming with the recurrence relation:
```
dp[i][j] = grid[i][j] + min(dp[i-1][j], dp[i][j-1])
```

Where:
- `dp[0][0] = grid[0][0]` (starting point)
- First row: can only come from the left
- First column: can only come from above
- Other cells: minimum of coming from above or from the left

## Test Cases

| Input Grid | Expected Output | Explanation |
|------------|-----------------|-------------|
| `[[1, 3, 1], [1, 5, 1], [4, 2, 1]]` | `7` | Path: 1→3→1→1→1 = 7 |
| `[[1, 2, 3], [4, 5, 6]]` | `12` | Path: 1→2→3→6 = 12 |
| `[[5]]` | `5` | Single cell - just return its value |
| `[[1, 2], [1, 1]]` | `3` | Path: 1→1→1 = 3 (better than 1→2→1 = 4) |
| `[]` | `0` | Empty grid returns 0 |

## Complexity Analysis

- **Time Complexity:** O(m × n) where m is the number of rows and n is the number of columns
- **Space Complexity:** O(m × n) for the DP table (can be optimized to O(n) with rolling array)
