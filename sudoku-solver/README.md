# Sudoku Solver

## Problem
Write a function that solves a 9x9 Sudoku puzzle using backtracking. The puzzle is represented as a 9x9 grid where empty cells are marked with 0. The solver must fill in all empty cells following Sudoku rules:
- Each row must contain digits 1-9 without repetition
- Each column must contain digits 1-9 without repetition  
- Each of the nine 3x3 sub-grids must contain digits 1-9 without repetition

## Structure
- **Run Job (`run.xs`):** Calls the solution function with a test Sudoku puzzle
- **Main Function (`function/sudoku_solver.xs`):** Entry point that invokes the backtracking solver
- **Solver Helper (`function/solve_helper.xs`):** Recursive backtracking algorithm
- **Find Empty (`function/find_empty.xs`):** Helper to locate the next empty cell (0)
- **Is Valid (`function/is_valid.xs`):** Helper to check if a number placement is valid

## Function Signature
- **Input:** `board` (json) - A 9x9 array of arrays representing the Sudoku grid, where 0 indicates an empty cell
- **Output:** An object containing:
  - `solved` (bool) - Whether a solution was found
  - `board` (json) - The solved Sudoku grid (or original if unsolvable)

## Test Cases
| Input | Expected Output |
|-------|-----------------|
| Standard puzzle (see run.xs) | solved=true with complete valid grid |
| Already solved valid puzzle | solved=true with same grid |
| Empty grid (all zeros) | solved=true with a valid solution |
| Invalid puzzle (conflicting numbers) | solved=false |

### Example Input
```json
[
  [5, 3, 0, 0, 7, 0, 0, 0, 0],
  [6, 0, 0, 1, 9, 5, 0, 0, 0],
  [0, 9, 8, 0, 0, 0, 0, 6, 0],
  [8, 0, 0, 0, 6, 0, 0, 0, 3],
  [4, 0, 0, 8, 0, 3, 0, 0, 1],
  [7, 0, 0, 0, 2, 0, 0, 0, 6],
  [0, 6, 0, 0, 0, 0, 2, 8, 0],
  [0, 0, 0, 4, 1, 9, 0, 0, 5],
  [0, 0, 0, 0, 8, 0, 0, 7, 9]
]
```

### Example Output
```json
{
  "solved": true,
  "board": [
    [5, 3, 4, 6, 7, 8, 9, 1, 2],
    [6, 7, 2, 1, 9, 5, 3, 4, 8],
    [1, 9, 8, 3, 4, 2, 5, 6, 7],
    [8, 5, 9, 7, 6, 1, 4, 2, 3],
    [4, 2, 6, 8, 5, 3, 7, 9, 1],
    [7, 1, 3, 9, 2, 4, 8, 5, 6],
    [9, 6, 1, 5, 3, 7, 2, 8, 4],
    [2, 8, 7, 4, 1, 9, 6, 3, 5],
    [3, 4, 5, 2, 8, 6, 1, 7, 9]
  ]
}
```

## Algorithm
This implementation uses a recursive backtracking approach:
1. Find the next empty cell (containing 0)
2. If no empty cells exist, the puzzle is solved
3. Try digits 1-9 in the empty cell
4. For each digit, check if placement is valid (row, column, 3x3 box constraints)
5. If valid, place the digit and recursively attempt to solve the rest
6. If recursion succeeds, return the solution
7. If recursion fails, backtrack (reset the cell to 0) and try the next digit
8. If no digit works, return unsolvable