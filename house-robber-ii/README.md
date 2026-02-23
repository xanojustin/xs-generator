# House Robber II

## Problem
You are a professional robber planning to rob houses along a street. Each house has a certain amount of money stashed. The only constraint stopping you from robbing each of them is that adjacent houses have security systems connected, and **if two adjacent houses are robbed on the same night, the security system will automatically alert the police**.

Additionally, the houses are arranged in a **circle**. This means the first house is a neighbor of the last one. Given an integer array `houses` representing the amount of money in each house, return the maximum amount of money you can rob tonight **without alerting the police**.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/house_robber_ii.xs`):** Contains the solution logic using dynamic programming

## Function Signature
- **Input:** `int[] houses` - An array of non-negative integers where `houses[i]` represents the money in the i-th house
- **Output:** `int` - The maximum amount of money that can be robbed without triggering the alarm

## Algorithm
Since the houses are arranged in a circle, we cannot rob both the first and last house. We solve this by:
1. Handling edge cases (0, 1, or 2 houses)
2. Computing the max for houses `[0..n-2]` (exclude last house)
3. Computing the max for houses `[1..n-1]` (exclude first house)
4. Returning the maximum of the two scenarios

Each linear scenario uses dynamic programming where:
- `dp[i] = max(dp[i-1], dp[i-2] + houses[i])`

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[2, 3, 2]` | `3` | Rob house 1 (money = 3), cannot rob houses 0 and 2 (adjacent to each other in circle) |
| `[1, 2, 3, 1]` | `4` | Rob houses 0 and 2 (1 + 3 = 4) |
| `[2, 7, 9, 3, 1]` | `11` | Rob houses 0, 2, and 4 (2 + 9 + 1 = 12)... wait, houses 0 and 4 are adjacent! Rob houses 1 and 3 (7 + 3 = 10) or houses 2 and 4 (9 + 1 = 10) or houses 0 and 2 (2 + 9 = 11). Max is 11. |
| `[]` | `0` | Edge case: no houses |
| `[5]` | `5` | Edge case: single house |
| `[1, 2]` | `2` | Edge case: two houses, pick the max |
