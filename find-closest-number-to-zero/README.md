# Find Closest Number to Zero

## Problem
Given an integer array `nums` of size `n`, return the number with the value closest to 0.

If there are multiple answers, return the number with the **largest** value (i.e., prefer positive numbers in case of ties).

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/find_closest_number_to_zero.xs`):** Contains the solution logic

## Function Signature
- **Input:**
  - `nums` (`int[]`): An array of integers (non-empty)
- **Output:** 
  - (`int`): The number closest to zero, with positive numbers winning ties

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[-4, -2, 1, 4, 8]` | `1` | 1 is closest to 0 |
| `[2, -1, 1]` | `1` | Both -1 and 1 are distance 1, 1 wins (positive) |
| `[5, -5]` | `5` | Equal distance, positive wins |
| `[-1]` | `-1` | Single element, return it |
| `[10, 20, 30, -5]` | `-5` | -5 is closest to 0 |
| `[0, 5, 10]` | `0` | 0 is exactly at zero |
| `[-10, -20, -3, -5]` | `-3` | -3 is closest to 0 (all negative) |

## Edge Cases Handled
- Empty array: Returns input error
- Single element: Returns that element
- All negative numbers: Returns the one closest to zero
- Contains zero: Returns 0
- Ties between positive and negative: Positive number wins
