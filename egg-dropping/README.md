# Egg Dropping

## Problem
You are given `k` eggs and a building with `n` floors. You need to find the critical floor (the highest floor from which an egg won't break when dropped). If an egg breaks when dropped from floor `x`, it will also break from any floor above `x`. If an egg survives a drop from floor `x`, it will also survive from any floor below `x`.

Find the **minimum number of attempts** needed in the worst case to determine the critical floor exactly.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/egg_dropping.xs`):** Contains the dynamic programming solution

## Function Signature
- **Input:** 
  - `k` (int): Number of eggs available (minimum 1)
  - `n` (int): Number of floors in the building (minimum 1)
- **Output:** (int) Minimum number of attempts needed in worst case

## Algorithm
This solution uses an optimized dynamic programming approach:
- Instead of the traditional DP[k][n] table, we use `dp[m]` = max floors we can check with `m` moves and current eggs
- We iterate attempts until we can cover `n` floors
- Time Complexity: O(k * attempts) where attempts is the answer
- Space Complexity: O(k)

## Test Cases
| k | n | Expected Output | Explanation |
|---|---|-----------------|-------------|
| 1 | 10 | 10 | With 1 egg, must check linearly (worst case: floor 10) |
| 2 | 10 | 4 | Optimal strategy finds answer in 4 attempts |
| 2 | 100 | 14 | Classic egg dropping puzzle answer |
| 3 | 14 | 4 | With more eggs, fewer attempts needed |
| 2 | 1 | 1 | Single floor needs just 1 attempt |
| 2 | 0 | 0 | Edge case: no floors |

## Notes
- This is a classic dynamic programming interview problem
- The optimized solution avoids the O(k*n^2) complexity of naive DP
