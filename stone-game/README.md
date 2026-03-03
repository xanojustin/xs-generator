# Stone Game

## Problem
Alex and Lee play a game with piles of stones arranged in a row. There are an even number of piles, and each pile has a positive integer number of stones. The total number of stones is odd, so there are no ties.

Alex and Lee take turns, with Alex starting first. Each turn, a player takes the entire pile of stones from either the beginning or the end of the row. This continues until there are no more piles left, at which point the person with the most stones wins.

Assuming Alex and Lee play optimally, return `true` if and only if Alex wins the game.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/stone_game.xs`):** Contains the solution logic using dynamic programming

## Function Signature
- **Input:** 
  - `piles` (int[]): Array of positive integers representing stone piles. The array has even length and the sum of all piles is odd (guaranteeing no ties).
- **Output:** 
  - `bool`: `true` if Alex (first player) wins with optimal play, `false` otherwise.

## Approach
This solution uses dynamic programming with a 2D DP table where `dp[i][j]` represents the maximum score difference (current player score minus opponent score) when considering piles from index `i` to `j`.

**Recurrence relation:**
```
dp[i][j] = max(piles[i] - dp[i+1][j], piles[j] - dp[i][j-1])
```

The first player wins if `dp[0][n-1] > 0`.

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[5, 3, 4, 5]` | `true` | Alex can take first 5, then responds optimally to win |
| `[3, 7, 2, 3]` | `true` | Alex can win by taking from either end |
| `[1, 2, 3, 4, 5, 6, 7, 8]` | `true` | First player advantage with even piles |
| `[5]` | `true` | Single pile - first player takes it |
| `[]` | `false` | No piles - no winner |

## Complexity
- **Time Complexity:** O(n²) where n is the number of piles
- **Space Complexity:** O(n²) for the DP table
