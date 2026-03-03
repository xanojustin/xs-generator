# Design Leaderboard

## Problem
Design a leaderboard system that supports the following operations:

1. **`add_score(player_id, score)`** - Add a score to a player's total. If the player doesn't exist, create them with this score.
2. **`top(K)`** - Return the sum of scores of the top K players.
3. **`reset(player_id)`** - Reset a player's score to 0.

The leaderboard should efficiently track player scores and allow retrieving the top performers.

## Structure
- **Run Job (`run.xs`):** Calls the leaderboard function with test inputs
- **Function (`function/leaderboard.xs`):** Contains the leaderboard implementation with all three operations

## Function Signature
- **Input:**
  - `operation` (text): The operation to perform - "add_score", "top", or "reset"
  - `player_id` (int): Player ID (required for add_score and reset operations)
  - `score` (int): Score to add (required for add_score operation)
  - `k` (int): Number of top players to sum (required for top operation)
  - `initial_scores` (json): Optional initial scores object for state persistence
- **Output:**
  - (json): Object containing:
    - `result`: Operation-specific result data
    - `scores`: Updated scores object for state persistence

## Test Cases

### Add Score Operations
| Input | Expected Output |
|-------|-----------------|
| `operation: "add_score", player_id: 1, score: 100` | Player 1 has score 100 |
| `operation: "add_score", player_id: 1, score: 50` | Player 1 now has score 150 (added) |
| `operation: "add_score", player_id: 2, score: 200` | Player 2 has score 200 |

### Top K Operation
| Setup | Input | Expected Output |
|-------|-------|-----------------|
| Players: {1: 100, 2: 200, 3: 150} | `operation: "top", k: 2` | `sum: 350` (200 + 150) |
| Players: {1: 50, 2: 30} | `operation: "top", k: 5` | `sum: 80` (only 2 players exist) |

### Reset Operation
| Setup | Input | Expected Output |
|-------|-------|-----------------|
| Player 1 has score 100 | `operation: "reset", player_id: 1` | Player 1 score is now 0 |

## Algorithm
The implementation uses an **object/dictionary** to store player scores:
- Player IDs are stored as string keys (converted via `to_text`)
- Scores are stored as integer values
- For `top(K)`, scores are extracted, sorted in descending order, and the top K are summed

**Time Complexity:**
- `add_score`: O(1) - hash map insertion/update
- `top(K)`: O(n log n) - sorting all scores, where n is number of players
- `reset`: O(1) - hash map update

**Space Complexity:** O(n) - storing all player scores

## Example Usage Flow
```
1. add_score(1, 100)  → Player 1: 100
2. add_score(2, 200)  → Player 2: 200
3. add_score(1, 50)   → Player 1: 150
4. top(2)             → Returns 350 (200 + 150)
5. reset(1)           → Player 1: 0
6. top(2)             → Returns 200 (only player 2 has score)
```
