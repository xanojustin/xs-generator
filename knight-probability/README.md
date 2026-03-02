# Knight Probability

## Problem
On an `n x n` chessboard, a knight starts at position `(row, column)` and makes `k` random moves. Each move, the knight chooses uniformly at random from its 8 possible L-shaped moves. Calculate the probability that the knight remains on the board after making exactly `k` moves.

A knight has 8 possible moves from any position:
- (r+2, c+1), (r+2, c-1)
- (r-2, c+1), (r-2, c-1)  
- (r+1, c+2), (r+1, c-2)
- (r-1, c+2), (r-1, c-2)

## Structure
- **Run Job (`run.xs`):** Entry point that calls the test harness function
- **Function (`function/knight_probability.xs`):** Contains the solution logic using dynamic programming
- **Test Harness (`function/knight_probability_tests.xs`):** Runs multiple test cases and returns results

## Function Signature
- **Input:**
  - `n` (int): Size of the chessboard (n x n)
  - `k` (int): Number of moves the knight makes
  - `row` (int): Starting row position (0-indexed)
  - `column` (int): Starting column position (0-indexed)
- **Output:** 
  - `probability` (decimal): Probability that knight remains on board after k moves (0.0 to 1.0)

## Algorithm
This solution uses dynamic programming:
- `dp[step][r][c]` = probability of being at position (r,c) after `step` moves
- For each step, calculate the probability of reaching each cell from all 8 possible previous positions
- Each valid move contributes 1/8 of the probability from the source cell
- Time Complexity: O(k × n² × 8) = O(k × n²)
- Space Complexity: O(n²) using two 2D arrays (current and next step)

## Test Cases

| Test | n | k | row | column | Expected Output | Explanation |
|------|---|---|-----|--------|-----------------|-------------|
| 1 | 3 | 2 | 0 | 0 | 0.0625 | From corner, after 2 moves, probability is 1/16 |
| 2 | 3 | 1 | 1 | 1 | 0.0 | From center of 3x3, all 8 knight moves go off board |
| 3 | 1 | 0 | 0 | 0 | 1.0 | No moves made, knight stays at starting position |
| 4 | 3 | 1 | 0 | 0 | 0.25 | From corner, only 2 of 8 moves stay on board (2/8 = 0.25) |

### Edge Cases Covered
- **Zero moves (k=0):** Knight never moves, probability is always 1.0
- **Center of small board:** All knight moves may go off board
- **Corner position:** Limited valid moves (only 2 stay on 3x3 board)

## Running the Exercise

To run this exercise in Xano:
1. The `run.xs` file defines the entry point job
2. It calls `knight_probability_tests` which runs all test cases
3. The test harness calls the solution function `knight_probability` with different inputs
4. Results are returned as a JSON object with named test results
