# Game of Life

## Problem

Conway's Game of Life is a cellular automaton devised by mathematician John Conway. The game is played on a 2D grid of cells, where each cell is either **alive (1)** or **dead (0)**.

Each cell interacts with its eight neighbors (horizontal, vertical, diagonal) using these four rules:

1. **Underpopulation:** Any live cell with fewer than two live neighbors dies
2. **Survival:** Any live cell with two or three live neighbors lives on
3. **Overpopulation:** Any live cell with more than three live neighbors dies  
4. **Reproduction:** Any dead cell with exactly three live neighbors becomes alive

Given the current state of an `m x n` board, compute the next state based on these rules.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/game_of_life.xs`):** Contains the solution logic

## Function Signature

- **Input:** 
  - `board` (json): A 2D array of integers where 1 represents a live cell and 0 represents a dead cell
  
- **Output:** 
  - (json): A 2D array representing the next state of the board

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[[0,1,0],[0,1,0],[0,1,0]]` (vertical blinker) | `[[0,0,0],[1,1,1],[0,0,0]]` (horizontal blinker) |
| `[[1,1],[1,1]]` (2x2 block) | `[[1,1],[1,1]]` (stable - no change) |
| `[]` (empty board) | `[]` (empty) |
| `[[0,0,0],[0,0,0],[0,0,0]]` (all dead) | `[[0,0,0],[0,0,0],[0,0,0]]` (all dead) |
| `[[1,1,1],[1,1,1],[1,1,1]]` (full board) | `[[1,0,1],[0,0,0],[1,0,1]]` (corners survive) |

## Complexity Analysis

- **Time Complexity:** O(m × n) - We visit each cell once and check all 8 neighbors
- **Space Complexity:** O(m × n) - We create a new board for the next state

## Notes

The "blinker" pattern (test case 1) is one of the simplest oscillators in Game of Life, alternating between vertical and horizontal orientations every generation.
