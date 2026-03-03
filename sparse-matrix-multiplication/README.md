# Sparse Matrix Multiplication

## Problem
Multiply two sparse matrices and return the result as a sparse matrix.

A sparse matrix is a matrix in which most elements are zero. Instead of storing all elements (including zeros), we only store the non-zero elements as objects with `row`, `col`, and `value` properties.

Given two sparse matrices A (dimensions m×n) and B (dimensions n×p), compute their product C = A × B (dimensions m×p), also returned in sparse format.

The matrix multiplication follows the standard rule:
- C[i][j] = Σ(A[i][k] × B[k][j]) for k = 1 to n

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/sparse_matrix_multiply.xs`):** Contains the solution logic

## Function Signature
- **Input:**
  - `matrix_a` (object[]): First sparse matrix as array of `{row, col, value}` objects
  - `matrix_b` (object[]): Second sparse matrix as array of `{row, col, value}` objects  
  - `a_rows` (int): Number of rows in matrix A
  - `a_cols` (int): Number of columns in matrix A (must equal b_rows)
  - `b_cols` (int): Number of columns in matrix B
- **Output:** 
  - Array of `{row, col, value}` objects representing the product matrix in sparse format, sorted by row then column

## Test Cases

### Test Case 1: Basic Multiplication
Matrix A (2×3):
```
[1  0  2]
[0  3  0]
```

Matrix B (3×2):
```
[4  0]
[0  5]
[6  7]
```

Expected Result (2×2):
```
[16  14]
[0   15]
```

Sparse output:
| row | col | value |
|-----|-----|-------|
| 1   | 1   | 16    |
| 1   | 2   | 14    |
| 2   | 2   | 15    |

*Calculation:*
- C[1,1] = 1×4 + 0×0 + 2×6 = 4 + 0 + 12 = 16
- C[1,2] = 1×0 + 0×5 + 2×7 = 0 + 0 + 14 = 14
- C[2,1] = 0×4 + 3×0 + 0×6 = 0 + 0 + 0 = 0 (not stored)
- C[2,2] = 0×0 + 3×5 + 0×7 = 0 + 15 + 0 = 15

### Test Case 2: Empty Result
Matrix A (1×1): `[5]`
Matrix B (1×1): `[0]`

Expected Result: `[]` (empty array, since result is all zeros)

### Test Case 3: Identity Matrix
Matrix A (2×2): Identity matrix
Matrix B (2×2): Any matrix

Expected: B unchanged

## Algorithm
1. Build a lookup map for matrix B organized by row for O(1) access
2. For each non-zero element in A at position (i, k):
   - Find all non-zero elements in B at row k
   - Multiply and accumulate into result cell (i, j)
3. Convert result map to sparse format, filtering out zeros
4. Sort result by row, then by column

## Complexity
- Time: O(nnz(A) × average_nnz_per_row(B)) where nnz = number of non-zeros
- Space: O(nnz(result)) for the output
