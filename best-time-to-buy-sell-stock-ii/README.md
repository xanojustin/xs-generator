# Best Time to Buy and Sell Stock II

## Problem
You are given an array `prices` where `prices[i]` is the price of a given stock on the `i`th day.

On each day, you may decide to buy and/or sell stock. You can only hold **at most one** share of the stock at any time. However, you may buy it then immediately sell it on the **same day**.

Find and return the **maximum profit** you can achieve with unlimited transactions.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/max_profit_ii.xs`):** Contains the solution logic

## Function Signature
- **Input:** `prices` - An array of integers representing stock prices on consecutive days
- **Output:** Integer representing the maximum profit achievable with unlimited buy/sell transactions

## Approach
The key insight is that we can capture **all upward price movements** by summing every positive daily difference:
- If price goes up from day i to day i+1, we buy at day i and sell at day i+1
- This greedy approach works because there's no transaction fee or cooldown period
- Time Complexity: O(n) - single pass through the array
- Space Complexity: O(1) - only using a few variables

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[7, 1, 5, 3, 6, 4]` | `7` | Buy at 1, sell at 5 (profit 4), buy at 3, sell at 6 (profit 3). Total: 7 |
| `[1, 2, 3, 4, 5]` | `4` | Buy at 1, sell at 5. Or capture each daily increase: (2-1)+(3-2)+(4-3)+(5-4) = 4 |
| `[7, 6, 4, 3, 1]` | `0` | Prices always decrease, no profitable transaction possible |
| `[]` | `0` | Empty array - no transactions possible |
| `[5]` | `0` | Single day - need at least 2 days to trade |
| `[1, 2]` | `1` | Simple case - buy at 1, sell at 2 |
| `[5, 5, 5, 5]` | `0` | Flat prices - no profit possible |

## Edge Cases Handled
- Empty price array returns 0
- Single price returns 0 (need at least 2 days)
- Strictly decreasing prices returns 0 (no profitable trades)
- Flat prices (no change) returns 0
