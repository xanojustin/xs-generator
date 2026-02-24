# Reshape Matrix

## Problem
In MATLAB, there is a handy function called `reshape` which can reshape an `m x n` matrix into a new one with a different size `r x c` keeping its original data.

You are given an `m x n` matrix `mat` and two integers `r` and `c` representing the number of rows and the number of columns of the wanted reshaped matrix.

The reshaped matrix should be filled with all the elements of the original matrix in the same row-traversing order as they were.

If the `reshape` operation with given parameters is possible and legal, output the new reshaped matrix; otherwise, output the original matrix.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/reshape_matrix.xs`):** Contains the solution logic

## Function Signature
- **Input:**
  - `mat` (int[][]): Input matrix as a 2D array of integers
  - `r` (int): Target number of rows
  - `c` (int): Target number of columns
- **Output:** (int[][]): The reshaped matrix if valid, otherwise the original matrix

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `mat = [[1,2],[3,4]], r = 1, c = 4` | `[[1,2,3,4]]` |
| `mat = [[1,2],[3,4]], r = 2, c = 4` | `[[1,2],[3,4]]` (original, invalid dimensions) |
| `mat = [[1,2,3],[4,5,6]], r = 3, c = 2` | `[[1,2],[3,4],[5,6]]` |
| `mat = [], r = 1, c = 1` | `[]` (empty matrix) |
| `mat = [[1]], r = 1, c = 1` | `[[1]]` (same dimensions) |

## Example Walkthrough

**Example 1:**
- Input: `mat = [[1,2],[3,4]]`, `r = 1`, `c = 4`
- Original size: 2 x 2 = 4 elements
- Target size: 1 x 4 = 4 elements ✓
- Flattened: `[1,2,3,4]`
- Reshaped: `[[1,2,3,4]]`

**Example 2:**
- Input: `mat = [[1,2],[3,4]]`, `r = 2`, `c = 4`
- Original size: 2 x 2 = 4 elements
- Target size: 2 x 4 = 8 elements ✗
- Return original: `[[1,2],[3,4]]`
