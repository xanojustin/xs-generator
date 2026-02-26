# Valid Boomerang

## Problem
Given an array `points` where `points[i] = [xi, yi]` represents a point on the X-Y plane, return `true` if these points form a valid boomerang.

A **valid boomerang** is a set of three points that are all distinct and **not in a straight line** (not collinear).

Three points are collinear if they all lie on the same straight line. To check this without using division (which would cause issues with vertical lines), we use the cross product method:

- Points A, B, C are collinear if: `(By - Ay) * (Cx - Bx) == (Cy - By) * (Bx - Ax)`
- If this equation holds true, the points are in a straight line (invalid boomerang)
- If the cross product is not zero, the points form a valid boomerang

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/valid-boomerang.xs`):** Contains the solution logic

## Function Signature
- **Input:** `object[] points` - An array of 3 points, where each point has:
  - `int x` - The x-coordinate
  - `int y` - The y-coordinate
- **Output:** `boolean` - `true` if the points form a valid boomerang, `false` otherwise

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[[1,1], [2,3], [3,2]]` | `true` | Points form a triangle (valid boomerang) |
| `[[1,1], [2,2], [3,3]]` | `false` | Points are collinear on line y=x (invalid) |
| `[[0,0], [1,1], [2,2]]` | `false` | Points are collinear (invalid) |
| `[[0,0], [0,1], [0,2]]` | `false` | Vertical line - collinear (invalid) |
| `[[1,1], [2,2], [3,3]]` | `false` | All same point repeated (technically collinear) |

## Algorithm

The solution uses the cross product method to determine collinearity:

1. Extract the three points from the input array
2. Calculate the vector from point 1 to point 2: `(dx1, dy1) = (x2-x1, y2-y1)`
3. Calculate the vector from point 2 to point 3: `(dx2, dy2) = (x3-x2, y3-y2)`
4. Compute the cross product: `cross = dy1 * dx2 - dy2 * dx1`
5. If `cross == 0`, the points are collinear (return `false`)
6. If `cross != 0`, the points form a valid boomerang (return `true`)

This method works for all cases including vertical lines (where slope would be undefined).
