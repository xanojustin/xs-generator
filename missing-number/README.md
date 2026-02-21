# Missing Number

## Problem
Given an array `nums` containing `n` distinct numbers in the range `[0, n]`, return the only number in the range that is missing from the array.

The solution uses the mathematical sum formula: the sum of numbers from 0 to n is `n * (n + 1) / 2`. By subtracting the actual sum of the array from the expected sum, we find the missing number in O(n) time with O(1) space complexity.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/find_missing_number.xs`):** Contains the solution logic using the sum formula approach

## Function Signature
- **Input:** `int[] nums` - An array of distinct integers from 0 to n with exactly one number missing
- **Output:** `int` - The missing number in the sequence

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[3, 0, 1]` | `2` | n=3, expected sum = 6, actual sum = 4, missing = 2 |
| `[0, 1]` | `2` | n=2, expected sum = 3, actual sum = 1, missing = 2 |
| `[9,6,4,2,3,5,7,0,1]` | `8` | n=9, expected sum = 45, actual sum = 37, missing = 8 |
| `[0]` | `1` | Edge case: single element, n=1, expected sum = 1, actual sum = 0 |
| `[1]` | `0` | Edge case: 0 is missing, n=1, expected sum = 1, actual sum = 1 |

## Algorithm Explanation

1. Calculate `n` as the length of the input array
2. Compute the expected sum using the formula: `expected_sum = n * (n + 1) / 2`
3. Compute the actual sum by iterating through the array
4. The missing number is: `expected_sum - actual_sum`

**Time Complexity:** O(n) - single pass through the array
**Space Complexity:** O(1) - only using a few variables
