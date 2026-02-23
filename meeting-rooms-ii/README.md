# Meeting Rooms II

## Problem
Given an array of meeting time intervals where each interval is represented as `[start, end]`, find the minimum number of conference rooms required to accommodate all meetings without overlap.

For example:
- Meeting A: [0, 30]
- Meeting B: [5, 10]  
- Meeting C: [15, 20]

Meeting A overlaps with both B and C, so we need 2 conference rooms minimum.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/meeting_rooms_ii.xs`):** Contains the solution logic using a two-pointer technique

## Function Signature
- **Input:** `intervals` (json) - Array of meeting intervals, each as [start, end]
- **Output:** (int) - Minimum number of conference rooms required

## Algorithm
The solution uses a sweep line / two-pointer technique:
1. Extract all start times and end times into separate arrays
2. Sort both arrays
3. Use two pointers to track when meetings start and end
4. Increment room count when a meeting starts, decrement when it ends
5. Track the maximum concurrent meetings

This approach runs in O(n log n) time due to sorting and O(n) space.

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[[0, 30], [5, 10], [15, 20]]` | 2 | Meeting [0,30] overlaps with both others |
| `[[7, 10], [2, 4]]` | 1 | Meetings don't overlap |
| `[]` | 0 | No meetings require no rooms |
| `[[1, 5], [2, 6], [3, 7], [8, 9]]` | 3 | Three meetings overlap at time 3-5 |
| `[[1, 10], [2, 7], [3, 19], [8, 12], [10, 20], [11, 30]]` | 4 | Complex overlapping pattern |
