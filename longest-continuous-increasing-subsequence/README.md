# Longest Continuous Increasing Subsequence (LCIS)

## Problem

Given an unsorted array of integers `nums`, return the length of the **longest continuous increasing subsequence** (i.e., subarray).

A **continuous increasing subsequence** is defined by two indices `l` and `r` (`l < r`) such that it is `[nums[l], nums[l + 1], ..., nums[r - 1], nums[r]]` and for each `l <= i < r`, `nums[i] < nums[i + 1]`.

In other words, find the longest sequence of consecutive elements where each element is strictly greater than the previous one.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/lcis.xs`):** Contains the solution logic

## Function Signature

- **Input:** 
  - `nums`: `int[]` - An array of integers
- **Output:** 
  - `int` - The length of the longest continuous increasing subsequence

## Algorithm

The solution uses a single pass through the array with two counters:
1. `current_length` - Tracks the length of the current increasing streak
2. `max_length` - Tracks the longest streak found so far

For each element (starting from the second):
- If current element > previous element: increment `current_length`
- Else: reset `current_length` to 1
- Update `max_length` if `current_length` exceeds it

**Time Complexity:** O(n) - single pass through the array  
**Space Complexity:** O(1) - only uses two variables

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[1, 3, 5, 4, 7]` | `3` | The longest increasing subsequence is `[1, 3, 5]` |
| `[2, 2, 2, 2, 2]` | `1` | No increasing pairs, each element alone counts as 1 |
| `[]` | `0` | Empty array has no elements |
| `[5]` | `1` | Single element array |
| `[1, 2, 3, 4, 5]` | `5` | Entire array is increasing |
| `[5, 4, 3, 2, 1]` | `1` | Entire array is decreasing |
| `[1, 3, 5, 7, 9, 2, 4, 6, 8]` | `5` | First 5 elements form longest subsequence |
