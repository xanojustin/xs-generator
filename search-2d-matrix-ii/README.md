# Search a 2D Matrix II

## Problem

Write an efficient algorithm that searches for a `target` value in an `m x n` integer matrix. The matrix has the following properties:

- Integers in each row are sorted in ascending order from left to right.
- Integers in each column are sorted in ascending order from top to bottom.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/search_2d_matrix_ii.xs`):** Contains the solution logic

## Function Signature

- **Input:**
  - `matrix`: `int[][]` - A 2D matrix where rows and columns are sorted in ascending order
  - `target`: `int` - The value to search for
- **Output:**
  - `bool` - `true` if target is found in the matrix, `false` otherwise

## Algorithm

The solution uses a clever search strategy starting from the **top-right corner** of the matrix:

1. Start at position (0, last column) - top-right corner
2. Compare current element with target:
   - If equal: target found, return `true`
   - If current > target: move left (current column is too large, eliminate it)
   - If current < target: move down (current row is too small, eliminate it)
3. Repeat until target is found or bounds are exceeded

**Why this works:**
- From top-right, moving left always gives smaller values
- Moving down always gives larger values
- Each step eliminates either an entire row or an entire column

## Complexity

- **Time Complexity:** O(m + n) where m = rows, n = columns
- **Space Complexity:** O(1) - only using a few variables

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `matrix = [[1,4,7,11,15],[2,5,8,12,19],[3,6,9,16,22],[10,13,14,17,24],[18,21,23,26,30]], target = 5` | `true` |
| `matrix = [[1,4,7,11,15],[2,5,8,12,19],[3,6,9,16,22],[10,13,14,17,24],[18,21,23,26,30]], target = 20` | `false` |
| `matrix = [], target = 1` | `false` (empty matrix) |
| `matrix = [[]], target = 1` | `false` (empty rows) |
| `matrix = [[1]], target = 1` | `true` (single element, found) |
| `matrix = [[1]], target = 2` | `false` (single element, not found) |
| `matrix = [[1,2,3],[4,5,6],[7,8,9]], target = 9` | `true` (target at bottom-right) |
| `matrix = [[1,2,3],[4,5,6],[7,8,9]], target = 1` | `true` (target at top-left) |

## Example Walkthrough

For matrix:
```
[1,  4,  7,  11, 15]
[2,  5,  8,  12, 19]
[3,  6,  9,  16, 22]
[10, 13, 14, 17, 24]
[18, 21, 23, 26, 30]
```

Searching for `5`:
1. Start at (0,4) = 15. 15 > 5, so move left to column 3
2. At (0,3) = 11. 11 > 5, so move left to column 2
3. At (0,2) = 7. 7 > 5, so move left to column 1
4. At (0,1) = 4. 4 < 5, so move down to row 1
5. At (1,1) = 5. 5 == 5, target found! Return `true`
