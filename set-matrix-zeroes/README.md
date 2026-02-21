# Set Matrix Zeroes

## Problem

Given an `m x n` integer matrix, if an element is `0`, set its entire row and column to `0`.

You must do this in-place (conceptually - in XanoScript we return a new matrix with the modifications applied).

**Example:**
- Input: `[[1,1,1],[1,0,1],[1,1,1]]`
- Output: `[[1,0,1],[0,0,0],[1,0,1]]`

The element at position `[1][1]` is `0`, so row 1 and column 1 are set to `0`.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/set_matrix_zeroes.xs`):** Contains the solution logic

## Function Signature

- **Input:** 
  - `matrix` (json): A 2D array of integers representing the matrix
- **Output:** 
  - (json): A new 2D array with rows and columns zeroed out where the original had zeros

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[[1,1,1],[1,0,1],[1,1,1]]` | `[[1,0,1],[0,0,0],[1,0,1]]` |
| `[[0,1,2,0],[3,4,5,2],[1,3,1,5]]` | `[[0,0,0,0],[0,4,5,0],[0,3,1,0]]` |
| `[[1,2,3],[4,5,6],[7,8,9]]` | `[[1,2,3],[4,5,6],[7,8,9]]` (no zeros in input) |
| `[[0]]` | `[[0]]` |
| `[[1,2,3]]` | `[[1,2,3]]` (single row, no zeros) |
| `[[1],[2],[0]]` | `[[0],[0],[0]]` (single column with zero) |

### Test Case Descriptions

1. **Basic case:** A 3x3 matrix with a single zero in the center - row 1 and column 1 are zeroed
2. **Multiple zeros:** A 3x4 matrix with zeros at multiple positions - multiple rows and columns affected
3. **No zeros:** A 3x3 matrix with no zeros - output should be identical to input
4. **Single element (zero):** 1x1 matrix containing zero - output is the same
5. **Single row:** 1x3 matrix with no zeros - output unchanged
6. **Single column with zero:** 3x1 matrix with a zero - entire column (all rows) zeroed
