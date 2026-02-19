# Maximum Subarray (Kadane's Algorithm)

## Problem

Given an integer array `nums`, find the contiguous subarray (containing at least one number) which has the largest sum and return its sum.

A **subarray** is a contiguous part of an array.

### Example
- Input: `[-2, 1, -3, 4, -1, 2, 1, -5, 4]`
- Output: `6`
- Explanation: The subarray `[4, -1, 2, 1]` has the largest sum of `6`.

## Function Signature

- **Input:** 
  - `nums` (int[]): An array of integers (can contain positive, negative, or zero values)
- **Output:** 
  - Object with `max_sum` (int): The maximum sum of any contiguous subarray

## Algorithm

This solution uses **Kadane's Algorithm**, a classic dynamic programming approach:

1. Initialize two variables:
   - `max_ending_here`: Maximum sum of subarray ending at current position
   - `max_so_far`: Global maximum sum found so far

2. Iterate through the array starting from the second element:
   - At each position, decide whether to:
     - Start a new subarray at the current element, OR
     - Extend the existing subarray by adding the current element
   - Update the global maximum if the current subarray sum is better

3. Return the global maximum

**Time Complexity:** O(n) - single pass through the array
**Space Complexity:** O(1) - only two variables used

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[-2, 1, -3, 4, -1, 2, 1, -5, 4]` | `{ "max_sum": 6 }` |
| `[1]` | `{ "max_sum": 1 }` |
| `[5, 4, -1, 7, 8]` | `{ "max_sum": 23 }` |
| `[-1, -2, -3, -4]` | `{ "max_sum": -1 }` |
| `[0, 0, 0, 0]` | `{ "max_sum": 0 }` |
| `[-2, -1]` | `{ "max_sum": -1 }` |

### Test Case Explanations

1. **Classic example:** Mix of positive and negative numbers, optimal subarray in the middle
2. **Single element:** Edge case with minimum valid input
3. **All positive:** Entire array is the maximum subarray
4. **All negative:** Must pick the least negative (largest single element)
5. **All zeros:** Special case where any single zero is valid
6. **Two negatives:** Must choose the larger (less negative) value
