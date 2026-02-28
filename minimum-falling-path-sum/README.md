# Minimum Falling Path Sum

## Problem

Given an `n x n` integer matrix, return the **minimum sum** of any falling path through the matrix.

A **falling path** starts at any element in the first row and chooses the element in the next row that is either:
- Directly below
- Diagonally left (one column to the left)
- Diagonally right (one column to the right)

Specifically, the next element from position `(row, col)` will be one of:
- `(row + 1, col - 1)`
- `(row + 1, col)`
- `(row + 1, col + 1)`

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/minimum_falling_path_sum.xs`):** Contains the dynamic programming solution logic

## Function Signature

- **Input:**
  - `matrix` (json): An n x n 2D array of integers representing the matrix
- **Output:**
  - `int`: The minimum sum of any falling path through the matrix

## Algorithm

This solution uses **dynamic programming** with O(n²) time and O(n) space:

1. **DP State:** `dp[col]` represents the minimum falling path sum ending at the current row's `col` column
2. **Transition:** For each cell, consider the minimum path from:
   - Diagonally left (if valid)
   - Directly above
   - Diagonally right (if valid)
3. **Result:** The minimum value in the last row's DP array

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[[2,1,3],[6,5,4],[7,8,9]]` | `13` | Path: 1 → 4 → 8 (sum = 13) |
| `[[-19,57],[-40,-5]]` | `-59` | Path: -19 → -40 (sum = -59) |
| `[[1]]` | `1` | Single element matrix |
| `[]` | `0` | Empty matrix edge case |
| `[[100,-42,-23,-50],[52,19,100,-47],[-47,37,-44,100],[-2,100,-34,100]]` | `-91` | Complex case with negatives |

### Detailed Walkthrough for Example 1

```
Matrix:          DP after row 0:    DP after row 1:    DP after row 2:
[2, 1, 3]        [2, 1, 3]          [7, 6, 7]          [13, 13, 15]
[6, 5, 4]        
[7, 8, 9]

Minimum of [13, 13, 15] = 13
Path: 1 (row 0, col 1) → 4 (row 1, col 2) → 8 (row 2, col 1) = 13
```

Note: The actual path shown is different from the trace - the algorithm finds the minimum sum, not the actual path.

## Complexity Analysis

- **Time Complexity:** O(n²) where n is the dimension of the matrix
  - We process each of the n² cells exactly once
- **Space Complexity:** O(n)
  - We only store two rows of DP values at a time (current and previous)
  - The implementation uses O(n) instead of O(n²) by only keeping the previous row

## LeetCode Reference

This is a classic dynamic programming problem similar to:
- [LeetCode 931: Minimum Falling Path Sum](https://leetcode.com/problems/minimum-falling-path-sum/)
