# Merge Sort

## Problem
Implement the **Merge Sort** algorithm to sort an array of integers. Merge sort is a classic divide-and-conquer sorting algorithm that:

1. Divides the input array into two halves
2. Recursively sorts each half
3. Merges the two sorted halves back together

The algorithm has O(n log n) time complexity in all cases (best, average, worst), making it more predictable than quicksort and more efficient than bubble sort for large datasets.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/merge_sort.xs`):** Main entry point - handles edge cases and initiates sorting
- **Function (`function/merge_sort_helper.xs`):** Recursively splits and sorts the array
- **Function (`function/merge_arrays.xs`):** Merges two sorted arrays into one

## Function Signature
- **Input:** `numbers` (int[]) - Array of integers to sort
- **Output:** int[] - Sorted array in ascending order

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[64, 34, 25, 12, 22, 11, 90]` | `[11, 12, 22, 25, 34, 64, 90]` |
| `[5, 2, 8, 2, 9, 1]` | `[1, 2, 2, 5, 8, 9]` |
| `[]` | `[]` |
| `[42]` | `[42]` |
| `[3, -1, 0, 5, -2]` | `[-2, -1, 0, 3, 5]` |

### Edge Cases Covered
- **Empty array:** Returns empty array
- **Single element:** Returns the same single-element array
- **Already sorted:** Returns the same sorted array
- **Reverse sorted:** Correctly sorts to ascending order
- **Duplicates:** Handles arrays with duplicate values correctly
- **Negative numbers:** Correctly sorts arrays containing negative integers
