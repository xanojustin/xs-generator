# Kth Smallest Element

## Problem
Given an unsorted array of integers `numbers` and an integer `k`, find the **kth smallest element** in the array.

The kth smallest element is the element that would appear at index `k-1` if the array were sorted in ascending order. This is a **1-indexed** problem (k=1 means the smallest element, k=2 means the second smallest, etc.).

### Example
- Input: `numbers = [3, 2, 1, 5, 6, 4]`, `k = 2`
- Output: `2`
- Explanation: Sorted array is `[1, 2, 3, 4, 5, 6]`, the 2nd smallest element is `2`.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/kth-smallest-element.xs`):** Contains the solution logic using bubble sort

## Function Signature
- **Input:**
  - `numbers` (array[int]): Array of integers (may contain duplicates)
  - `k` (int): Position of the element to find (1-indexed, so k=1 is smallest)
- **Output:**
  - Returns the kth smallest element as an integer

## Algorithm
This implementation uses **bubble sort** to sort the array and then returns the element at index `k-1`:

1. Validate inputs (k > 0, k ≤ array length, array not empty)
2. Sort the array using bubble sort with early termination
3. Return the element at position `k-1` (0-indexed)

**Time Complexity:** O(n²) worst case, O(n) best case (already sorted)
**Space Complexity:** O(1) auxiliary space

## Test Cases

| Input | Expected Output | Notes |
|-------|-----------------|-------|
| `numbers: [3, 2, 1, 5, 6, 4]`, `k: 2` | `2` | Basic case - second smallest |
| `numbers: [3, 2, 3, 1, 2, 4, 5, 5, 6]`, `k: 4` | `3` | With duplicates |
| `numbers: [1]`, `k: 1` | `1` | Edge case - single element |
| `numbers: [5, 4, 3, 2, 1]`, `k: 1` | `1` | Edge case - k=1 (minimum) |
| `numbers: [5, 4, 3, 2, 1]`, `k: 5` | `5` | Edge case - k=n (maximum) |
| `numbers: [7, 10, 4, 3, 20, 15]`, `k: 3` | `7` | Boundary case - k=3 |

## Error Handling
The function validates inputs and throws `inputerror` for:
- k ≤ 0 (k must be positive)
- k > array length (k out of bounds)
- Empty array
