# Spiral Matrix II

## Problem
Given a positive integer `n`, generate an `n x n` matrix filled with elements from 1 to n² in spiral order (clockwise), starting from the top-left corner.

The spiral order proceeds as follows:
1. Fill the top row from left to right
2. Fill the right column from top to bottom
3. Fill the bottom row from right to left
4. Fill the left column from bottom to top
5. Repeat for inner layers

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test input n=3
- **Function (`function/spiral_matrix_ii.xs`):** Contains the solution logic

## Function Signature
- **Input:** 
  - `n` (int): The size of the matrix (n x n), must be >= 1
- **Output:** 
  - Returns an array of arrays (int[][]) representing the n x n spiral matrix

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| n=1 | `[[1]]` |
| n=2 | `[[1, 2], [4, 3]]` |
| n=3 | `[[1, 2, 3], [8, 9, 4], [7, 6, 5]]` |
| n=4 | `[[1, 2, 3, 4], [12, 13, 14, 5], [11, 16, 15, 6], [10, 9, 8, 7]]` |

### Explanation of n=3:
```
 1 → 2 → 3
         ↓
 8 → 9   4
 ↑       ↓
 7 ← 6 ← 5
```

**Output:** `[[1, 2, 3], [8, 9, 4], [7, 6, 5]]`
