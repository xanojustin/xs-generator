# Sorted Squares

## Problem
Given an integer array `nums` sorted in non-decreasing order, return an array of the squares of each number sorted in non-decreasing order.

### Examples
- **Input:** `nums = [-4, -1, 0, 3, 10]`  
  **Output:** `[0, 1, 9, 16, 100]`  
  **Explanation:** After squaring: `[16, 1, 0, 9, 100]`. After sorting: `[0, 1, 9, 16, 100]`

- **Input:** `nums = [-7, -3, 2, 3, 11]`  
  **Output:** `[4, 9, 9, 49, 121]`

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/sorted_squares.xs`):** Contains the solution logic using two-pointer technique

## Function Signature
- **Input:** 
  - `nums` (int[]): A sorted array of integers in non-decreasing order. May contain negative numbers.
- **Output:** 
  - Returns int[]: Array of squares sorted in non-decreasing order

## Algorithm
This solution uses the **two-pointer technique** for O(n) time complexity:

1. Initialize two pointers: `left` at start (0), `right` at end (n-1)
2. Create result array of same length
3. Fill result from the end (largest to smallest) since larger squares come from array ends
4. Compare squares at left and right pointers
5. Place larger square at current position and move that pointer inward
6. Continue until pointers meet

**Time Complexity:** O(n) - single pass through array  
**Space Complexity:** O(n) - for result array

## Test Cases

| Input | Expected Output | Notes |
|-------|-----------------|-------|
| `[-4, -1, 0, 3, 10]` | `[0, 1, 9, 16, 100]` | Mixed negatives and positives |
| `[-7, -3, 2, 3, 11]` | `[4, 9, 9, 49, 121]` | All distinct values |
| `[]` | `[]` | Edge case: empty array |
| `[5]` | `[25]` | Edge case: single element |
| `[-5, -3, -2]` | `[4, 9, 25]` | All negative numbers |
| `[1, 2, 3, 4]` | `[1, 4, 9, 16]` | All positive numbers |
| `[-10, -5, 0, 5, 10]` | `[0, 25, 25, 100, 100]` | Symmetric values |
