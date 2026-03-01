# Minesweeper

## Problem
You are given a 2D char matrix representing the game board of **Minesweeper**. The board contains the following characters:

- `'M'` - An unrevealed mine
- `'E'` - An unrevealed empty square
- `'B'` - A revealed blank square with no adjacent mines
- `'1'` to `'8'` - A revealed square with the indicated number of adjacent mines
- `'X'` - A revealed mine

When a user clicks on a square, the following rules apply:

1. **If a mine (`'M'`) is clicked**: Change it to `'X'` (game over - the mine is revealed)
2. **If an empty square (`'E'`) with no adjacent mines is clicked**: Change it to `'B'` and recursively reveal all adjacent empty squares
3. **If an empty square (`'E'`) with adjacent mines is clicked**: Change it to a digit character (`'1'` to `'8'`) representing the number of adjacent mines

**Note:** Only unrevealed squares (`'E'` or `'M'`) can be clicked. If a revealed square is clicked, the board remains unchanged.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs (clicks on an empty cell)
- **Function (`function/minesweeper.xs`):** Contains the solution logic with a helper function for recursive revealing

## Function Signature
- **Input:** 
  - `board` (json): 2D array representing the minesweeper board
  - `click` (json): Array `[row, col]` representing the click position
- **Output:** 
  - Updated board (json): The board state after processing the click

## Test Cases

| Board | Click | Expected Output |
|-------|-------|-----------------|
| `[["E","E","E"],["E","E","M"],["E","E","E"]]` | `[0,0]` | `[["B","1","E"],["B","1","M"],["B","1","E"]]` |
| `[["E","E","E"],["E","E","M"],["E","E","E"]]` | `[1,2]` | `[["E","E","E"],["E","E","X"],["E","E","E"]]` |
| `[["B","1","E"],["B","1","M"],["B","1","E"]]` | `[0,0]` | `[["B","1","E"],["B","1","M"],["B","1","E"]]` (already revealed) |
| `[["E"]]` | `[0,0]` | `[["B"]]` (single empty cell) |
| `[["M"]]` | `[0,0]` | `[["X"]]` (single mine - game over) |

### Explanation of Test Cases:

1. **Basic empty cell click:** Clicking an empty cell with no adjacent mines reveals a large area
2. **Mine click:** Clicking a mine reveals it as 'X' (game over)
3. **Already revealed cell:** Clicking a revealed cell leaves the board unchanged
4. **Single empty cell:** Edge case with 1x1 board containing empty cell
5. **Single mine:** Edge case with 1x1 board containing mine
