# Design Tic-Tac-Toe

## Problem
Design a Tic-Tac-Toe game that supports:
- Initializing an n x n board
- Making moves by players (1 or 2)
- Validating moves (bounds checking, cell occupancy)
- Detecting wins (horizontal, vertical, diagonal, anti-diagonal)
- Tracking current player and game state

The game should return the winner (player 1 or 2) if the move results in a win, 0 if no winner yet, and handle invalid moves with appropriate errors.

## Structure
- **Run Job (`run.xs`):** Calls the test runner function to execute all test cases
- **Function (`function/tic_tac_toe.xs`):** Contains the Tic-Tac-Toe game logic with init and move operations
- **Function (`function/tic_tac_toe_test_runner.xs`):** Runs comprehensive test cases

## Function Signature

### tic_tac_toe function
- **Input:**
  - `operation` (text): Either "init" or "move"
  - `n` (int, optional): Board size for init operation
  - `player` (int, optional): Player making the move (1 or 2)
  - `row` (int, optional): Row index for move
  - `col` (int, optional): Column index for move
  - `board` (int[], optional): Current board state (flattened n x n array)
  - `current_player` (int, optional): Current player's turn
  - `n_val` (int, optional): Board size for move operations
- **Output:** Object containing:
  - `board` (int[]): Updated board state
  - `n` (int): Board size
  - `current_player` (int): Next player's turn (1 or 2)
  - `winner` (int): 0 if no winner, 1 or 2 if someone won
  - `game_over` (bool): True if the game has ended

## Test Cases

| Operation | Input | Expected Output |
|-----------|-------|-----------------|
| Init 3x3 | n=3 | Empty board, player 1 starts |
| Move | player=1, row=0, col=0 | Board updated, player 2's turn |
| Horizontal win | player=1 at (0,0), (0,1), (0,2) | Player 1 wins |
| Vertical win | player=1 at (0,0), (1,0), (2,0) | Player 1 wins |
| Diagonal win | player=1 at (0,0), (1,1), (2,2) | Player 1 wins |
| Anti-diagonal win | player=1 at (0,2), (1,1), (2,0) | Player 1 wins |
| Invalid move (bounds) | row=-1 or row>=n | Error: position out of bounds |
| Invalid move (occupied) | Move to filled cell | Error: cell already occupied |

## Key Design Decisions

1. **Flattened Board Representation:** Since XanoScript doesn't support 2D arrays (`int[][]`), the board is stored as a flattened 1D array where cell (row, col) maps to index `row * n + col`.

2. **Single Function with Operations:** Rather than separate functions for init and move, a single function uses an `operation` parameter to determine behavior.

3. **Response via Variable:** The function sets a `$result` variable within the stack and returns it at the function level, since `response` statements cannot be inside conditional blocks.

4. **Win Detection:** After each move, the function checks:
   - The row the move was made in
   - The column the move was made in
   - The main diagonal (if move is on it: row == col)
   - The anti-diagonal (if move is on it: row + col == n - 1)