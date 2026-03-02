# Paint House

## Problem
You are given a row of `n` houses, where each house can be painted with one of `k` colors. The cost of painting each house with a certain color is different. You have to paint all the houses such that **no two adjacent houses have the same color**.

Given a 2D array `costs` where `costs[i][j]` represents the cost to paint house `i` with color `j`, return the **minimum cost** to paint all houses.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/paint_house.xs`):** Contains the dynamic programming solution

## Function Signature
- **Input:** `int[][] costs` - A 2D array where `costs[i][j]` is the cost to paint house `i` with color `j`
- **Output:** `int` - The minimum cost to paint all houses with no two adjacent houses sharing the same color

## Approach
This problem uses **dynamic programming**:
- `dp[i][j]` = minimum cost to paint houses 0..i where house i is painted color j
- `dp[i][j] = costs[i][j] + min(dp[i-1][k])` for all k ≠ j
- The answer is `min(dp[n-1][j])` for all colors j

Space optimization: We only need the previous row's DP values, so we use O(k) space instead of O(n*k).

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[[17, 2, 17], [16, 16, 5], [14, 3, 19]]` | `10` | Paint house 0 blue (2), house 1 green (5), house 2 blue (3) = 2+5+3 = 10 |
| `[[7, 6, 2]]` | `2` | Single house - pick minimum cost color |
| `[]` | `0` | No houses to paint |
| `[[1, 5, 3], [2, 9, 4]]` | `5` | Paint house 0 red (1), house 1 blue (4) = 5 or house 0 green (3), house 1 red (2) = 5 |

## Constraints
- `n == costs.length` (number of houses)
- `k == costs[i].length` (number of colors, same for all houses)
- `1 <= n <= 100` (though solution handles empty array)
- `1 <= k <= 20` (number of colors)
- `1 <= costs[i][j] <= 1000`
