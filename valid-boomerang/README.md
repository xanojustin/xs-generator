# Valid Boomerang

## Problem
Given three points in a 2D plane, determine if they form a valid boomerang.

A valid boomerang is formed when:
- All three points are distinct (no duplicates)
- The three points are NOT collinear (they don't form a straight line)

In other words, the three points must form a triangle with a non-zero area.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/valid_boomerang.xs`):** Contains the solution logic

## Function Signature
- **Input:** 
  - `point1`: Object with `x` (int) and `y` (int) coordinates
  - `point2`: Object with `x` (int) and `y` (int) coordinates
  - `point3`: Object with `x` (int) and `y` (int) coordinates
- **Output:** `bool` - `true` if the points form a valid boomerang, `false` otherwise

## Algorithm
The solution uses the area formula to check for collinearity:
- Calculate: `area2 = x1(y2-y3) + x2(y3-y1) + x3(y1-y2)`
- If `area2 == 0`, the points are collinear (on the same line)
- Also check that no two points are identical
- Return `true` only if `area2 != 0` AND all points are distinct

## Test Cases

| Input | Expected Output | Description |
|-------|-----------------|-------------|
| `(1,1), (2,3), (3,2)` | `true` | Valid boomerang - triangle shape |
| `(1,1), (2,2), (3,3)` | `false` | Collinear points - diagonal line |
| `(1,1), (1,1), (3,3)` | `false` | Duplicate points - invalid |
| `(0,0), (0,3), (4,0)` | `true` | Right triangle - valid boomerang |
| `(0,0), (1,0), (2,0)` | `false` | Horizontal line - collinear |
