# Pascal's Triangle II

## Problem
Given an integer `rowIndex`, return the `rowIndex`-th (0-indexed) row of Pascal's triangle.

In Pascal's triangle, each number is the sum of the two numbers directly above it. The triangle starts with row 0 being `[1]`.

Example of Pascal's Triangle:
```
Row 0:     1
Row 1:    1 1
Row 2:   1 2 1
Row 3:  1 3 3 1
Row 4: 1 4 6 4 1
```

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/pascals_triangle_ii.xs`):** Contains the solution logic

## Function Signature
- **Input:** 
  - `row_index` (int, min: 0) - The row index (0-indexed) to return
- **Output:** 
  - Array of integers representing the row at the given index

## Test Cases

| Input (row_index) | Expected Output |
|-------------------|-----------------|
| 0 | `[1]` |
| 1 | `[1, 1]` |
| 2 | `[1, 2, 1]` |
| 3 | `[1, 3, 3, 1]` |
| 4 | `[1, 4, 6, 4, 1]` |

### Test Case Explanations
- **row_index = 0:** Edge case - the first row is always `[1]`
- **row_index = 1:** Basic case - second row is `[1, 1]`
- **row_index = 3:** Classic case - returns `[1, 3, 3, 1]`
- **row_index = 4:** Boundary case - includes interior values that sum from above

## Algorithm
The solution builds each row iteratively:
1. Start with row `[1]`
2. For each subsequent row, build it from the previous row:
   - Start with `1`
   - For each position, sum the two numbers above it from the previous row
   - End with `1`
3. Continue until reaching the desired row index
