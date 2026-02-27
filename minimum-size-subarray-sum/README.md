# Minimum Size Subarray Sum

## Problem
Given an array of positive integers `nums` and a positive integer `target`, return the minimal length of a contiguous subarray whose sum is greater than or equal to `target`. If there is no such subarray, return `0` instead.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/min_subarray_len.xs`):** Contains the sliding window solution logic

## Function Signature
- **Input:**
  - `target` (int): The target sum that the subarray must reach or exceed
  - `nums` (int[]): Array of positive integers to search within
- **Output:** (int) The minimal length of a valid subarray, or 0 if no such subarray exists

## Algorithm
This solution uses the **sliding window (two pointers)** technique:
1. Maintain a window with `left` pointer and expand with the `right` pointer (foreach index)
2. Add each element to the running sum
3. When the sum becomes >= target, try to shrink the window from the left
4. Track the minimum window size found during the process
5. Return the minimum length, or 0 if no valid window was found

**Time Complexity:** O(n) — each element is added and removed at most once  
**Space Complexity:** O(1) — only using a few variables

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `target: 7, nums: [2, 3, 1, 2, 4, 3]` | `2` | Subarray `[4, 3]` has the minimal length of 2 with sum = 7 |
| `target: 4, nums: [1, 4, 4]` | `1` | Single element `4` meets the target |
| `target: 11, nums: [1, 1, 1, 1, 1]` | `0` | No subarray can sum to 11 |
| `target: 15, nums: [1, 2, 3, 4, 5]` | `5` | Entire array sums to 15 |
| `target: 5, nums: []` | `0` | Empty array edge case |
