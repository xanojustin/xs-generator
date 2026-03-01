# Longest Increasing Subarray

## Problem
Given an array of integers, find the length of the longest **strictly increasing contiguous subarray**.

A subarray is a contiguous sequence of elements from the original array. A strictly increasing subarray means each element is greater than the previous element.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/longest_increasing_subarray.xs`):** Contains the solution logic

## Function Signature
- **Input:** `int[] nums` - An array of integers to analyze
- **Output:** `int` - The length of the longest strictly increasing contiguous subarray

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[1, 3, 5, 4, 7]` | `3` | `[1, 3, 5]` is the longest increasing subarray |
| `[2, 2, 2, 2]` | `1` | All elements are equal, so each element alone counts as length 1 |
| `[1, 2, 3, 4, 5]` | `5` | Entire array is strictly increasing |
| `[5, 4, 3, 2, 1]` | `1` | Array is strictly decreasing, so each element alone |
| `[]` | `0` | Empty array has no increasing subarray |
| `[42]` | `1` | Single element array |

## Algorithm
The solution uses a single pass through the array with O(n) time complexity:
1. Track the current increasing streak length
2. When an element is greater than the previous, increment the current streak
3. When not increasing, reset the current streak to 1
4. Keep track of the maximum streak seen

## Edge Cases Handled
- Empty array returns 0
- Single element array returns 1
- All equal elements returns 1
- Strictly decreasing array returns 1
