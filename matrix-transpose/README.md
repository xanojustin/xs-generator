# Matrix Transpose

## Problem

Given a 2D matrix (array of arrays), return its transpose. The transpose of a matrix is obtained by flipping the matrix over its main diagonal, switching the row and column indices.

For example, if you have a matrix:
```
[1, 2, 3]
[4, 5, 6]
```

Its transpose would be:
```
[1, 4]
[2, 5]
[3, 6]
```

In other words, the element at position `[i][j]` in the original matrix moves to position `[j][i]` in the transposed matrix.

## Function Signature

- **Input:** 
  - `matrix` (json): A 2D array representing the matrix to transpose. All rows should have the same length.
- **Output:** 
  - (json): A 2D array representing the transposed matrix. The output will have dimensions swapped (rows become columns, columns become rows).

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[[1, 2, 3], [4, 5, 6]]` | `[[1, 4], [2, 5], [3, 6]]` |
| `[[1, 2, 3], [4, 5, 6], [7, 8, 9]]` | `[[1, 4, 7], [2, 5, 8], [3, 6, 9]]` |
| `[[1]]` (single element) | `[[1]]` |
| `[[1, 2, 3]]` (single row) | `[[1], [2], [3]]` |
| `[]` (empty matrix) | `[]` |
| `[[1, 2], [3, 4], [5, 6]]` (more rows than columns) | `[[1, 3, 5], [2, 4, 6]]` |

### Notes on Test Cases

- **Basic case:** A 2x3 matrix transposes to a 3x2 matrix
- **Square matrix:** A 3x3 matrix transposes to another 3x3 matrix
- **Edge case - single element:** A 1x1 matrix is its own transpose
- **Edge case - single row:** A 1x3 matrix becomes a 3x1 matrix
- **Edge case - empty:** An empty matrix returns an empty matrix
- **Boundary case - non-square:** A 3x2 matrix transposes to a 2x3 matrix
