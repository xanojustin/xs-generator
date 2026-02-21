# House Robber

## Problem
You are a professional robber planning to rob houses along a street. Each house has a certain amount of money stashed. The only constraint stopping you from robbing each of them is that adjacent houses have security systems connected, and if two adjacent houses are robbed on the same night, the police will be called.

Given an integer array `nums` representing the amount of money in each house, return the maximum amount of money you can rob tonight without alerting the police.

## Structure
- **Run Job (`run.xs`):** Calls the test function which runs multiple test cases
- **Function (`function/house-robber.xs`):** Contains the dynamic programming solution
- **Test Function (`function/house-robber-test.xs`):** Runs test cases and validates the solution

## Function Signature
- **Input:** `int[] nums` - An array where nums[i] represents the money in house i
- **Output:** `int` - The maximum amount of money that can be robbed without robbing adjacent houses

## Algorithm
This solution uses dynamic programming with O(1) space complexity:
- `dp[i]` = maximum money that can be robbed from houses 0 to i
- Recurrence: `dp[i] = max(dp[i-1], dp[i-2] + nums[i])`
- Either skip the current house (take dp[i-1]), or rob it (take dp[i-2] + nums[i])

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[1, 2, 3, 1]` | `4` | Rob house 0 (1) + house 2 (3) = 4 |
| `[2, 7, 9, 3, 1]` | `12` | Rob house 0 (2) + house 2 (9) + house 4 (1) = 12 |
| `[]` | `0` | Empty street, no money to rob |
| `[5]` | `5` | Single house, rob it |
| `[5, 5, 5, 5, 5]` | `15` | Rob houses 0, 2, 4 = 15 |

## Complexity Analysis
- **Time Complexity:** O(n) where n is the number of houses
- **Space Complexity:** O(1) - only uses two variables to track previous results
