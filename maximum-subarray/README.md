# Maximum Subarray (Kadane's Algorithm)

## Problem
Given an array of integers (which may contain both positive and negative numbers), find the contiguous subarray (containing at least one number) which has the largest sum and return its sum.

A subarray is a contiguous part of an array.

### Example
- Input: `[-2, 1, -3, 4, -1, 2, 1, -5, 4]`
- Output: `6`
- Explanation: The subarray `[4, -1, 2, 1]` has the largest sum of `6`.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/maximum-subarray.xs`):** Contains the Kadane's algorithm implementation

## Function Signature
- **Input:** `int[] nums` - An array of integers (can be positive, negative, or zero)
- **Output:** `int` - The maximum sum of any contiguous subarray (returns 0 for empty arrays)

## Algorithm
This implementation uses **Kadane's Algorithm**, which solves the problem in O(n) time:

1. Initialize `max_current` and `max_global` to the first element
2. Iterate through the array starting from the second element
3. For each element, decide whether to:
   - Start a new subarray at the current element, or
   - Extend the existing subarray by adding the current element
4. Update the global maximum if the current maximum is better

## Time & Space Complexity
- **Time Complexity:** O(n) - single pass through the array
- **Space Complexity:** O(1) - only uses a few variables

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[-2, 1, -3, 4, -1, 2, 1, -5, 4]` | `6` | Subarray `[4, -1, 2, 1]` sums to 6 |
| `[1]` | `1` | Single element array |
| `[5, 4, -1, 7, 8]` | `23` | Entire array sums to 23 |
| `[-1, -2, -3, -4]` | `-1` | All negative, pick the least negative |
| `[]` | `0` | Empty array edge case |
| `[2, 3, -2, 4]` | `7` | Subarray `[2, 3, -2, 4]` sums to 7 |
| `[-2, -3, 4, -1, -2, 1, 5, -3]` | `7` | Subarray `[4, -1, -2, 1, 5]` sums to 7 |

## Why Kadane's Algorithm?

The brute force approach would check all possible subarrays (O(n²) subarrays), resulting in O(n³) or O(n²) time depending on implementation. Kadane's algorithm achieves O(n) by recognizing that:

- If the sum of the subarray ending at position `i-1` is negative, starting fresh at position `i` will always yield a better (or equal) sum than extending.
- This greedy choice allows us to compute the optimal solution in a single pass.
