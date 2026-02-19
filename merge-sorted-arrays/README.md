# Merge Sorted Arrays

## Problem
Given two sorted integer arrays, merge them into a single sorted array.

The classic merge algorithm from merge sort - efficiently combine two already-sorted arrays without re-sorting. This runs in O(n+m) time where n and m are the lengths of the input arrays.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/merge_sorted_arrays.xs`):** Contains the solution logic

## Function Signature
- **Input:** 
  - `array1` (int[]): First sorted array
  - `array2` (int[]): Second sorted array
- **Output:** 
  - Returns int[]: A new sorted array containing all elements from both input arrays

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[1, 3, 5]`, `[2, 4, 6]` | `[1, 2, 3, 4, 5, 6]` |
| `[], []` | `[]` |
| `[1], []` | `[1]` |
| `[], [1]` | `[1]` |
| `[1, 2, 3]`, `[4, 5, 6]` | `[1, 2, 3, 4, 5, 6]` |
| `[4, 5, 6]`, `[1, 2, 3]` | `[1, 2, 3, 4, 5, 6]` |
| `[1, 3, 5, 7]`, `[2, 4, 6, 8]` | `[1, 2, 3, 4, 5, 6, 7, 8]` |

## Algorithm
The function uses a two-pointer technique:
1. Initialize pointers `i` and `j` to the start of each array
2. Compare elements at both pointers, add the smaller one to result
3. Advance the pointer of the array whose element was added
4. Repeat until one array is exhausted
5. Append all remaining elements from the other array
