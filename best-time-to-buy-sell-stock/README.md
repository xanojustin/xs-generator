# Best Time to Buy and Sell Stock

## Problem
You are given an array `prices` where `prices[i]` is the price of a given stock on the `i`th day.

You want to maximize your profit by choosing a **single day** to buy one stock and choosing a **different day in the future** to sell that stock.

Return the maximum profit you can achieve from this transaction. If you cannot achieve any profit, return `0`.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/max_profit.xs`):** Contains the solution logic

## Function Signature
- **Input:** 
  - `prices` (int[]): Array of stock prices where prices[i] is the price on day i
- **Output:** 
  - `max_profit` (int): Maximum profit achievable from one buy/sell transaction, or 0 if no profit possible

## Approach
This solution uses a single-pass O(n) algorithm:
1. Track the minimum price seen so far (best day to buy)
2. For each subsequent day, calculate profit if sold today
3. Update max profit if current profit is better
4. Update minimum price if current price is lower

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[7, 1, 5, 3, 6, 4]` | `5` | Buy on day 2 (price=1), sell on day 5 (price=6), profit=5 |
| `[7, 6, 4, 3, 1]` | `0` | Prices always decreasing, no profit possible |
| `[1, 2]` | `1` | Single transaction, buy day 1 sell day 2 |
| `[]` | `0` | Empty array edge case |
| `[5]` | `0` | Single element edge case |
| `[3, 3, 5, 0, 0, 3, 1, 4]` | `4` | Buy at 0, sell at 4 |

## Complexity
- **Time Complexity:** O(n) - single pass through the array
- **Space Complexity:** O(1) - only storing min_price and max_profit variables
