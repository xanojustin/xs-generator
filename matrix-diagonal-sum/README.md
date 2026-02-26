# Matrix Diagonal Sum

## Problem

Given a square matrix (2D array), calculate the sum of all elements on both the **primary diagonal** (top-left to bottom-right) and the **secondary diagonal** (top-right to bottom-left).

For matrices with odd dimensions, the center element is part of both diagonals and should only be counted **once**.

### Example

For the matrix:
```
[[1, 2, 3],
 [4, 5, 6],
 [7, 8, 9]]
```

- Primary diagonal: 1 + 5 + 9 = 15
- Secondary diagonal: 3 + 5 + 7 = 15
- Center element (5) appears in both, so we count it once
- **Total sum: 1 + 5 + 9 + 3 + 7 = 25**

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/matrix_diagonal_sum.xs`):** Contains the solution logic

## Function Signature

- **Input:** 
  - `matrix` (object): A square 2D array of integers (n x n)
- **Output:** 
  - `int`: The sum of all diagonal elements (center counted once for odd n)

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[[1, 2, 3], [4, 5, 6], [7, 8, 9]]` | 25 |
| `[[1, 1], [1, 1]]` | 4 |
| `[[5]]` | 5 |
| `[[1, 2], [3, 4]]` | 10 |
| `[[1, 0, 0], [0, 1, 0], [0, 0, 1]]` | 3 |

### Test Case Descriptions

1. **3x3 matrix:** Tests both diagonals with center overlap
2. **2x2 matrix:** No center overlap, both diagonals fully counted
3. **1x1 matrix:** Edge case - single element matrix
4. **2x2 with different values:** Verifies correct position-based summing
5. **Identity matrix:** Tests that zeros don't affect sum, ones on diagonals sum correctly
