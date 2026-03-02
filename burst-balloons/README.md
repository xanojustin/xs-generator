# Burst Balloons

## Problem

You are given `n` balloons, indexed from `0` to `n - 1`. Each balloon is painted with a number on it represented by an array `nums`. You are asked to burst all the balloons.

If you burst the `i`th balloon, you will get `nums[i - 1] * nums[i] * nums[i + 1]` coins. If `i - 1` or `i + 1` goes out of bounds of the array, then treat it as if there is a balloon with a `1` painted on it.

Return the **maximum** coins you can collect by bursting the balloons wisely.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/burst_balloons.xs`):** Contains the dynamic programming solution

## Function Signature

- **Input:** `int[] nums` — Array of balloon values (each value ≥ 0)
- **Output:** `int` — Maximum coins obtainable by bursting balloons optimally

## Approach

This problem uses **dynamic programming** with the following insight:

Instead of thinking about which balloon to burst first, think about which balloon to burst **last** in a given range. If we know the optimal solution for bursting all balloons in range `(i, k)` and `(k, j)`, and we burst balloon `k` last, the coins gained would be:
- `dp[i][k]` (coins from left range)
- `dp[k][j]` (coins from right range)  
- `nums[i] * nums[k] * nums[j]` (bursting balloon k last)

We use virtual balloons with value `1` at both ends to handle boundary conditions.

**Time Complexity:** O(n³)  
**Space Complexity:** O(n²)

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[3, 1, 5, 8]` | `167` | Burst 1, then 5, then 3, then 8: 3×1×5 + 3×5×8 + 1×3×8 + 1×8×1 = 167 |
| `[]` | `0` | No balloons to burst |
| `[1]` | `1` | Single balloon: 1×1×1 = 1 |
| `[1, 5]` | `10` | Burst 5 first (1×5×1), then 1 (1×1×1): 5 + 1 = 6, OR burst 1 first (1×1×5), then 5 (1×5×1): 5 + 5 = 10 |

## Example Walkthrough

For `nums = [3, 1, 5, 8]`:
1. Add virtual balloons: `[1, 3, 1, 5, 8, 1]`
2. The DP table computes optimal subproblems:
   - Bursting balloon 1 (index 2) when neighbors are 3 and 5: 3×1×5 = 15
   - Bursting balloon 5 (index 3) when neighbors are 1 and 8: 1×5×8 = 40
   - And so on...
3. Final result `dp[0][5] = 167`
