# Target Sum

## Problem
You are given an integer array `nums` and an integer `target`.

You want to build an expression out of nums by adding one of the symbols `'+'` or `'-'` before each integer in nums and then concatenate all the integers.

For example, if `nums = [1, 2, 3]`, you can add `'+'` before 1 and `'-'` before 2 and `'+'` before 3 to get the expression `+1-2+3 = 2`.

Return the number of different expressions that you can build, which evaluates to `target`.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/target_sum.xs`):** Contains the solution logic using dynamic programming with memoization

## Function Signature
- **Input:**
  - `nums` (int[]): Array of integers to assign signs to
  - `target` (int): Target sum to achieve
- **Output:**
  - `result` (int): Number of ways to assign + or - to reach the target

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `nums: [1, 1, 1, 1, 1], target: 3` | `5` | 5 ways: -1+1+1+1+1, +1-1+1+1+1, +1+1-1+1+1, +1+1+1-1+1, +1+1+1+1-1 |
| `nums: [1], target: 1` | `1` | One way: +1 |
| `nums: [1], target: 2` | `0` | Impossible to achieve target 2 with just [1] |
| `nums: [], target: 0` | `1` | Edge case: empty array can achieve target 0 (do nothing) |
| `nums: [2, 3, 5], target: 0` | `2` | Two ways: +2+3-5=0, -2-3+5=0 |

## Algorithm
This solution uses dynamic programming with memoization:
1. Calculate the total sum of all numbers
2. Use a DP table where `dp[i][sum]` = number of ways to achieve `sum` using first `i` elements
3. For each number, we can either add or subtract it from the current sum
4. The result is `dp[n][target]` where `n` is the length of nums

Since XanoScript doesn't support negative array indices directly, we use an offset equal to the total sum to shift all indices into positive range.
