# Brick Wall

## Problem
There is a rectangular brick wall in front of you with `n` rows of bricks. The `i-th` row has some number of bricks each of the same height (i.e., one unit) but they can be of different widths. The total width of each row is the same.

Draw a vertical line from the top to the bottom of the wall such that the line does **not** cross any bricks. If the line goes through the edge between two bricks, this does not count as crossing a brick.

Return the **minimum number of crossed bricks**.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/brick_wall.xs`):** Contains the solution logic

## Function Signature
- **Input:** 
  - `wall` (int[][]): A 2D array where each inner array represents a row of bricks. Each element is the width of a brick.
- **Output:** 
  - `result` (int): The minimum number of bricks that must be crossed when drawing a vertical line from top to bottom

## Approach
The key insight is that we want to find a vertical position where the most brick edges align. At such a position, we cross the fewest bricks.

1. For each row, calculate cumulative edge positions (where bricks end, excluding the rightmost edge)
2. Use a hash map to count how many rows have an edge at each position
3. The best position is the one with the most edges (least bricks crossed)
4. Result = total rows - maximum edge count at any position

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[[1,2,2,1], [3,1,2], [1,3,2], [2,4], [3,1,2], [1,3,1,1]]` | `2` | Drawing the line after position 4 crosses only 2 bricks (row 4 [2,4] and row 6 [1,3,1,1]) |
| `[[1], [1], [1]]` | `3` | Single brick per row, no internal edges. Must cross all 3 bricks. |
| `[[1,1], [2]]` | `1` | Line at position 1 aligns with edge in row 1, crosses only row 2 |
| `[]` | `0` | Empty wall, no bricks to cross |

## Complexity
- **Time Complexity:** O(n × m) where n is the number of rows and m is the average number of bricks per row
- **Space Complexity:** O(k) where k is the number of unique edge positions
