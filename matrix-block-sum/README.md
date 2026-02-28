# Matrix Block Sum

## Problem

Given a 2D matrix `mat` of integers and an integer `k`, return a matrix `answer` where each `answer[i][j]` is the sum of all elements `mat[r][c]` for:

- `i - k <= r <= i + k`
- `j - k <= c <= j + k`
- `(r, c)` is a valid position in the matrix

In other words, for each cell in the output matrix, calculate the sum of all elements in the input matrix that fall within a square block centered at that cell with radius `k`. The block boundaries are clamped to stay within the matrix bounds.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/matrix-block-sum.xs`):** Contains the solution logic using 2D prefix sum

## Function Signature

- **Input:**
  - `matrix` (int[][]): A 2D array of integers
  - `k` (int): The radius of the block to sum around each cell
- **Output:** (int[][]): A matrix where each cell contains the sum of its corresponding k-radius block

## Approach

The solution uses a **2D Prefix Sum** (also known as 2D integral image) technique for optimal O(m×n) time complexity:

1. **Build prefix sum array:** Create an auxiliary array `prefix` where `prefix[i][j]` stores the sum of all elements from `(0,0)` to `(i-1,j-1)` in the original matrix.

2. **Query block sums:** For each cell, use the inclusion-exclusion principle on the prefix array to compute any rectangular sum in O(1) time.

**Time Complexity:** O(m×n) where m and n are the matrix dimensions  
**Space Complexity:** O(m×n) for the prefix sum array

## Test Cases

| Input | k | Expected Output |
|-------|---|-----------------|
| `[[1,2,3],[4,5,6],[7,8,9]]` | 1 | `[[12,21,16],[27,45,33],[24,39,28]]` |
| `[[1,2,3],[4,5,6],[7,8,9]]` | 2 | `[[45,45,45],[45,45,45],[45,45,45]]` |
| `[[1]]` | 0 | `[[1]]` |
| `[[1,2],[3,4]]` | 0 | `[[1,2],[3,4]]` |

### Test Case Explanations

**Case 1 - Basic 3x3 with k=1:**
- For cell (0,0): block is rows 0-1, cols 0-1 = 1+2+4+5 = 12
- For cell (1,1): block is rows 0-2, cols 0-2 = sum of entire matrix = 45

**Case 2 - Full matrix sum (k >= matrix size):**
- With k=2 on a 3x3 matrix, every block covers the entire matrix
- All output cells equal the total sum (45)

**Case 3 - Single element matrix:**
- Edge case with minimum matrix size
- Output equals input when k=0

**Case 4 - k=0 (no radius):**
- Each block is just the single cell itself
- Output equals input matrix
