# Bubble Sort

## Problem
Implement the **Bubble Sort** algorithm to sort an array of integers in ascending order.

Bubble Sort works by repeatedly stepping through the list, comparing adjacent elements, and swapping them if they are in the wrong order. The pass through the list is repeated until the list is sorted. The algorithm gets its name because smaller elements "bubble" to the top (beginning) of the list while larger elements sink to the bottom.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/bubble_sort.xs`):** Contains the bubble sort algorithm implementation

## Function Signature
- **Input:** `int[] numbers` — An array of integers to be sorted
- **Output:** `int[]` — A new array containing the same integers sorted in ascending order

## Algorithm
1. Compare adjacent elements in the array
2. If the left element is greater than the right element, swap them
3. Continue through the entire array
4. Repeat the process until a complete pass makes no swaps (array is sorted)
5. After each pass, the largest unsorted element is in its final position

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[64, 34, 25, 12, 22, 11, 90]` | `[11, 12, 22, 25, 34, 64, 90]` |
| `[5, 4, 3, 2, 1]` | `[1, 2, 3, 4, 5]` (reverse sorted array) |
| `[1, 2, 3, 4, 5]` | `[1, 2, 3, 4, 5]` (already sorted) |
| `[]` | `[]` (empty array) |
| `[42]` | `[42]` (single element) |

## Complexity
- **Time Complexity:** O(n²) in worst and average cases, O(n) in best case (already sorted)
- **Space Complexity:** O(n) for the copy of the input array

## Notes
- The implementation creates a copy of the input array to avoid mutating the original
- Includes an optimization to stop early if the array becomes sorted before all passes complete
