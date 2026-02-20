# Coin Change

## Problem
Given an array of coin denominations and a target amount, find the **minimum number of coins** needed to make up that amount. If the amount cannot be made up by any combination of the coins, return `-1`.

You may assume that you have an infinite number of each kind of coin.

### Examples
- **Example 1:** coins = [1, 2, 5], amount = 11 → **3** (11 = 5 + 5 + 1)
- **Example 2:** coins = [2], amount = 3 → **-1** (impossible to make 3 with only 2-cent coins)
- **Example 3:** coins = [1], amount = 0 → **0** (no coins needed)

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/coin_change.xs`):** Contains the dynamic programming solution

## Function Signature
- **Input:**
  - `coins` (int[]): Array of available coin denominations
  - `amount` (int): Target amount to make up
- **Output:** 
  - `int`: Minimum number of coins needed, or -1 if impossible

## Algorithm
This solution uses **dynamic programming** with bottom-up tabulation:

1. **State Definition:** `dp[i]` = minimum coins needed to make amount `i`
2. **Base Case:** `dp[0] = 0` (zero coins needed for amount 0)
3. **Recurrence:** For each amount from 1 to target:
   - Try every coin denomination
   - If coin ≤ current amount: `dp[amt] = min(dp[amt], dp[amt - coin] + 1)`
4. **Result:** `dp[amount]` if it's reachable, otherwise -1

**Time Complexity:** O(amount × n) where n = number of coin types  
**Space Complexity:** O(amount)

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| coins: [1, 2, 5], amount: 11 | 3 | 5 + 5 + 1 = 11 (3 coins) |
| coins: [2], amount: 3 | -1 | Cannot make 3 with only 2-cent coins |
| coins: [1], amount: 0 | 0 | No coins needed for amount 0 |
| coins: [1, 3, 4], amount: 6 | 2 | 3 + 3 = 6 (better than 4+1+1) |
| coins: [186, 419, 83, 408], amount: 6249 | 20 | Large amount with greedy-failing coins |
