# Number of Islands

## Problem
Given a 2D binary grid where `1` represents land and `0` represents water, count the number of islands.

An **island** is formed by connecting adjacent lands horizontally or vertically (not diagonally). You may assume all four edges of the grid are surrounded by water.

This is a classic grid/graph traversal problem commonly used in technical interviews.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/count_islands.xs`):** Contains the solution logic using DFS (Depth-First Search)

## Function Signature
- **Input:**
  - `grid` (json): A 2D array of integers where `1` represents land and `0` represents water
- **Output:**
  - Returns an `int` representing the number of islands found in the grid

## Algorithm
The solution uses an iterative DFS (Depth-First Search) approach:
1. Iterate through each cell in the grid
2. When an unvisited land cell (`1`) is found, increment island count and perform DFS
3. DFS uses a stack to explore all connected land cells (4-directional: up, down, left, right)
4. Mark visited cells to avoid counting the same island multiple times

## Test Cases

| Input Grid | Expected Output | Description |
|------------|-----------------|-------------|
| `[[1,1,0,0,0],[1,1,0,0,0],[0,0,1,0,0],[0,0,0,1,1]]` | `3` | Basic case with 3 separate islands |
| `[[1,1,1],[1,1,1],[1,1,1]]` | `1` | Single large island (all connected) |
| `[]` | `0` | Empty grid edge case |
| `[[0,0,0],[0,0,0]]` | `0` | All water, no islands |
| `[[1,0,1],[0,1,0],[1,0,1]]` | `5` | Diagonal lands don't connect (5 separate islands) |
| `[[1]]` | `1` | Single cell with land |
| `[[0]]` | `0` | Single cell with water |

## Complexity Analysis
- **Time Complexity:** O(m × n) where m is the number of rows and n is the number of columns. Each cell is visited at most once.
- **Space Complexity:** O(m × n) for the visited matrix and recursion stack (in worst case for a grid filled with land).

## XanoScript Features Used
- `json` input type for 2D array handling
- Nested `while` loops for grid traversal
- `array.push` and `array.pop` for stack-based DFS
- `conditional` blocks for decision making
- Variable updates with `var.update`
- Object manipulation with `set` filter
