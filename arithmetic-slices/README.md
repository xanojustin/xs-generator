# Arithmetic Slices

## Problem

An integer array is called arithmetic if it consists of **at least three elements** and if the difference between any two consecutive elements is the same.

For example, `[1, 3, 5, 7, 9]`, `[7, 7, 7, 7]`, and `[3, -1, -5, -9]` are arithmetic sequences.

Given an integer array `nums`, return *the number of arithmetic **subarrays** of* `nums`.

A **subarray** is a contiguous subsequence of the array.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/arithmetic_slices.xs`):** Contains the solution logic

## Function Signature

- **Input:** `int[] nums` - An array of integers
- **Output:** `int` - The number of arithmetic subarrays (slices) in `nums`

## Examples

**Example 1:**
- Input: `nums = [1, 2, 3, 4]`
- Output: `3`
- Explanation: We have 3 arithmetic slices in `[1, 2, 3, 4]`:
  - `[1, 2, 3]`
  - `[2, 3, 4]`
  - `[1, 2, 3, 4]` itself

**Example 2:**
- Input: `nums = [1]`
- Output: Error (array must have at least 3 elements)

## Test Cases

| Input | Expected Output | Description |
|-------|-----------------|-------------|
| `[1, 2, 3, 4]` | `3` | Basic case with 3 arithmetic slices |
| `[1, 2, 3, 4, 5]` | `6` | Larger array, more slices |
| `[7, 7, 7, 7]` | `3` | All same elements (diff = 0) |
| `[1, 2, 3, 8, 9, 10]` | `2` | Two separate arithmetic sequences |
| `[1, 3, 5, 7, 9]` | `6` | Standard arithmetic progression |
| `[1, 2, 4]` | `0` | No arithmetic slice (diff 1 vs diff 2) |

## Algorithm Explanation

This solution uses **dynamic programming** with O(n) time complexity:

1. **Iterate through the array** starting from index 2 (need at least 3 elements)
2. **Track consecutive differences:** Check if `nums[i] - nums[i-1] == nums[i-1] - nums[i-2]`
3. **Maintain a streak counter:** When an arithmetic sequence continues, increment the streak
4. **Accumulate results:** Add the current streak to the total count
   - The streak value represents how many new slices end at the current position
   - For example, at position 3 in `[1,2,3,4]`, streak=2 gives us `[2,3,4]` and `[1,2,3,4]`

**Time Complexity:** O(n) where n is the length of the array
**Space Complexity:** O(1) - only uses constant extra space
