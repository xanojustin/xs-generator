# Search a 2D Matrix

## Problem
Write an efficient algorithm that searches for a value `target` in an `m x n` integer matrix. The matrix has the following properties:
- Integers in each row are sorted in ascending order from left to right
- Integers in each column are sorted in ascending order from top to bottom

Return `true` if the target is found in the matrix, `false` otherwise.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/search_2d_matrix.xs`):** Contains the solution logic

## Function Signature
- **Input:**
  - `matrix` (json): A 2D array of integers where rows and columns are sorted in ascending order
  - `target` (int): The integer value to search for
- **Output:**
  - (bool): `true` if target is found, `false` otherwise

## Approach
The solution uses the "top-right corner" search strategy:
1. Start at the top-right corner of the matrix
2. Compare the current element with the target:
   - If equal: target found!
   - If current > target: move left (column decreases)
   - If current < target: move down (row increases)
3. Repeat until target is found or boundaries are exceeded

**Time Complexity:** O(m + n) where m = rows, n = columns  
**Space Complexity:** O(1) - only uses a few variables

## Test Cases

| Matrix | Target | Expected Output | Description |
|--------|--------|-----------------|-------------|
| `[[1,4,7,11,15],[2,5,8,12,19],[3,6,9,16,22],[10,13,14,17,24],[18,21,23,26,30]]` | 5 | `true` | Basic case: target exists in middle |
| `[[1,4,7],[2,5,8],[3,6,9]]` | 10 | `false` | Target doesn't exist |
| `[]` | 1 | `false` | Edge case: empty matrix |
| `[[1]]` | 1 | `true` | Edge case: single element, found |
| `[[1]]` | 2 | `false` | Edge case: single element, not found |
| `[[1,2,3]]` | 3 | `true` | Single row search |
| `[[1],[2],[3]]` | 2 | `true` | Single column search |
