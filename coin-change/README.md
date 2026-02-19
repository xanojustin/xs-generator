# Coin Change

## Problem

Given an array of coin denominations and a target amount, find the **minimum number of coins** needed to make up that amount.

You may assume that you have an infinite number of each kind of coin. If the amount cannot be made up by any combination of the coins, return `-1`.

This classic dynamic programming problem tests:
- Dynamic programming concepts
- Array manipulation
- Edge case handling
- Optimization techniques

## Function Signature

- **Input:** 
  - `coins` (`int[]`) - Array of coin denominations (positive integers)
  - `amount` (`int`) - The target amount to make (must be >= 0)
- **Output:** `int` - The minimum number of coins needed to make the amount, or -1 if impossible

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `coins: [1, 2, 5], amount: 11` | `3` (5 + 5 + 1) |
| `coins: [2], amount: 3` | `-1` (cannot make 3 with only 2s) |
| `coins: [1], amount: 0` | `0` (no coins needed for amount 0) |
| `coins: [1], amount: 1` | `1` (single coin) |
| `coins: [1], amount: 2` | `2` (1 + 1) |
| `coins: [2, 5, 10], amount: 27` | `4` (10 + 10 + 5 + 2) |
| `coins: [186, 419, 83, 408], amount: 6249` | `20` (larger case) |
| `coins: [], amount: 1` | `-1` (no coins available) |

### Edge Cases Explained

1. **Amount = 0**: Returns 0 immediately since no coins are needed
2. **Single coin type**: Tests basic arithmetic and divisibility
3. **Impossible amount**: Returns -1 when amount cannot be formed (e.g., making 3 with only 2s)
4. **Greedy doesn't work**: The US coin system is canonical (greedy works), but this algorithm handles non-canonical systems too
5. **Large amount**: Tests performance with bigger numbers
6. **Empty coins array**: Returns -1 since no coins are available to make any amount
