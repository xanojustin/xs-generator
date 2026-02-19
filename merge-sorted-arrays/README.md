# Merge Sorted Arrays

## Problem

You are given two integer arrays `arr1` and `arr2`, both sorted in non-decreasing order. Merge them into a single sorted array and return it.

This is a fundamental algorithm used in merge sort and demonstrates the classic two-pointer technique for efficiently combining sorted data.

## Function Signature

- **Input:**
  - `arr1` (int[]) - First sorted array of integers (may be empty)
  - `arr2` (int[]) - Second sorted array of integers (may be empty)
- **Output:** `int[]` - A new sorted array containing all elements from both input arrays

## Algorithm

This implementation uses the two-pointer technique:
1. Initialize two pointers at the start of each array (i=0, j=0)
2. Compare elements at both pointers
3. Take the smaller element and add it to the result
4. Advance the pointer of the array we took from
5. Repeat until one array is exhausted
6. Append any remaining elements from the other array

**Time Complexity:** O(n + m) where n and m are the lengths of the two arrays
**Space Complexity:** O(n + m) for the result array

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| arr1: [1, 3, 5], arr2: [2, 4, 6] | [1, 2, 3, 4, 5, 6] |
| arr1: [1, 2, 3], arr2: [4, 5, 6] | [1, 2, 3, 4, 5, 6] |
| arr1: [], arr2: [1, 2, 3] | [1, 2, 3] |
| arr1: [1, 2, 3], arr2: [] | [1, 2, 3] |
| arr1: [], arr2: [] | [] |
| arr1: [1, 1, 1], arr2: [1, 2, 3] | [1, 1, 1, 1, 2, 3] |
| arr1: [-3, -1, 0], arr2: [-2, 1, 2] | [-3, -2, -1, 0, 1, 2] |

### Edge Cases Explained

1. **Interleaved [1,3,5] + [2,4,6]:** Classic merge case - elements alternate between arrays
2. **Sequential [1,2,3] + [4,5,6]:** All of arr1 comes before all of arr2
3. **One empty [] + [1,2,3]:** Should return the non-empty array unchanged
4. **Both empty [] + []:** Should return empty array
5. **Duplicates [1,1,1] + [1,2,3]:** Should preserve all duplicates in sorted order
6. **Negative numbers [-3,-1,0] + [-2,1,2]:** Algorithm works with negative integers
