# Rotting Oranges

## Problem

You are given an `m x n` grid where each cell can have one of three values:

- `0` representing an empty cell
- `1` representing a fresh orange
- `2` representing a rotten orange

Every minute, any fresh orange that is **4-directionally adjacent** (up, down, left, right) to a rotten orange becomes rotten.

Return the minimum number of minutes that must elapse until no cell has a fresh orange. If this is impossible, return `-1`.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/rotting-oranges.xs`):** Contains the solution logic using BFS

## Function Signature

- **Input:** 
  - `grid` (int[][]): 2D grid where 0=empty, 1=fresh orange, 2=rotten orange
- **Output:** 
  - `int`: Minimum minutes until all oranges rot, or -1 if impossible

## Approach

This problem uses **Breadth-First Search (BFS)**:

1. Find all initially rotten oranges and add them to a queue with time = 0
2. Count the total number of fresh oranges
3. Process the queue level by level (BFS)
4. For each rotten orange, rot all adjacent fresh oranges and add them to the queue
5. Track the maximum time elapsed
6. If fresh oranges remain after BFS completes, return -1

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[[2,1,1],[1,1,0],[0,1,1]]` | 4 |
| `[[2,1,1],[0,1,1],[1,0,1]]` | -1 |
| `[[0,2]]` | 0 |
| `[[1,2]]` | 1 |

### Test Case Descriptions

1. **Basic case:** 4 minutes needed for all oranges to rot
2. **Impossible case:** Bottom-left orange cannot be reached (isolated by empty cells)
3. **No fresh oranges:** All oranges start rotten, return 0
4. **Single fresh adjacent:** One minute to rot the adjacent fresh orange

## Complexity Analysis

- **Time Complexity:** O(m × n) - each cell is processed at most once
- **Space Complexity:** O(m × n) - for the BFS queue and state tracking
