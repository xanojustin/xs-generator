# Spiral Matrix

## Problem

Given an `m x n` matrix, return all elements of the matrix in **spiral order** (clockwise, starting from the top-left corner).

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/spiral_matrix.xs`):** Contains the solution logic

## Function Signature

- **Input:** 
  - `matrix` (json): 2D array of integers representing the matrix
- **Output:** 
  - `int[]`: Array containing all matrix elements in spiral order

## Algorithm

This solution uses a **boundary-tracking approach** that maintains four pointers (top, bottom, left, right) to track the current layer of the spiral:

1. **Initialize boundaries:**
   - `top` = 0 (first row)
   - `bottom` = rows - 1 (last row)
   - `left` = 0 (first column)
   - `right` = cols - 1 (last column)

2. **Spiral traversal loop** (while boundaries are valid):
   - **Left to Right:** Traverse the top row from left to right, then increment `top`
   - **Top to Bottom:** Traverse the right column from top to bottom, then decrement `right`
   - **Right to Left:** If rows remain, traverse bottom row from right to left, then decrement `bottom`
   - **Bottom to Top:** If columns remain, traverse left column from bottom to top, then increment `left`

3. **Boundary check:** After each direction, verify that the boundaries haven't crossed

**Time Complexity:** O(m × n) - each element is visited exactly once  
**Space Complexity:** O(1) auxiliary space (excluding the output array)

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[[1,2,3],[4,5,6],[7,8,9]]` | `[1,2,3,6,9,8,7,4,5]` | 3x3 matrix: top row → right col → bottom row → left col → center |
| `[[1,2,3,4],[5,6,7,8],[9,10,11,12]]` | `[1,2,3,4,8,12,11,10,9,5,6,7]` | 3x4 matrix: outer layer then inner elements |
| `[[1]]` | `[1]` | Single element matrix |
| `[]` | `[]` | Empty matrix edge case |

### Test Case Descriptions

1. **Happy path case (3x3):** Standard square matrix with odd dimensions, ends with center element
2. **Rectangular matrix (3x4):** Non-square matrix, demonstrates complete outer layer traversal
3. **Edge case (single element):** Minimum valid matrix size
4. **Edge case (empty):** Empty matrix should return empty result
