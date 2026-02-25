# Toeplitz Matrix

## Problem
Given an `m x n` matrix, return `true` if the matrix is **Toeplitz**. Otherwise, return `false`.

A matrix is **Toeplitz** if every diagonal from top-left to bottom-right has the same element.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/is_toeplitz.xs`):** Contains the solution logic

## Function Signature
- **Input:** `matrix` (json) - A 2D array of integers representing the matrix
- **Output:** (bool) - `true` if the matrix is Toeplitz, `false` otherwise

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[[1,2,3,4],[5,1,2,3],[9,5,1,2]]` | `true` |
| `[[1,2],[2,2]]` | `false` |
| `[[1]]` | `true` (single element) |
| `[[1,2],[5,1],[9,5]]` | `true` (non-square matrix) |

### Explanation of Test Cases

1. **Basic Toeplitz matrix:**
   ```
   1 2 3 4
   5 1 2 3
   9 5 1 2
   ```
   All diagonals have the same element:
   - Diagonal (0,0)→(1,1)→(2,2): 1, 1, 1
   - Diagonal (0,1)→(1,2)→(2,3): 2, 2, 2
   - Diagonal (0,2)→(1,3): 3, 3
   - Diagonal (0,3): 4
   - And so on...

2. **Not Toeplitz:**
   ```
   1 2
   2 2
   ```
   The diagonal (0,0)→(1,1) has 1 and 2 - different values!

3. **Single element:** Edge case - always Toeplitz

4. **Non-square matrix:** Toeplitz property applies to any rectangular matrix
