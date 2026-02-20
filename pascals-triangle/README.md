# Pascal's Triangle

## Problem
Generate the first `n` rows of **Pascal's Triangle**.

In Pascal's Triangle, each number is the sum of the two numbers directly above it. The triangle starts with a single 1 at the top, and each subsequent row contains one more element than the previous row.

### Example
```
Row 0:     1
Row 1:    1 1
Row 2:   1 2 1
Row 3:  1 3 3 1
Row 4: 1 4 6 4 1
```

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/pascals-triangle.xs`):** Contains the solution logic

## Function Signature
- **Input:** 
  - `rows` (int): The number of rows to generate (must be non-negative)
- **Output:** 
  - Array of arrays (int[][]): Each inner array represents a row in Pascal's Triangle

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `0` | `[]` (empty array) |
| `1` | `[[1]]` (single row) |
| `2` | `[[1], [1, 1]]` |
| `5` | `[[1], [1, 1], [1, 2, 1], [1, 3, 3, 1], [1, 4, 6, 4, 1]]` |
| `6` | `[[1], [1, 1], [1, 2, 1], [1, 3, 3, 1], [1, 4, 6, 4, 1], [1, 5, 10, 10, 5, 1]]` |

### Explanation of Cases
- **Edge case (0 rows):** Returns an empty array when no rows are requested
- **Edge case (1 row):** Returns just the first row `[1]`
- **Basic case (2 rows):** Shows the first two rows of the triangle
- **Standard case (5 rows):** Classic Pascal's Triangle with 5 rows
- **Boundary case (6 rows):** Verifies correct calculation of larger numbers (10 = 4+6)
