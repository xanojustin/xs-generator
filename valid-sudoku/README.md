# Valid Sudoku

## Problem
Determine if a `9 x 9` Sudoku board is valid. Only the filled cells need to be validated according to the following rules:

1. Each row must contain the digits `1-9` without repetition.
2. Each column must contain the digits `1-9` without repetition.
3. Each of the nine `3 x 3` sub-boxes of the grid must contain the digits `1-9` without repetition.

**Note:**
- A Sudoku board (partially filled) could be valid but is not necessarily solvable.
- Only the filled cells need to be validated according to the mentioned rules.
- Empty cells are represented by `0`.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/valid_sudoku.xs`):** Contains the solution logic

## Function Signature
- **Input:** `board` - A 9x9 2D array of integers where:
  - `1-9` represent filled cells
  - `0` represents empty cells (ignored during validation)
- **Output:** `boolean` - Returns `true` if the board is valid, `false` otherwise

## Test Cases

### Valid Board (Happy Path)
```
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
**Expected Output:** `true`

### Invalid Board - Duplicate in Row
```
[
  [5, 3, 5, 0, 7, 0, 0, 0, 0],  // 5 appears twice in row 0
  [6, 0, 0, 1, 9, 5, 0, 0, 0],
  ...
]
```
**Expected Output:** `false`

### Invalid Board - Duplicate in Column
```
[
  [5, 3, 0, 0, 7, 0, 0, 0, 0],
  [6, 0, 0, 1, 9, 5, 0, 0, 0],
  [0, 9, 8, 0, 0, 0, 0, 6, 0],
  [5, 0, 0, 0, 6, 0, 0, 0, 3],  // 5 appears in column 0 twice
  ...
]
```
**Expected Output:** `false`

### Invalid Board - Duplicate in 3x3 Box
```
[
  [5, 3, 0, 0, 7, 0, 0, 0, 0],
  [6, 5, 0, 1, 9, 5, 0, 0, 0],  // 5 appears twice in top-left box
  [0, 9, 8, 0, 0, 0, 0, 6, 0],
  ...
]
```
**Expected Output:** `false`

### Edge Case - Empty Board
```
[
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0]
]
```
**Expected Output:** `true` (empty cells are ignored)

### Edge Case - Completely Filled Valid Board
```
[
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
```
**Expected Output:** `true`
