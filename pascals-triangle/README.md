# Pascal's Triangle

## Problem

Generate Pascal's Triangle with the specified number of rows.

Pascal's Triangle is a triangular array of binomial coefficients. Each number is the sum of the two numbers directly above it. The triangle starts with a single 1 at the top, and each subsequent row has one more element than the previous row.

For example, Pascal's Triangle with 5 rows:
```
    [1]
   [1, 1]
  [1, 2, 1]
 [1, 3, 3, 1]
[1, 4, 6, 4, 1]
```

### Pattern Rules:
- The first and last element of each row is always 1
- Each interior element is the sum of the two elements directly above it from the previous row
- Row n has n+1 elements (0-indexed)

This classic coding exercise tests understanding of:
- Nested array structures
- Iterative algorithms with nested loops
- Dynamic array construction

## Function Signature

- **Input:** `num_rows` (int) - The number of rows to generate (must be >= 1, max 30)
- **Output:** `int[][]` - A 2D array (array of arrays) where each inner array represents a row in Pascal's Triangle

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| 1 | `[[1]]` |
| 2 | `[[1], [1, 1]]` |
| 3 | `[[1], [1, 1], [1, 2, 1]]` |
| 5 | `[[1], [1, 1], [1, 2, 1], [1, 3, 3, 1], [1, 4, 6, 4, 1]]` |
| 0 | Error (validation: min:1) |

### Edge Cases Explained

1. **num_rows = 1**: Single row with just `[[1]]` - the base case with only the top of the triangle
2. **num_rows = 2**: Two rows `[[1], [1, 1]]` - tests the second row which is always two 1s
3. **num_rows = 3**: Three rows including the first interior element (2) which is 1+1 from the row above
4. **num_rows = 5**: Tests multiple rows with various interior sums (2=1+1, 3=1+2, 6=3+3, etc.)
5. **num_rows = 0**: Should fail validation since num_rows must be >= 1
6. **num_rows = 30**: Tests maximum allowed input with large binomial coefficients (C(29,14) = 67863915)
