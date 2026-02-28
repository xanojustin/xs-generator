# Coin Change II

## Problem

You are given an integer array `coins` representing coins of different denominations and an integer `amount` representing a total amount of money.

Return **the number of combinations** that make up that amount. If that amount of money cannot be made up by any combination of the coins, return `0`.

You may assume that you have an infinite number of each kind of coin.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/coin_change_ii.xs`):** Contains the dynamic programming solution

## Function Signature

- **Input:**
  - `amount` (int): The target amount of money to make
  - `coins` (int[]): Array of coin denominations (positive integers)
- **Output:**
  - `ways` (int): The number of distinct combinations that sum to `amount`

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| amount=5, coins=[1,2,5] | 4 |
| amount=3, coins=[2] | 0 |
| amount=0, coins=[1,2,3] | 1 |
| amount=10, coins=[10] | 1 |
| amount=100, coins=[1,2,5] | 541 |

### Explanation of Test Cases

1. **Basic case (amount=5, coins=[1,2,5]):** Four ways to make 5: [5], [2+2+1], [2+1+1+1], [1+1+1+1+1]
2. **No solution (amount=3, coins=[2]):** Cannot make 3 with only 2-coin coins
3. **Edge case - zero amount (amount=0, coins=[1,2,3]):** One way - use no coins (empty set)
4. **Single coin exact match (amount=10, coins=[10]):** One way - single 10-coin
5. **Larger case (amount=100, coins=[1,2,5]):** Classic DP test case with 541 combinations

## Algorithm

This solution uses **dynamic programming**:

1. Create a DP array `dp` where `dp[i]` represents the number of ways to make amount `i`
2. Initialize `dp[0] = 1` (one way to make amount 0: use no coins)
3. For each coin, iterate through all amounts from coin value to target amount
4. For each amount `j`, add `dp[j - coin]` to `dp[j]` (ways to make `j` using current coin)
5. Return `dp[amount]`

**Time Complexity:** O(amount × len(coins))  
**Space Complexity:** O(amount)
