# Kth Largest Element

## Problem

Given an unsorted array of integers `nums` and an integer `k`, return the **kth largest element** in the array.

The kth largest element is the element that would appear at position k if the array were sorted in descending order. For example:
- k = 1 means the largest element
- k = 2 means the second largest element
- k = 3 means the third largest element

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/kth_largest_element.xs`):** Contains the solution logic

## Function Signature

- **Input:**
  - `nums` (int[]): Array of integers
  - `k` (int): The position of the element to find (1 = largest, 2 = second largest, etc.)
- **Output:**
  - (int): The kth largest element in the array

## Algorithm

This implementation uses the **bubble sort** algorithm to sort the array in descending order, then returns the element at index `k-1` (0-indexed).

Time Complexity: O(n²) due to bubble sort
Space Complexity: O(1) auxiliary space (excluding the input copy)

## Test Cases

| Input | k | Expected Output |
|-------|---|-----------------|
| `[3, 2, 1, 5, 6, 4]` | 2 | 5 |
| `[3, 2, 3, 1, 2, 4, 5, 5, 6]` | 4 | 4 |
| `[1]` | 1 | 1 |
| `[10, 9, 8, 7, 6, 5, 4, 3, 2, 1]` | 1 | 10 |
| `[1, 2, 3, 4, 5]` | 5 | 1 |

### Test Case Descriptions

1. **Basic case:** `[3, 2, 1, 5, 6, 4]`, k=2 → 5 (sorted: [6, 5, 4, 3, 2, 1], 2nd largest is 5)
2. **Duplicates case:** `[3, 2, 3, 1, 2, 4, 5, 5, 6]`, k=4 → 4 (sorted: [6, 5, 5, 4, 3, 3, 2, 2, 1], 4th largest is 4)
3. **Single element:** `[1]`, k=1 → 1 (edge case - only element)
4. **Already sorted descending:** `[10, 9, 8, 7, 6, 5, 4, 3, 2, 1]`, k=1 → 10 (boundary - largest is first)
5. **k = array length:** `[1, 2, 3, 4, 5]`, k=5 → 1 (boundary - smallest element)

## Error Handling

The function validates that `k` is within the valid range (1 to array length). If `k` is out of bounds, a precondition error is raised with a descriptive message.
