# Lucky Numbers in a Matrix

## Problem
Given an `m x n` matrix of distinct numbers, return all **lucky numbers** in the matrix in any order.

A **lucky number** is an element of the matrix such that it is the **minimum** element in its row and the **maximum** element in its column.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/lucky-numbers-matrix.xs`):** Contains the solution logic

## Function Signature
- **Input:** `matrix` (int[][]) - A 2D array of distinct integers
- **Output:** int[] - Array of all lucky numbers found in the matrix

## Test Cases

| Input Matrix | Expected Output |
|--------------|-----------------|
| `[[3,7,8],[9,11,13],[15,16,17]]` | `[15]` |
| `[[1,10,4,2],[9,3,8,7],[15,16,17,12]]` | `[12]` |
| `[[7,8],[1,2]]` | `[7]` |
| `[[1]]` | `[1]` |
| `[[1,2,3],[4,5,6],[7,8,9]]` | `[]` (no lucky numbers) |

### Explanation of Test Cases:
1. **Basic case:** 15 is the minimum in row 2 `[15,16,17]` and maximum in column 0 `[3,9,15]`
2. **Multiple columns:** 12 is the minimum in row 2 `[15,16,17,12]` and maximum in column 3 `[2,7,12]`
3. **2x2 matrix:** 7 is minimum in row 0 `[7,8]` and maximum in column 0 `[7,1]`
4. **Single element:** The only element is both min and max
5. **No lucky numbers:** No element satisfies both conditions
