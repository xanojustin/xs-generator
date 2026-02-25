# Dungeon Game

## Problem

The demons had captured the princess and imprisoned her in the **bottom-right corner** of a dungeon. The dungeon consists of `m x n` rooms laid out in a 2D grid. Our valiant knight was initially positioned in the **top-left room** and must fight his way through the dungeon to rescue the princess.

The knight has an initial health point represented by a positive integer. If at any point his health point drops to `0` or below, he dies immediately.

Some of the rooms are guarded by demons (represented by negative integers), so the knight loses health upon entering these rooms. Other rooms are either empty (represented by `0`) or contain magic orbs that increase the knight's health (represented by positive integers).

To reach the princess as quickly as possible, the knight moves only **rightward** or **downward** in each step.

Return the knight's **minimum initial health** so that he can rescue the princess.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/dungeon_game.xs`):** Contains the dynamic programming solution

## Function Signature

- **Input:** 
  - `dungeon` (int[][]) - A 2D grid where:
    - Negative values = damage (lose health)
    - Positive values = healing (gain health)
    - Zero = empty room
- **Output:** 
  - `int` - Minimum initial health points required (at least 1)

## Algorithm

This solution uses **dynamic programming** working backwards from the princess's position:

1. Create a DP table where `dp[i][j]` represents the minimum health needed to reach the princess starting from cell `(i, j)`
2. Fill the table from bottom-right to top-left
3. For each cell, calculate the minimum health needed:
   - Princess cell: `max(1, 1 - dungeon[m-1][n-1])`
   - Last row (can only go right): `max(1, dp[i][j+1] - dungeon[i][j])`
   - Last column (can only go down): `max(1, dp[i+1][j] - dungeon[i][j])`
   - Other cells: `max(1, min(dp[i+1][j], dp[i][j+1]) - dungeon[i][j])`
4. Return `dp[0][0]`

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[[-2,-3,3],[-5,-10,1],[10,30,-5]]` | `7` | Classic example: need 7 HP to survive path |
| `[[0]]` | `1` | Single empty room - just need 1 HP |
| `[[-5]]` | `6` | Single damage room - need 6 HP (1 after -5 = -4, so need 6 to stay at 1) |
| `[[100]]` | `1` | Single healing room - 1 HP is enough |
| `[[1,-3,3],[0,-2,0],[-3,-3,-3]]` | `3` | Multiple paths, need to choose optimal route |

## Complexity

- **Time Complexity:** O(m × n) where m and n are the dimensions of the dungeon
- **Space Complexity:** O(m × n) for the DP table
