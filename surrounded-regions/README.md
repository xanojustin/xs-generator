# Surrounded Regions

## Problem

Given an `m x n` matrix `board` containing `'X'` and `'O'`, capture all regions that are 4-directionally surrounded by `'X'`.

A region is **captured** by flipping all `'O'`s into `'X'`s in that surrounded region.

**Note:** Any region connected to the border (edge) of the board is NOT surrounded and should NOT be captured.

### Example
```
Input:
X X X X
X O O X
X X O X
X O X X

Output:
X X X X
X X X X
X X X X
X O X X
```

Explanation: The two 'O's in the center are surrounded and get flipped. The 'O' on the bottom edge is connected to the border, so it stays.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/surrounded-regions.xs`):** Contains the main solution logic
- **Helper Function (`function/dfs-mark-safe.xs`):** DFS helper to mark border-connected regions as safe
- **Helper Function (`function/set-visited.xs`):** Utility to update the visited grid

## Function Signature

### Main Function: `surrounded-regions`
- **Input:** `board` - A 2D array of strings containing 'X' and 'O' characters
- **Output:** The modified board with all surrounded regions flipped to 'X'

### Helper Function: `dfs-mark-safe`
- **Input:** 
  - `board` - The original board
  - `visited` - Boolean grid tracking visited cells
  - `row`, `col` - Starting position for DFS
  - `rows`, `cols` - Board dimensions
- **Output:** Updated visited grid with all connected 'O's marked as safe (visited)

### Helper Function: `set-visited`
- **Input:**
  - `visited` - The visited grid
  - `row`, `col` - Position to update
  - `value` - Boolean value to set
  - `rows`, `cols` - Grid dimensions
- **Output:** New visited grid with the specified cell updated

## Algorithm

1. **Border Safety Check:** Any 'O' connected to the border cannot be surrounded. We use DFS from all border 'O's to mark connected regions as "safe" (visited).

2. **Capture Surrounded Regions:** After marking safe regions, iterate through the board and flip any 'O' that wasn't marked as safe to 'X'.

3. **Return Result:** Return the modified board.

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[['X','X','X','X'],['X','O','O','X'],['X','X','O','X'],['X','O','X','X']]` | `[['X','X','X','X'],['X','X','X','X'],['X','X','X','X'],['X','O','X','X']]` |
| `[]` (empty board) | `[]` (empty) |
| `[['X']]` (single cell) | `[['X']]` (no change) |
| `[['X','X','X'],['X','O','X'],['X','X','X']]` (surrounded O in center) | `[['X','X','X'],['X','X','X'],['X','X','X']]` |
| `[['O']]` (single O on border) | `[['O']]` (no change - on border) |
| `[['X','O','X'],['X','O','X'],['X','O','X']]` (vertical line connecting borders) | `[['X','O','X'],['X','O','X'],['X','O','X']]` (no change - connects top and bottom) |

## Complexity Analysis

- **Time Complexity:** O(m × n) where m is the number of rows and n is the number of columns. Each cell is visited at most once.
- **Space Complexity:** O(m × n) for the visited grid and recursion stack in worst case.
