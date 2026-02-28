# Diagonal Traverse

## Problem
Given an `m x n` matrix, return all elements of the matrix in diagonal order.

The traversal follows a zigzag pattern:
- Start at top-left (0, 0)
- Move diagonally up-right (going up)
- When hitting a boundary, change direction to down-left (going down)
- Continue alternating directions until all elements are visited

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/diagonal_traverse.xs`):** Contains the solution logic

## Function Signature
- **Input:** 
  - `matrix` (int[][]): A 2D array of integers representing the matrix
- **Output:** 
  - `int[]`: An array containing all matrix elements in diagonal traversal order

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[[1, 2, 3], [4, 5, 6], [7, 8, 9]]` | `[1, 2, 4, 7, 5, 3, 6, 8, 9]` |
| `[[1, 2], [3, 4]]` | `[1, 2, 3, 4]` |
| `[]` | `[]` |
| `[[1]]` | `[1]` |
| `[[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12]]` | `[1, 2, 5, 9, 6, 3, 4, 7, 10, 11, 8, 12]` |

### Explanation of Traversal Pattern

For matrix `[[1, 2, 3], [4, 5, 6], [7, 8, 9]]`:

```
Diagonal 0: 1 (going up)
Diagonal 1: 2 → 4 (going down)
Diagonal 2: 7 → 5 → 3 (going up)
Diagonal 3: 6 → 8 (going down)
Diagonal 4: 9 (going up)

Result: [1, 2, 4, 7, 5, 3, 6, 8, 9]
```
