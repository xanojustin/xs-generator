# Pacific Atlantic Water Flow

## Problem

Given an `m x n` matrix of non-negative integers representing the height of each unit cell in a continent, the "Pacific ocean" touches the left and top edges of the matrix and the "Atlantic ocean" touches the right and bottom edges.

Water can only flow in four directions (up, down, left, right) from a cell to another one with height equal or lower.

Find the list of grid coordinates where water can flow to both the Pacific and Atlantic ocean.

**Note:** Return the cells as objects with `row` and `col` properties. The coordinates can be returned in any order.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/pacific_atlantic_water_flow.xs`):** Contains the solution logic using DFS from ocean borders

## Function Signature

- **Input:**
  - `heights` (int[][]): An m x n matrix where each cell represents the height of that cell
  
- **Output:** 
  - Array of objects, each with `row` and `col` properties representing cells that can flow to both oceans

## Algorithm

The solution uses a **reverse flow** approach with DFS:

1. Instead of checking if water can flow from each cell to both oceans, we reverse the problem
2. Start from cells adjacent to each ocean and flow "uphill" (to cells with height >= current)
3. Mark all cells reachable from the Pacific ocean
4. Mark all cells reachable from the Atlantic ocean
5. Return cells that are marked in both sets

This approach is O(m × n) time complexity instead of O((m × n)²) for the naive approach.

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[[1,2,2,3,5],[3,2,3,4,4],[2,4,5,3,1],[6,7,1,4,5],[5,1,1,2,4]]` | `[{row:0,col:4}, {row:1,col:3}, {row:1,col:4}, {row:2,col:2}, {row:3,col:0}, {row:3,col:1}, {row:4,col:0}]` |
| `[[1]]` | `[{row:0,col:0}]` |
| `[[1,2],[4,3]]` | `[{row:0,col:1}, {row:1,col:0}, {row:1,col:1}]` |
| `[]` | `[]` |

### Test Case Explanations

1. **Standard case (5x5 matrix):** Multiple cells can reach both oceans through various paths
2. **Single cell:** The only cell touches both oceans (corner case)
3. **2x2 matrix:** Three cells can reach both oceans
4. **Empty matrix:** Edge case returns empty array
