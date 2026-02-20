# Rotate Array

## Problem
Given an array of integers, rotate the array to the right by `k` steps, where `k` is non-negative.

For example, with array `[1, 2, 3, 4, 5]` and `k = 2`:
- The array rotated right by 2 steps becomes `[4, 5, 1, 2, 3]`

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/rotate_array.xs`):** Contains the solution logic

## Function Signature
- **Input:**
  - `arr` (int[]): Array of integers to rotate
  - `k` (int): Number of steps to rotate to the right
- **Output:** 
  - int[]: The rotated array

## Approach
1. Handle edge cases (empty array, single element, k=0)
2. Normalize k using modulo to handle cases where k > array length
3. Calculate split point where array should be divided
4. Combine the two parts: last k elements + first (n-k) elements

## Test Cases

| Input | k | Expected Output |
|-------|---|-----------------|
| `[1, 2, 3, 4, 5]` | 2 | `[4, 5, 1, 2, 3]` |
| `[1, 2, 3, 4, 5]` | 0 | `[1, 2, 3, 4, 5]` |
| `[1, 2, 3]` | 3 | `[1, 2, 3]` |
| `[1, 2, 3, 4, 5, 6, 7]` | 3 | `[5, 6, 7, 1, 2, 3, 4]` |
| `[]` | 1 | `[]` |
| `[1]` | 100 | `[1]` |
| `[1, 2, 3, 4, 5]` | 7 | `[4, 5, 1, 2, 3]` (k > length) |

## Complexity
- **Time Complexity:** O(n) where n is the length of the array
- **Space Complexity:** O(n) for the resulting array
