# Bubble Sort

## Problem

Implement the bubble sort algorithm to sort an array of integers in ascending order.

Bubble sort is a simple comparison-based sorting algorithm that works by repeatedly stepping through the list, comparing adjacent elements, and swapping them if they are in the wrong order. The pass through the list is repeated until the list is sorted.

### Algorithm Steps:
1. Compare adjacent elements. If the first is greater than the second, swap them.
2. Do this for each pair of adjacent elements, from the beginning to the end of the array.
3. After each complete pass, the largest unsorted element "bubbles up" to its correct position at the end.
4. Repeat the process until no more swaps are needed (the array is sorted).

This is a classic sorting algorithm that, while not efficient for large datasets (O(n²) time complexity), is excellent for learning basic algorithm concepts like nested loops and swapping.

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

### Edge Cases Explained

1. **Empty array `[]`**: Should return an empty array - tests handling of zero-length input
2. **Single element `[42]`**: Should return the same array - tests minimal input
3. **All duplicates `[3, 3, 3]`**: Should return the same array - tests stability with identical elements
4. **Reverse sorted `[5, 4, 3, 2, 1]`**: Worst-case scenario for bubble sort, requires maximum swaps
5. **Negative numbers `[-5, 3, -10, 0, 8]`**: Tests that negative integers are sorted correctly
