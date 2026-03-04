# Minimum Number of Arrows to Burst Balloons

## Problem

There are some spherical balloons taped onto a flat wall that represents the XY-plane. The balloons are represented as a 2D integer array `points` where `points[i] = [x_start, x_end]` denotes a balloon whose horizontal diameter stretches between `x_start` and `x_end`. You do not know the exact y-coordinates of the balloons.

Arrows can be shot up directly vertically (in the positive y-direction) from different points along the x-axis. A balloon with `x_start` and `x_end` is burst by an arrow shot at `x` if `x_start <= x <= x_end`. There is no limit to the number of arrows that can be shot. A shot arrow keeps traveling up infinitely, bursting any balloons in its path.

Given the array `points`, return the **minimum** number of arrows that must be shot to burst all balloons.

### Example 1
**Input:** `points = [[10,16],[2,8],[1,6],[7,12]]`  
**Output:** `2`  
**Explanation:** One arrow needs to be shot at x = 6 for balloons [2,8] and [1,6], and another arrow needs to be shot at x = 11 for balloons [10,16] and [7,12].

### Example 2
**Input:** `points = [[1,2],[3,4],[5,6],[7,8]]`  
**Output:** `4`  
**Explanation:** Each balloon needs its own arrow since none overlap.

### Example 3
**Input:** `points = [[1,2],[2,3],[3,4],[4,5]]`  
**Output:** `2`  
**Explanation:** Arrows can be shot at x = 2 and x = 4 to burst all balloons.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/min_arrows_to_burst_balloons.xs`):** Contains the solution logic using a greedy interval scheduling algorithm

## Function Signature

- **Input:** 
  - `points` (object[]): An array of balloons, where each balloon is represented as `[x_start, x_end]`
- **Output:** 
  - `int`: The minimum number of arrows needed to burst all balloons

## Algorithm

The solution uses a **greedy algorithm** based on interval scheduling:

1. **Sort** the balloons by their end coordinate (`x_end`)
2. **Initialize** the first arrow at the end of the first balloon
3. **Iterate** through the sorted balloons:
   - If a balloon starts after the current arrow position, shoot a new arrow at this balloon's end
   - Otherwise, the current arrow can burst this balloon too (skip it)

This greedy approach ensures we always place arrows at positions that can burst the maximum number of overlapping balloons.

## Test Cases

| Input | Expected Output | Description |
|-------|-----------------|-------------|
| `[[10,16],[2,8],[1,6],[7,12]]` | `2` | Basic overlapping case - two groups of balloons |
| `[[1,2],[3,4],[5,6],[7,8]]` | `4` | No overlaps - each needs its own arrow |
| `[[1,2],[2,3],[3,4],[4,5]]` | `2` | Touching boundaries - can share arrows at touching points |
| `[]` | `0` | Edge case: empty input |
| `[[5,10]]` | `1` | Edge case: single balloon |
| `[[1,5],[1,5],[1,5]]` | `1` | All balloons completely overlap - one arrow bursts all |

## Complexity Analysis

- **Time Complexity:** O(n log n) due to sorting, where n is the number of balloons
- **Space Complexity:** O(n) for the sorted array (could be O(1) extra if sorting in-place)

## Related Problems

This is a classic interval greedy problem similar to:
- Meeting Rooms II
- Non-overlapping Intervals
- Interval List Intersections
