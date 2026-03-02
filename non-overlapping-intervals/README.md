# Non-overlapping Intervals

## Problem

Given an array of intervals `intervals` where each `intervals[i] = {start: starti, end: endi}`, return the minimum number of intervals you need to remove to make the rest of the intervals non-overlapping.

Two intervals overlap if they share at least one common point. Intervals that only touch at a point (e.g., `[1, 2]` and `[2, 3]`) are NOT considered overlapping.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/non_overlapping_intervals.xs`):** Contains the greedy algorithm solution

## Function Signature

- **Input:** `object[] intervals` - Array of interval objects, each with `start` (int) and `end` (int) properties
- **Output:** `int` - Minimum number of intervals to remove

## Algorithm Explanation

This problem uses a **greedy algorithm** approach:

1. **Sort** intervals by their end times (earliest ending first)
2. **Keep** the first interval (it ends earliest, leaving maximum room)
3. For each subsequent interval:
   - If it **starts before** the last kept interval ends → **remove it** (they overlap)
   - Otherwise → **keep it** and update the last end time

The greedy choice works because by always keeping the interval that ends earliest, we maximize the remaining space for other intervals.

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|------------- |
| `[{1,2}, {2,3}, {3,4}, {1,3}]` | 1 | Remove `{1,3}` to make all non-overlapping |
| `[{1,2}, {1,2}, {1,2}]` | 2 | Keep one `{1,2}`, remove two |
| `[{1,2}, {2,3}]` | 0 | Already non-overlapping (touching is ok) |
| `[]` | 0 | Empty array, nothing to remove |
| `[{1,2}]` | 0 | Single interval |
| `[{1,100}, {1,2}, {2,3}, {3,4}]` | 1 | Remove `{1,100}` to keep 3 small intervals |

## Complexity Analysis

- **Time Complexity:** O(n log n) - dominated by sorting
- **Space Complexity:** O(n) - for the sorted array (or O(1) extra if sorting in-place)
