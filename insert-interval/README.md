# Insert Interval

## Problem
Given a set of non-overlapping intervals sorted by their start time, insert a new interval into the intervals and merge if necessary.

You may assume that the intervals were initially sorted according to their start times. After inserting the new interval, the result should be a list of non-overlapping intervals sorted by start time.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/insert_interval.xs`):** Contains the solution logic

## Function Signature
- **Input:**
  - `intervals` (object[]): Array of non-overlapping intervals sorted by start time, each with `start` (int) and `end` (int) properties
  - `new_interval` (object): The interval to insert with `start` (int) and `end` (int) properties
- **Output:** 
  - (object[]): Array of merged non-overlapping intervals sorted by start time

## Approach
The algorithm works in three phases:
1. **Add intervals before:** Add all intervals that end before the new interval starts (no overlap)
2. **Merge overlapping:** Merge all intervals that overlap with the new interval by expanding the new interval's boundaries
3. **Add remaining:** Add all intervals that start after the merged interval ends

## Test Cases

| Intervals | New Interval | Expected Output |
|-----------|--------------|-----------------|
| `[{start: 1, end: 3}, {start: 6, end: 9}]` | `{start: 2, end: 5}` | `[{start: 1, end: 5}, {start: 6, end: 9}]` |
| `[{start: 1, end: 2}, {start: 3, end: 5}, {start: 6, end: 7}, {start: 8, end: 10}, {start: 12, end: 16}]` | `{start: 4, end: 8}` | `[{start: 1, end: 2}, {start: 3, end: 10}, {start: 12, end: 16}]` |
| `[]` | `{start: 5, end: 7}` | `[{start: 5, end: 7}]` |
| `[{start: 1, end: 5}]` | `{start: 2, end: 3}` | `[{start: 1, end: 5}]` |
| `[{start: 1, end: 5}]` | `{start: 6, end: 8}` | `[{start: 1, end: 5}, {start: 6, end: 8}]` |
| `[{start: 3, end: 5}]` | `{start: 1, end: 2}` | `[{start: 1, end: 2}, {start: 3, end: 5}]` |

## Complexity Analysis
- **Time Complexity:** O(n) where n is the number of intervals - we iterate through the list once
- **Space Complexity:** O(n) for the result array (excluding output, it's O(1) extra space)
