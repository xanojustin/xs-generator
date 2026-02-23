# Maximal Square

## Problem
Given a binary matrix filled with `0`s and `1`s, find the largest square containing only `1`s and return its **area**.

The matrix represents a grid where each cell contains either a 0 or 1. A square is valid only if all cells within it contain 1s. Return the area (side length × side length) of the largest such square.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/maximal_square.xs`):** Contains the dynamic programming solution

## Function Signature
- **Input:**
  - `matrix` (json): A 2D array representing the binary matrix (array of arrays containing 0s and 1s)
- **Output:**
  - `int`: The area of the largest square containing only 1s

## Algorithm
This solution uses **dynamic programming**:

1. Create a DP table where `dp[i][j]` represents the side length of the largest square of 1s ending at position `(i, j)`
2. For each cell:
   - If it's in the first row or column, `dp[i][j]` equals the cell value (can only form 1×1 squares)
   - If the cell is 0, `dp[i][j]` = 0
   - If the cell is 1, `dp[i][j]` = `min(dp[i-1][j], dp[i-1][j-1], dp[i][j-1]) + 1`
3. Track the maximum side length found
4. Return `max_side²` (the area)

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[[1,0,1,0,0],[1,0,1,1,1],[1,1,1,1,1],[1,0,0,1,0]]` | 4 | Largest square is 2×2 in the middle (area = 4) |
| `[[0,1],[1,0]]` | 1 | Two separate 1×1 squares, max area = 1 |
| `[]` | 0 | Empty matrix returns 0 |
| `[[0,0,0],[0,0,0],[0,0,0]]` | 0 | Matrix with all zeros returns 0 |
| `[[1,1,1,1],[1,1,1,1],[1,1,1,1],[1,1,1,1]]` | 16 | Entire 4×4 matrix is a square, area = 16 |
| `[[1]]` | 1 | Single cell with 1 returns 1 |
| `[[0]]` | 0 | Single cell with 0 returns 0 |

## Time & Space Complexity
- **Time Complexity:** O(m × n) where m is the number of rows and n is the number of columns
- **Space Complexity:** O(m × n) for the DP table
