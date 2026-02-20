# N-Queens

## Problem
The N-Queens puzzle is the problem of placing N chess queens on an N×N chessboard so that no two queens threaten each other. Thus, a solution requires that no two queens share the same row, column, or diagonal.

Given an integer `n`, return all distinct solutions to the n-queens puzzle.

Each solution contains a distinct board configuration where:
- `'Q'` represents a queen
- `'.'` represents an empty square

## Structure
- **Run Job (`run.xs`):** Calls the test function to run all test cases
- **Function (`function/n_queens.xs`):** Main solver function - converts board state to formatted strings
- **Function (`function/n_queens_backtrack.xs`):** Backtracking algorithm that places queens row by row
- **Function (`function/n_queens_is_safe.xs`):** Helper to check if a queen placement is valid
- **Function (`function/n_queens_test.xs`):** Test wrapper that runs multiple test cases

## Function Signature

### n_queens
- **Input:** `int n` - The board size (n×n) and number of queens to place
- **Output:** `text[][]` - Array of solutions, where each solution is an array of strings representing the board

### n_queens_backtrack
- **Input:** 
  - `int row` - Current row to place queen
  - `int n` - Board size
  - `int[] board` - Current board state (queen columns for each row)
- **Output:** `int[][]` - Array of valid board configurations

### n_queens_is_safe
- **Input:**
  - `int row` - Row to check
  - `int col` - Column to check
  - `int[] board` - Current board state
- **Output:** `bool` - True if placement is safe, false otherwise

## Algorithm
The solution uses **backtracking**:
1. Place queens one by one in different rows, starting from the top row
2. For each row, try placing the queen in each column
3. Check if the placement is safe (no conflicts with previously placed queens)
4. If safe, place the queen and recursively try to place queens in subsequent rows
5. If we reach the bottom row successfully, we found a valid solution
6. If no column is safe in the current row, backtrack and try a different position in the previous row

## Test Cases

| Input | Expected Output | Description |
|-------|-----------------|-------------|
| n = 1 | 1 solution: `["Q"]` | Single queen on 1×1 board |
| n = 4 | 2 solutions | Classic 4×4 case |
| n = 0 | 0 solutions | Edge case: invalid input |
| n = 2 | 0 solutions | No valid placement possible |
| n = 3 | 0 solutions | No valid placement possible |

### n = 4 Solutions
```
Solution 1:        Solution 2:
[".Q..",          ["..Q.",
 "...Q",           "Q...",
 "Q...",           "...Q",
 "..Q."]           ".Q.."]
```

## Complexity
- **Time:** O(N!) - In the worst case, we explore all possible placements
- **Space:** O(N) - For the recursion stack and board state (excluding output storage)
