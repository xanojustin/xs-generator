# Nim Game

## Problem

You are playing the following Nim Game with your friend:
- Initially, there are `n` stones in a pile.
- On each player's turn, they can remove 1 to 3 stones from the pile.
- The player who removes the last stone wins the game.
- Both players play optimally.

Given `n`, the number of stones in the pile, determine whether you can win the game given that you always take the first turn.

Return `true` if you can win the game, `false` otherwise.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/nim_game.xs`):** Contains the solution logic

## Function Signature

- **Input:** 
  - `n` (int): The number of stones in the pile
- **Output:** 
  - `bool`: `true` if the first player can win, `false` otherwise

## Solution Explanation

The key insight is that if the number of stones is divisible by 4, the first player **will lose** if both play optimally:

- If `n = 4`: Whatever number (1-3) the first player takes, the second player can always take enough to make the total removed in that round equal to 4. This leaves the first player with the last stone(s) in a losing position.
- If `n = 8`: The second player can always force the game into a state where 4 stones remain after their turn.

For any `n` not divisible by 4, the first player can always take enough stones (`n % 4`) to leave the opponent with a multiple of 4, putting them in the losing position.

## Test Cases

| Input (n) | Expected Output | Explanation |
|-----------|-----------------|-------------|
| 1 | true | Take 1 stone and win |
| 2 | true | Take 2 stones and win |
| 3 | true | Take 3 stones and win |
| 4 | false | Whatever you take (1-3), opponent can win |
| 7 | true | Take 3, leaving 4 (losing position for opponent) |
| 8 | false | Divisible by 4 - losing position |

## Complexity Analysis

- **Time Complexity:** O(1) - Single modulo operation
- **Space Complexity:** O(1) - Constant space used
