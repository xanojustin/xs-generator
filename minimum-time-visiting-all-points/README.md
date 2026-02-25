# Minimum Time Visiting All Points

## Problem
On a 2D plane, there are n points with integer coordinates `points[i] = [xi, yi]`. Return the minimum time in seconds to visit all the points in the order given by `points`.

You can move according to these rules:
- In 1 second, you can either:
  - Move vertically by one unit
  - Move horizontally by one unit
  - Move diagonally (1 unit vertically and 1 unit horizontally)
- You must visit the points in the same order as they appear in the array.
- You are allowed to pass through points that appear later in the order.

The key insight is that diagonal movement covers both x and y distance simultaneously. So the time between two points is the **maximum** of the horizontal and vertical distances (Chebyshev distance).

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/minimum-time-visiting-all-points.xs`):** Contains the solution logic

## Function Signature
- **Input:** `points` (object[]) - An array of points where each point is an array `[x, y]` with integer coordinates
- **Output:** `int` - The minimum time in seconds to visit all points in order

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[[1, 1], [3, 4], [-1, 0]]` | 7 | (1,1)→(3,4): max(2,3)=3s, (3,4)→(-1,0): max(4,4)=4s, Total: 7s |
| `[[0, 0], [1, 1]]` | 1 | Move diagonally once |
| `[[0, 0]]` | 0 | Single point, no travel needed |
| `[]` | 0 | Empty array, no travel needed |
| `[[3, 2], [-2, 2]]` | 5 | (3,2)→(-2,2): max(5,0)=5s |

## Algorithm Explanation

For each pair of consecutive points:
1. Calculate the horizontal distance: `|x2 - x1|`
2. Calculate the vertical distance: `|y2 - y1|`
3. The time needed is `max(horizontal_distance, vertical_distance)`

**Why max?** Because:
- Diagonal moves reduce both x and y distance by 1 simultaneously
- You can make `min(dx, dy)` diagonal moves
- After diagonal moves, you need `|dx - dy|` straight moves
- Total = `min(dx, dy) + |dx - dy| = max(dx, dy)`
