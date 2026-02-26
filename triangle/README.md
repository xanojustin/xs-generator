# Triangle Minimum Path Sum

## Problem
Given a triangle array, find the minimum path sum from top to bottom. Each step you may move to adjacent numbers on the row below.

For example, given the following triangle:
```
   2
  3 4
 6 5 7
4 1 8 3
```

The minimum path sum from top to bottom is `2 + 3 + 5 + 1 = 11`.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/minimum_path_sum.xs`):** Contains the solution logic using dynamic programming

## Function Signature
- **Input:** `triangle: int[][]` - A 2D array of integers representing the triangle structure
  - Row 0 has 1 element, row 1 has 2 elements, etc.
  - Each element can move to the element directly below or the element below and to the right
- **Output:** `int` - The minimum path sum from the top to the bottom of the triangle

## Algorithm
This solution uses **bottom-up dynamic programming**:
1. Start from the bottom row and work upwards
2. For each element, calculate the minimum path sum by adding the current value to the minimum of its two children
3. After processing all rows, the top element contains the answer

**Time Complexity:** O(n²) where n is the number of rows  
**Space Complexity:** O(n) - we only store one row at a time

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[[2], [3,4], [6,5,7], [4,1,8,3]]` | `11` |
| `[[-10]]` | `-10` |
| `[]` | `0` |
| `[[1], [2,3], [4,5,6]]` | `7` (1+2+4) |
| `[[1], [3,2], [4,10,5], [2,1,3,2]]` | `7` (1+2+5+1) |

## Example Walkthrough

For triangle `[[2], [3,4], [6,5,7], [4,1,8,3]]`:

1. Start with bottom row: dp = `[4, 1, 8, 3]`
2. Row 2: `[6, 5, 7]`
   - 6 + min(4, 1) = 7
   - 5 + min(1, 8) = 6
   - 7 + min(8, 3) = 10
   - dp = `[7, 6, 10]`
3. Row 1: `[3, 4]`
   - 3 + min(7, 6) = 9
   - 4 + min(6, 10) = 10
   - dp = `[9, 10]`
4. Row 0: `[2]`
   - 2 + min(9, 10) = 11
   - dp = `[11]`

Final answer: **11**
