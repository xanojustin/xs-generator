# Shortest Bridge

## Problem
Given an `n x n` binary matrix `grid` where `1` represents land and `0` represents water.

An **island** is a 4-directionally connected group of `1`s not connected to any other `1`s. The grid contains exactly two islands.

Return the smallest number of `0`s that must be flipped to `1`s in order to connect the two islands.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/shortest_bridge.xs`):** Contains the solution logic

## Function Signature
- **Input:** 
  - `grid` (json): An n x n binary matrix where 1=land, 0=water
- **Output:** 
  - (int): The minimum number of 0s that must be flipped to connect the two islands

## Algorithm
1. **Find the first island** using DFS and mark all its cells as visited
2. **Start BFS** from all cells of the first island simultaneously
3. **Expand outward** layer by layer (each layer = one more 0 to flip)
4. **Return** when we reach the second island (first land cell not visited)

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[[0,1,0],[0,0,0],[0,0,1]]` | 2 |
| `[[1,1,1,1,1],[1,0,0,0,1],[1,0,1,0,1],[1,0,0,0,1],[1,1,1,1,1]]` | 1 |
| `[[1,0],[0,1]]` | 1 |
| `[[1,1],[1,1],[0,1],[1,1]]` | 1 |

### Test Case Explanations:
1. **Basic case:** Two islands at corners, need to cross 2 water cells
2. **Surrounded island:** One island surrounds another, only 1 cell gap
3. **Minimal grid:** 2x2 grid with diagonal islands
4. **Adjacent rows:** Islands are close but not connected
