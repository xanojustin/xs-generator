# Island Perimeter

## Problem

Given a 2D grid representing a map where:
- `1` represents land
- `0` represents water

Calculate the perimeter of the island. The island is formed by connecting adjacent lands horizontally or vertically (not diagonally). The grid is completely surrounded by water, and there is exactly one island (or none).

The perimeter is the total number of edges of land cells that are either:
- Adjacent to water
- On the boundary of the grid

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/island_perimeter.xs`):** Contains the solution logic

## Function Signature

- **Input:** 
  - `grid` (int[][]) - A 2D array of integers where 1 = land, 0 = water
- **Output:** 
  - `perimeter` (int) - The total perimeter of the island

## Algorithm

For each land cell (value = 1):
1. Start with 4 sides (each cell is a square)
2. Subtract 1 for each adjacent land cell (top, bottom, left, right)
3. Sum up all remaining sides

This works because:
- Each land-water boundary contributes 1 to the perimeter
- Each land-land boundary removes 1 from the perimeter (shared edge)

## Test Cases

| Input | Expected Output | Description |
|-------|-----------------|-------------|
| `[[1]]` | `4` | Single land cell has 4 exposed sides |
| `[[1,1]]` | `6` | Two adjacent cells share 1 edge: 4+4-2 = 6 |
| `[[1,0],[0,0]]` | `4` | Single cell in larger grid |
| `[[1,1,1],[1,0,1],[1,1,1]]` | `16` | Donut shape - hollow center |
| `[[0,0,0],[0,1,0],[0,0,0]]` | `4` | Single cell surrounded by water |
| `[]` | `0` | Empty grid |
| `[[0,0],[0,0]]` | `0` | No land |

## Example Walkthrough

For grid `[[1,1]]`:
- Cell (0,0) is land: starts with 4 sides
  - No top, no left neighbors
  - Right neighbor is land: -1
  - No bottom neighbor
  - Sides contributing to perimeter: 3
- Cell (0,1) is land: starts with 4 sides
  - No top, no right neighbors
  - Left neighbor is land: -1
  - No bottom neighbor
  - Sides contributing to perimeter: 3
- Total perimeter: 3 + 3 = 6
