# Merge Sort

## Problem

Implement the merge sort algorithm to sort an array of integers in ascending order.

Merge sort is a divide-and-conquer sorting algorithm that works by:
1. **Divide**: Split the array into two halves
2. **Conquer**: Recursively sort each half
3. **Combine**: Merge the two sorted halves into a single sorted array

### Algorithm Steps:
1. If the array has 0 or 1 elements, it's already sorted (base case)
2. Divide the array into two equal (or nearly equal) subarrays
3. Recursively sort the left subarray
4. Recursively sort the right subarray
5. Merge the two sorted subarrays back together by comparing elements and placing them in order

This implementation uses an **iterative bottom-up approach** that avoids recursion by starting with subarrays of size 1 and doubling the size on each pass.

Merge sort has O(n log n) time complexity in all cases, making it much more efficient than simple algorithms like bubble sort (O(n²)) for large datasets.

## Function Signature

- **Input:** `numbers` (int[]) - An array of integers to be sorted
- **Output:** `int[]` - A new array containing the same integers in ascending order

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[64, 34, 25, 12, 22, 11, 90]` | `[11, 12, 22, 25, 34, 64, 90]` |
| `[5, 2, 8, 1, 9]` | `[1, 2, 5, 8, 9]` |
| `[]` | `[]` |
| `[42]` | `[42]` |
| `[3, 3, 3]` | `[3, 3, 3]` |
| `[5, 4, 3, 2, 1]` | `[1, 2, 3, 4, 5]` |
| `[-5, 3, -10, 0, 8]` | `[-10, -5, 0, 3, 8]` |
| `[1, 2, 3, 4, 5]` | `[1, 2, 3, 4, 5]` |
| `[100, -100, 0, 50, -50]` | `[-100, -50, 0, 50, 100]` |

### Edge Cases Explained

1. **Empty array `[]`**: Should return an empty array - tests handling of zero-length input
2. **Single element `[42]`**: Should return the same array - tests minimal input (base case)
3. **All duplicates `[3, 3, 3]`**: Should return the same array - tests stability with identical elements
4. **Reverse sorted `[5, 4, 3, 2, 1]`**: Tests worst-case scenario performance
5. **Negative numbers `[-5, 3, -10, 0, 8]`**: Tests that negative integers are sorted correctly
6. **Already sorted `[1, 2, 3, 4, 5]`**: Tests that already-sorted arrays are handled efficiently
7. **Mixed large/small `[100, -100, 0, 50, -50]`**: Tests boundary values with positive and negative extremes
