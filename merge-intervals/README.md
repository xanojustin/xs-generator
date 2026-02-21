# Merge Intervals

## Problem
Given an array of intervals where each interval is represented as an object with `start` and `end` properties, merge all overlapping intervals and return an array of the non-overlapping intervals that cover all the intervals in the input.

Intervals overlap if they share at least one common point. For example, `[1, 3]` and `[2, 6]` overlap because they both contain point 2. When merging, the resulting interval is `[1, 6]`.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/merge_intervals.xs`):** Contains the solution logic

## Function Signature
- **Input:** 
  - `intervals` (object[]): An array of interval objects, each containing:
    - `start` (int): The start of the interval
    - `end` (int): The end of the interval (guaranteed to be >= start)
- **Output:** 
  - `merged` (object[]): An array of merged interval objects with no overlaps

## Algorithm
1. Sort intervals by their start time
2. Initialize the result with the first interval
3. For each subsequent interval:
   - If it overlaps with the last interval in the result (current.start <= last.end), merge them by updating the end to be the maximum of both ends
   - If it doesn't overlap, add it as a new interval to the result

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[{start: 1, end: 3}, {start: 2, end: 6}, {start: 8, end: 10}, {start: 15, end: 18}]` | `[{start: 1, end: 6}, {start: 8, end: 10}, {start: 15, end: 18}]` |
| `[{start: 1, end: 4}, {start: 4, end: 5}]` | `[{start: 1, end: 5}]` |
| `[]` | `[]` |
| `[{start: 1, end: 4}]` | `[{start: 1, end: 4}]` |
| `[{start: 1, end: 10}, {start: 2, end: 3}, {start: 4, end: 5}]` | `[{start: 1, end: 10}]` |

### Case Explanations
- **Basic case:** Multiple intervals with some overlapping, some separate
- **Touching intervals:** Intervals that touch at a single point should be merged
- **Edge case - empty:** Empty input should return empty output
- **Edge case - single:** Single interval returns as-is
- **Boundary case:** One large interval completely contains smaller intervals

## Complexity Analysis
- **Time Complexity:** O(n log n) due to sorting, where n is the number of intervals
- **Space Complexity:** O(n) for the output array (or O(log n) to O(n) depending on sort implementation)
