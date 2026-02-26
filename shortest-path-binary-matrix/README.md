# Shortest Path in Binary Matrix

## Problem

Given an `n x n` binary matrix `grid`, find the length of the shortest clear path from the top-left cell `(0, 0)` to the bottom-right cell `(n-1, n-1)`.

A **clear path** is a path from the top-left cell to the bottom-right cell such that:
- All visited cells are clear (value `0`)
- All adjacent cells used in the path are 8-directionally connected (i.e., they are different and share an edge or a corner)
- The length of a clear path is the number of visited cells

If no such path exists, return `-1`.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/shortest_path.xs`):** Contains the BFS solution logic

## Function Signature

- **Input:** `grid` (json) — A 2D array of 0s and 1s where:
  - `0` represents a clear path cell
  - `1` represents an obstacle
  
- **Output:** (int) — The length of the shortest clear path from top-left to bottom-right, or `-1` if no path exists

## Algorithm

This solution uses **Breadth-First Search (BFS)**:
1. Start from the top-left cell `(0, 0)` with distance `1`
2. Use a queue to track cells to visit along with their distance from start
3. For each cell, explore all 8 possible directions (including diagonals)
4. Mark cells as visited to avoid cycles
5. Return immediately when reaching the destination
6. If queue is exhausted without finding destination, return `-1`

BFS guarantees the shortest path in an unweighted grid because it explores all cells at distance `d` before moving to distance `d+1`.

## Test Cases

| Input Grid | Expected Output | Description |
|------------|-----------------|-------------|
| `[[0]]` | `1` | Single cell - start is destination |
| `[[1]]` | `-1` | Single cell blocked |
| `[[0,1],[1,0]]` | `-1` | No path (diagonal only, but both cells are blocked) |
| `[[0,0],[0,0]]` | `2` | Simple 2x2 grid - direct diagonal path |
| `[[0,1,0],[0,1,0],[0,0,0]]` | `4` | Must go around obstacle |
| 5x5 example from run.xs | `9` | Complex path with obstacles |

### Detailed Test Case: 5x5 Grid
```
[0, 1, 0, 0, 0]
[0, 1, 0, 1, 0]
[0, 0, 0, 1, 0]
[1, 1, 0, 1, 0]
[0, 0, 0, 0, 0]
```
**Expected:** `9` (path length including start and end cells)

**Path visualization:**
```
[S, 1, ., ., .]
[↓, 1, ., 1, .]
[↓, →, →, 1, .]
[1, 1, ↓, 1, .]
[., ., →, →, E]
```
Where S=start, E=end, arrows show path direction
