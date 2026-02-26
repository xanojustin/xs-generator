# Selection Sort

## Problem
Implement the **Selection Sort** algorithm to sort an array of integers in ascending order.

Selection sort works by:
1. Dividing the array into a sorted portion (initially empty) and an unsorted portion (initially the whole array)
2. Finding the minimum element in the unsorted portion
3. Swapping it with the first element of the unsorted portion
4. Expanding the sorted portion by one element
5. Repeating until the entire array is sorted

## Structure
- **Run Job (`run.xs`):** Calls the selection sort function with multiple test inputs
- **Function (`function/selection_sort.xs`):** Contains the selection sort implementation

## Function Signature
- **Input:** 
  - `numbers` (int[]): An array of integers to be sorted
- **Output:** 
  - Returns an int[] containing the sorted array in ascending order

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[64, 25, 12, 22, 11]` | `[11, 12, 22, 25, 64]` |
| `[1, 2, 3, 4, 5]` | `[1, 2, 3, 4, 5]` |
| `[5, 4, 3, 2, 1]` | `[1, 2, 3, 4, 5]` |
| `[]` | `[]` |
| `[42]` | `[42]` |
| `[3, 1, 4, 1, 5, 9, 2, 6]` | `[1, 1, 2, 3, 4, 5, 6, 9]` |

## Complexity Analysis

- **Time Complexity:** O(n²) - We have two nested loops, each iterating up to n times
- **Space Complexity:** O(1) - In-place sorting with only a few extra variables

## Algorithm Steps

1. Iterate through the array from index 0 to n-2
2. For each position i, assume it's the minimum
3. Scan the remaining unsorted portion (i+1 to n-1) to find the actual minimum
4. If a smaller element is found, update the minimum index
5. After scanning, swap the element at position i with the minimum element
6. Continue until the array is fully sorted
