# Word Search

## Problem
Given a 2D grid of letters and a word, determine if the word exists in the grid.

The word can be constructed from letters of sequentially adjacent cells, where "adjacent" cells are those horizontally or vertically neighboring. The same letter cell may not be used more than once.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/word_search.xs`):** Contains the solution logic using iterative DFS with backtracking

## Function Signature
- **Input:**
  - `grid` (json): A 2D array of single characters representing the letter board
  - `word` (text): The word to search for in the grid
- **Output:**
  - `bool`: `true` if the word exists in the grid following the rules, `false` otherwise

## Algorithm
The solution uses an iterative Depth-First Search (DFS) approach with backtracking:

1. Try starting from each cell in the grid that matches the first letter of the word
2. From each starting position, explore all 4 adjacent directions (up, down, left, right)
3. Track visited cells to ensure each cell is used at most once
4. If we match all characters of the word, return `true`
5. If no path works from any starting position, return `false`

## Test Cases

| Grid | Word | Expected Output |
|------|------|-----------------|
| `[["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]]` | `"ABCCED"` | `true` |
| `[["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]]` | `"SEE"` | `true` |
| `[["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]]` | `"ABCB"` | `false` (same cell used twice) |
| `[["A"]]` | `"A"` | `true` (single cell, single char) |
| `[["A"]]` | `"B"` | `false` (char not in grid) |
| `[]` | `"ABC"` | `false` (empty grid) |
