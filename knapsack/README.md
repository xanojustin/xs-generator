# Knapsack (0/1 Knapsack Problem)

## Problem

Given `n` items, each with a weight and a value, and a knapsack with a maximum weight capacity, determine the maximum total value that can be obtained by selecting items to put in the knapsack. Each item can either be taken once (1) or not taken at all (0) - hence the name "0/1 Knapsack".

This is a classic dynamic programming problem where we build up a solution by considering each item and determining the optimal value for each possible capacity from 0 to the maximum.

## Structure

- **Run Job (`run.xs`):** Calls the knapsack function with test inputs
- **Function (`function/knapsack.xs`):** Contains the dynamic programming solution

## Function Signature

- **Input:**
  - `weights` (int[]): Array of item weights
  - `values` (int[]): Array of item values (same length as weights)
  - `capacity` (int): Maximum weight capacity of the knapsack
- **Output:** (int) Maximum total value achievable without exceeding capacity

## Algorithm

This solution uses dynamic programming with space optimization:

1. Create a DP array where `dp[j]` represents the maximum value achievable with capacity `j`
2. For each item, update the DP array from right to left (to avoid using the same item twice)
3. If taking the current item gives a better value than not taking it, update `dp[c]`
4. Return `dp[capacity]` as the answer

**Time Complexity:** O(n × capacity) where n is the number of items
**Space Complexity:** O(capacity)

## Test Cases

| Weights | Values | Capacity | Expected Output | Explanation |
|---------|--------|----------|-----------------|-------------|
| [2, 3, 4, 5] | [3, 4, 5, 6] | 5 | 7 | Take items with weight 2 (value 3) and 3 (value 4) = 7 |
| [1, 2, 3] | [6, 10, 12] | 5 | 22 | Take items with weight 2 (value 10) and 3 (value 12) = 22 |
| [] | [] | 10 | 0 | Edge case: no items available |
| [5, 6] | [10, 12] | 4 | 0 | Edge case: all items too heavy |
| [2, 2, 2] | [3, 4, 5] | 4 | 9 | Take two lightest items: 3 + 5 = 8... wait, 4+5=9 (weights 2+2) |

**Note:** The default test case in `run.xs` uses weights `[2, 3, 4, 5]`, values `[3, 4, 5, 6]`, and capacity `5`, which should return `7`.
