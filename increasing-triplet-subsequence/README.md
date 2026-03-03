# Increasing Triplet Subsequence

## Problem

Given an integer array `nums`, return `true` if there exists a triple of indices `(i, j, k)` such that `i < j < k` and `nums[i] < nums[j] < nums[k]`. If no such indices exist, return `false`.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/increasing_triplet_subsequence.xs`):** Contains the solution logic

## Function Signature

- **Input:** 
  - `nums` (int[]): An array of integers to check for increasing triplet subsequence
  
- **Output:** 
  - Returns `true` if there exists indices i < j < k such that nums[i] < nums[j] < nums[k]
  - Returns `false` otherwise

## Algorithm

This solution uses an O(n) time complexity and O(1) space complexity approach:

1. Maintain two variables:
   - `first`: The smallest number seen so far
   - `second`: The smallest number that has a smaller number before it

2. Iterate through the array:
   - If current number ≤ first, update first
   - Else if current number ≤ second, update second  
   - Else (current > second > first), we found a triplet!

The key insight is that we're always tracking the smallest possible values for our first and second elements, which maximizes our chances of finding a valid third element.

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[1, 2, 3, 4, 5]` | `true` | Any triplet works, e.g., (0, 1, 2) → 1 < 2 < 3 |
| `[5, 4, 3, 2, 1]` | `false` | Array is strictly decreasing, no triplet possible |
| `[2, 1, 5, 0, 4, 6]` | `true` | Triplet (3, 4, 5) → 0 < 4 < 6 |
| `[1, 1, 1, 1]` | `false` | All elements equal, need strictly increasing |
| `[1, 2]` | `false` | Edge case: less than 3 elements |
| `[20, 100, 10, 12, 5, 13]` | `true` | Triplet (2, 3, 5) → 10 < 12 < 13 |

## Constraints

- 1 ≤ nums.length ≤ 5 × 10^5
- -2^31 ≤ nums[i] ≤ 2^31 - 1

## Follow-up

This implementation achieves:
- **Time Complexity:** O(n) - single pass through the array
- **Space Complexity:** O(1) - only uses two variables regardless of input size
