# Jump Game

## Problem

You are given an integer array `nums`. You are initially positioned at the array's first index, and each element in the array represents your maximum jump length at that position.

Return `true` if you can reach the last index, or `false` otherwise.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/jumpGame.xs`):** Contains the solution logic

## Function Signature

- **Input:** 
  - `nums` (int[]): Array where each element represents the maximum jump length from that position
- **Output:** 
  - `bool`: `true` if the last index is reachable, `false` otherwise

## Algorithm

This solution uses a **greedy algorithm** that tracks the furthest position reachable at each step:

1. Initialize `furthest` to 0 (the furthest index we can reach)
2. Iterate through the array while current index ≤ furthest reachable
3. At each position, update `furthest` to be the max of current `furthest` and `current index + jump length`
4. If `furthest` ever reaches or exceeds the last index, return `true`
5. If current index exceeds `furthest`, we've hit a gap and can't proceed, return `false`

**Time Complexity:** O(n) - single pass through the array
**Space Complexity:** O(1) - only a few variables

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[2, 3, 1, 1, 4]` | `true` | Jump 1 step from index 0 to 1, then 3 steps to last index |
| `[3, 2, 1, 0, 4]` | `false` | No matter what, you'll always arrive at index 3 with jump length 0, can't proceed |
| `[0]` | `true` | Already at last index (single element) |
| `[2, 0]` | `true` | Can jump from index 0 directly to index 1 |
| `[1, 1, 1, 1]` | `true` | Can hop one step at a time to reach the end |
| `[0, 2]` | `false` | Stuck at index 0 with jump length 0 |

### Test Case Descriptions

1. **Happy path case:** Standard case where multiple paths lead to success
2. **Unreachable case:** The furthest reachable gets stuck before the end
3. **Edge case (single element):** Already at destination
4. **Edge case (two elements, reachable):** Direct jump possible
5. **Boundary case (all ones):** Minimum jumps, but still reachable
6. **Edge case (stuck at start):** Can't make first move
