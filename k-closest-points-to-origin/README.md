# K Closest Points to Origin

## Problem

Given an array of points in a 2D plane where each point is represented as `[x, y]`, and an integer `k`, return the `k` closest points to the origin `(0, 0)`.

The distance between two points on a 2D plane is calculated using the Euclidean distance formula:
```
distance = √(x² + y²)
```

You may return the answer in any order. The answer is guaranteed to be unique (except for the order of the points).

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/k_closest_points.xs`):** Contains the solution logic

## Function Signature

- **Input:**
  - `points` (object[]): Array of points, each with `x` (int) and `y` (int) coordinates
  - `k` (int): Number of closest points to return (non-negative)

- **Output:** 
  - Array of the `k` closest points to the origin, where each point is an object with `x` and `y` properties

## Approach

1. Calculate the squared Euclidean distance for each point: `distance = x² + y²`
   - We use squared distance to avoid the expensive square root operation, which doesn't affect ordering
2. Sort the points by their distance in ascending order
3. Return the first `k` points from the sorted array

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `points: [{x:1,y:3}, {x:-2,y:2}, {x:3,y:3}, {x:4,y:-1}, {x:0,y:1}]`, `k: 2` | `[{x:0,y:1}, {x:-2,y:2}]` |
| `points: [{x:3,y:3}, {x:5,y:-1}, {x:-2,y:4}]`, `k: 2` | `[{x:3,y:3}, {x:5,y:-1}]` |
| `points: []`, `k: 1` | `[]` (empty array - edge case) |
| `points: [{x:1,y:1}, {x:2,y:2}]`, `k: 0` | `[]` (k=0 edge case) |
| `points: [{x:1,y:1}]`, `k: 1` | `[{x:1,y:1}]` (single point) |
| `points: [{x:-5,y:-5}, {x:5,y:5}, {x:-3,y:4}, {x:0,y:0}]`, `k: 2` | `[{x:0,y:0}, {x:-3,y:4}]` |

## Complexity Analysis

- **Time Complexity:** O(n log n) where n is the number of points, due to the sorting operation
- **Space Complexity:** O(n) to store the points with their distances
