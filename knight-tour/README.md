# Knight's Tour

## Problem

The **Knight's Tour** is a classic chess puzzle and backtracking problem. Given a chessboard of size `n x n` and a starting position, find a sequence of moves for a knight such that:

1. The knight visits every square on the board exactly once
2. Each move follows the standard knight movement pattern (L-shaped: 2 squares in one direction, 1 square perpendicular)
3. The tour returns the board with each cell numbered 1 to n² representing the order of visits

A knight has 8 possible moves from any position:
```
  (-2,-1)  (-2,+1)
(-1,-2)      (-1,+2)
     K
(+1,-2)      (+1,+2)
  (+2,-1)  (+2,+1)
```

## Structure

- **Run Job (`run.xs`):** Calls the knight_tour function with test inputs
- **Function (`function/knight_tour.xs`):** Contains the backtracking solution to find a valid knight's tour

## Function Signature

- **Input:**
  - `n` (int): Board size (n x n), must be positive
  - `start_row` (int): Starting row position (0-indexed), must be in range [0, n-1]
  - `start_col` (int): Starting column position (0-indexed), must be in range [0, n-1]

- **Output:** (object)
  - `board_size` (int): The board size n
  - `start_position` (object): Contains `row` and `col` of starting position
  - `solution` (int[][] | null): 2D array where each cell contains the move number (1 to n²), or null if no tour exists
  - `found` (bool): Whether a valid tour was found

## Algorithm

The solution uses **iterative backtracking** with a stack:

1. Initialize an n×n board with all zeros (unvisited)
2. Place the knight at the starting position (marked as move 1)
3. Use a stack to track the current state: position, move number, board state, and next move to try
4. From each position, try all 8 possible knight moves
5. For each valid move (within bounds and unvisited):
   - Mark the new position with the next move number
   - Push the new state onto the stack
6. If no valid moves exist, backtrack by popping the stack
7. If we've made n² moves, we've found a valid tour

**Time Complexity:** O(8^(n²)) in the worst case (exponential)
**Space Complexity:** O(n²) for the board and stack

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `n=1, start_row=0, start_col=0` | Solution found: `[[1]]` (trivial case) |
| `n=5, start_row=0, start_col=0` | Solution found (25 moves covering entire board) |
| `n=5, start_row=2, start_col=2` | Solution found (starting from center) |
| `n=8, start_row=0, start_col=0` | Solution found (classic 8x8 chessboard) |

### Edge Cases

- **Minimum board (1x1):** Trivially solved with a single square
- **Small boards (2x2, 3x3, 4x4):** No solution exists for most starting positions
- **Invalid start position:** Returns input error
- **Large boards:** May hit iteration limits; Warnsdorff's heuristic helps but pure backtracking is slow

## Notes

- The classic 8×8 chessboard has approximately 26.5 trillion possible knight's tours
- Not all starting positions on all board sizes have valid tours
- For boards smaller than 5×5, many starting positions have no solution
- The implementation uses iterative backtracking with a safety limit to prevent infinite loops
