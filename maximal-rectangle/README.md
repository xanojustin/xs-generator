# Maximal Rectangle

## Problem

Given a binary matrix filled with `0`s and `1`s, find the **largest rectangle** containing only `1`s and return its area.

### Example
```
Input: matrix = [
  ["1","0","1","0","0"],
  ["1","0","1","1","1"],
  ["1","1","1","1","1"],
  ["1","0","0","1","0"]
]
Output: 6
```

The largest rectangle is formed by the `1`s in rows 1-2, columns 2-4 (0-indexed), giving a 2×3 = 6 area rectangle.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/maximal_rectangle.xs`):** Contains the solution logic using histogram-based approach

## Function Signature

- **Input:** 
  - `matrix` (int[][]) — A binary matrix where each element is either 0 or 1
- **Output:** 
  - (int) — The area of the largest rectangle containing only 1s

## Algorithm

The solution uses a **histogram + stack** approach:

1. For each row, maintain a `heights` array where `heights[j]` represents the number of consecutive `1`s ending at column `j` (including current row)
2. For each row's histogram, find the largest rectangle using a monotonic stack
3. Track the maximum area found across all rows

**Time Complexity:** O(rows × cols)  
**Space Complexity:** O(cols)

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[[1,0,1,0,0],[1,0,1,1,1],[1,1,1,1,1],[1,0,0,1,0]]` | 6 |
| `[[1]]` | 1 |
| `[[0]]` | 0 |
| `[]` | 0 |
| `[[1,1,1,1],[1,1,1,1],[1,1,1,1]]` | 12 |
| `[[1,0,0,0],[1,0,0,0],[1,0,0,0],[1,1,1,1]]` | 4 |

### Test Case Explanations

1. **Basic case:** 4×5 matrix with mixed values → largest 2×3 rectangle = 6
2. **Single element (1):** 1×1 matrix with 1 → area = 1
3. **Single element (0):** 1×1 matrix with 0 → area = 0
4. **Empty matrix:** Edge case → returns 0
5. **Full matrix:** 3×4 matrix of all 1s → largest rectangle is entire matrix = 12
6. **L-shaped:** Tests the histogram logic with non-uniform heights
