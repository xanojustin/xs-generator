# Insertion Sort

## Problem
Implement the **Insertion Sort** algorithm to sort an array of integers in ascending order.

Insertion Sort builds the final sorted array one item at a time. It works by iterating through the array and inserting each element into its proper position within the already-sorted portion of the array (to the left of the current element). This algorithm is efficient for small data sets and is often used in practice for small arrays or as part of hybrid sorting algorithms like Timsort.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/insertion_sort.xs`):** Contains the insertion sort algorithm implementation

## Function Signature
- **Input:** `int[] numbers` — An array of integers to be sorted
- **Output:** `int[]` — A new array containing the same integers sorted in ascending order

## Algorithm
1. Start from the second element (index 1) - the first element is considered already sorted
2. Store the current element as the "key" to be inserted
3. Compare the key with elements in the sorted portion (to its left), moving from right to left
4. Shift elements greater than the key one position to the right
5. Insert the key in its correct sorted position
6. Repeat for all remaining elements

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[64, 34, 25, 12, 22, 11, 90]` | `[11, 12, 22, 25, 34, 64, 90]` |
| `[5, 4, 3, 2, 1]` | `[1, 2, 3, 4, 5]` (reverse sorted array) |
| `[1, 2, 3, 4, 5]` | `[1, 2, 3, 4, 5]` (already sorted) |
| `[]` | `[]` (empty array) |
| `[42]` | `[42]` (single element) |
| `[3, -1, 0, 5, -2]` | `[-2, -1, 0, 3, 5]` (array with negative numbers) |

## Complexity
- **Time Complexity:** O(n²) in worst and average cases, O(n) in best case (already sorted)
- **Space Complexity:** O(n) for the copy of the input array (O(1) auxiliary space if sorting in-place)

## Notes
- The implementation creates a copy of the input array to avoid mutating the original
- Insertion sort is adaptive - it performs well on nearly-sorted data (O(n) time)
- It's a stable sort - equal elements maintain their relative order
- Often used for small arrays (typically n < 10-20) in hybrid algorithms
