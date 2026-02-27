# Count Negative Numbers in a Sorted Matrix

## Problem
Given a `m x n` matrix `grid` which is sorted in **non-increasing** order both row-wise and column-wise, return the number of negative numbers in `grid`.

### Constraints
- `m == grid.length`
- `n == grid[i].length`
- `1 <= m, n <= 100`
- `-100 <= grid[i][j] <= 100`

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/count_negative_numbers.xs`):** Contains the solution logic

## Function Signature
- **Input:** 
  - `grid: int[][]` — A 2D matrix of integers sorted in non-increasing order (both rows and columns)
- **Output:** 
  - `int` — The count of negative numbers in the matrix

## Approach
Since the matrix is sorted in non-increasing order both row-wise and column-wise:
- Within each row, once we find a negative number, all subsequent numbers in that row are also negative
- We iterate through each row and for each row, find the first negative number
- Once found, we count all remaining elements in that row as negative and move to the next row

### Time Complexity
- **O(m × n)** in the worst case (when no negatives exist)
- More efficient than brute force due to early termination per row

### Space Complexity
- **O(1)** — Only using a counter variable

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[[4,3,2,-1],[3,2,1,-1],[1,1,-1,-2],[-1,-1,-2,-3]]` | `8` |
| `[[3,2],[1,0]]` | `0` |
| `[[1,-1],[-1,-1]]` | `3` |
| `[[-1]]` | `1` |
| `[[5]]` | `0` |
| `[]` | `0` |

### Test Case Explanations

1. **Basic case:** 4x4 matrix with 8 negative numbers
2. **No negatives:** 2x2 matrix with all positive numbers
3. **Mixed:** 2x2 matrix with 3 negatives
4. **Single element negative:** 1x1 matrix with -1
5. **Single element positive:** 1x1 matrix with 5
6. **Empty matrix:** Edge case — empty grid returns 0
