# Minimum Cost For Tickets

## Problem

You have planned some train traveling one year in advance. The days of the year that you will travel are given as an integer array `days`. Each day is an integer from 1 to 365.

Train tickets are sold in three different ways:
- A **1-day pass** is sold for `costs[0]` dollars
- A **7-day pass** is sold for `costs[1]` dollars
- A **30-day pass** is sold for `costs[2]` dollars

The passes allow that many days of consecutive travel. For example, if you get a 7-day pass on day 2, then you can travel for 7 days: day 2, 3, 4, 5, 6, 7, and 8.

Return the minimum number of dollars you need to travel every day in the given list of days.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/minimum_cost_for_tickets.xs`):** Contains the dynamic programming solution

## Function Signature

- **Input:**
  - `days` (int[]): Array of travel days (1-365, sorted in increasing order)
  - `costs` (int[]): Array of 3 costs `[1-day pass cost, 7-day pass cost, 30-day pass cost]`
  
- **Output:** 
  - Minimum cost (int) to travel on all given days

## Approach

This problem uses **Dynamic Programming**:

1. Let `dp[i]` = minimum cost to cover all travel days up to day `i`
2. For each day from 1 to the last travel day:
   - If it's not a travel day: `dp[i] = dp[i-1]` (no additional cost)
   - If it is a travel day, consider three options:
     - Buy 1-day pass: `dp[i-1] + costs[0]`
     - Buy 7-day pass: `dp[max(0, i-7)] + costs[1]`
     - Buy 30-day pass: `dp[max(0, i-30)] + costs[2]`
   - Take the minimum of these three options

3. Return `dp[last_day]`

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `days: [1,4,6,7,8,20], costs: [2,7,15]` | `11` | Buy 1-day pass for day 1 (2), 7-day pass for days 4-8 (7), 1-day pass for day 20 (2) = 11 |
| `days: [1,2,3,4,5,6,7,8,9,10,30,31], costs: [2,7,15]` | `17` | Buy 7-day passes for days 1-7 and 8-10 (7+7=14), 7-day pass for days 30-31 (covers both for 7) = wait, actually: 7-day for days 1-7 (7), 1-day for day 8 (2), 1-day for day 9 (2), 1-day for day 10 (2), 7-day for days 30-31 (7) = 20... let me recalculate: optimal is 7-day for days 1-10 overlap... actually optimal is 7+7=14 for days 1-10, and 7 for days 30-31 = 21... or 30-day pass for 15 covering all = 15. So answer is 15. |
| `days: [], costs: [2,7,15]` | `0` | No travel days = no cost |
| `days: [1], costs: [2,7,15]` | `2` | Single day - cheapest is 1-day pass |
| `days: [1,2,3,4,5,6,7], costs: [2,7,15]` | `7` | 7 consecutive days - 7-day pass is cheaper than seven 1-day passes (14) |

**Note:** The second test case in the run job uses the first example which returns 11.
