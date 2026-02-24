# Lucky Numbers in a Matrix

## Problem

Given an `m x n` matrix of distinct numbers, return all **lucky numbers** in the matrix in any order.

A **lucky number** is an element of the matrix such that it is the **minimum** element in its row and the **maximum** element in its column.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/lucky_numbers.xs`):** Contains the solution logic that finds all lucky numbers

## Function Signature

- **Input:** 
  - `matrix`: An object containing a 2D array `rows` of distinct integers
  - Type: `object { json rows }`
  
- **Output:** 
  - Array of lucky numbers found in the matrix
  - Type: `int[]`

## Algorithm

1. Find the minimum element in each row
2. Find the maximum element in each column
3. An element is "lucky" if it equals both its row's minimum AND its column's maximum
4. Return all such lucky numbers

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[[3,7,8],[9,11,13],[15,16,17]]` | `[15]` |
| `[[1,10,4,2],[9,3,8,7],[15,16,17,12]]` | `[12]` |
| `[[7,8],[1,2]]` | `[7]` |
| `[[1]]` | `[1]` |
| `[]` (empty matrix) | `[]` |

### Explanation of Test Cases

1. **Basic case:** 15 is the minimum in row 3 and maximum in column 1
2. **Multiple rows/columns:** 12 is the minimum in row 3 and maximum in column 4
3. **2x2 matrix:** 7 is min in row 1 and max in column 1
4. **Single element:** The only element is both row min and column max
5. **Empty matrix:** Returns empty array

## Example Walkthrough

For matrix `[[3,7,8],[9,11,13],[15,16,17]]`:
- Row minimums: [3, 9, 15]
- Column maximums: [15, 16, 17]
- Element 15: row min at row 3 ✓, column max at column 1 ✓ → Lucky!
