# Matrix Transpose

## Problem
Given a 2D matrix (array of arrays), return the transpose of the matrix.

The **transpose** of a matrix is obtained by flipping the matrix over its main diagonal, switching the row and column indices. In other words, the element at position (i, j) in the original matrix moves to position (j, i) in the transposed matrix.

### Example
```
Input:  [[1, 2, 3],
         [4, 5, 6]]

Output: [[1, 4],
         [2, 5],
         [3, 6]]
```

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/matrix_transpose.xs`):** Contains the solution logic

## Function Signature
- **Input:** `matrix` (int[][]) - A 2D array of integers representing the matrix to transpose
- **Output:** (int[][]) - The transposed matrix with dimensions swapped (columns become rows, rows become columns)

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[[1, 2, 3], [4, 5, 6]]` | `[[1, 4], [2, 5], [3, 6]]` |
| `[[1, 2], [3, 4], [5, 6]]` | `[[1, 3, 5], [2, 4, 6]]` |
| `[[1]]` | `[[1]]` |
| `[]` | `[]` |
| `[[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12]]` | `[[1, 5, 9], [2, 6, 10], [3, 7, 11], [4, 8, 12]]` |

### Test Case Details

1. **Basic 2x3 matrix:** Standard rectangular matrix transpose
2. **Basic 3x2 matrix:** Rectangular matrix with different orientation
3. **Edge case - 1x1 matrix:** Single element matrix
4. **Edge case - Empty matrix:** Empty input should return empty output
5. **Boundary case - 3x4 matrix:** Larger matrix to verify algorithm scales
