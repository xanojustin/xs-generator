# Max Area of Island

## Problem
Given a 2D binary grid where `1` represents land and `0` represents water, find the maximum area of an island.

An **island** is a group of `1`s (land) connected **horizontally or vertically** (not diagonally). The **area** of an island is the number of cells with value `1` in the island.

Return the maximum area of an island in the grid. If there is no island, return `0`.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/max_area_of_island.xs`):** Contains the solution logic using iterative DFS

## Function Signature
- **Input:**
  - `grid` (json): A 2D array of integers where `1` represents land and `0` represents water
- **Output:**
  - Returns an `int` representing the maximum area of an island found in the grid

## Algorithm
The solution uses an iterative DFS (Depth-First Search) approach:
1. Iterate through each cell in the grid
2. When an unvisited land cell (`1`) is found, perform DFS to explore the entire island
3. During DFS, count all connected land cells (4-directional: up, down, left, right)
4. Track the maximum area found across all islands
5. Return the maximum area (or 0 if no islands exist)

## Test Cases

| Input Grid | Expected Output | Description |
|------------|-----------------|-------------|
| `[[0,0,1,0,0,0,0,1,0,0,0,0,0],[0,0,0,0,0,0,0,1,1,1,0,0,0],[0,1,1,0,1,0,0,0,0,0,0,0,0],[0,1,0,0,1,1,0,0,1,0,1,0,0],[0,1,0,0,1,1,0,0,1,1,1,0,0],[0,0,0,0,0,0,0,0,0,0,1,0,0],[0,0,0,0,0,0,0,1,1,1,0,0,0],[0,0,0,0,0,0,0,1,1,0,0,0,0]]` | `6` | Classic example with max area of 6 |
| `[[1,1,1],[1,1,1],[1,1,1]]` | `9` | Single large island (3x3 = 9 cells) |
| `[[0,0,0],[0,0,0]]` | `0` | All water, no islands |
| `[[1,0,1],[0,1,0],[1,0,1]]` | `1` | 5 separate single-cell islands |
| `[[1]]` | `1` | Single cell with land |
| `[[0]]` | `0` | Single cell with water |
| `[]` | `0` | Empty grid edge case |

## Complexity Analysis
- **Time Complexity:** O(m × n) where m is the number of rows and n is the number of columns. Each cell is visited at most once.
- **Space Complexity:** O(m × n) for the visited matrix and stack (in worst case for a grid filled with land).

## XanoScript Features Used
- `json` input type for 2D array handling
- Nested `while` loops for grid traversal
- `array.push` and `array.pop` for stack-based DFS
- `conditional` blocks for decision making
- Variable updates with `var.update` and `math.add`
- Object manipulation with `set` filter
