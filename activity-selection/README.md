# Activity Selection Problem

## Problem
Given a set of activities, each marked by a start time and end time, select the maximum number of activities that can be performed by a single person, assuming that a person can only work on a single activity at a time.

Two activities are compatible if their time intervals don't overlap (i.e., one activity ends before or when the other starts).

## Approach
This problem uses a **greedy algorithm** approach:
1. Sort all activities by their end times in ascending order
2. Select the first activity (earliest finishing)
3. For each remaining activity, select it if its start time is greater than or equal to the end time of the last selected activity

**Why greedy works:** By always choosing the activity that finishes earliest, we leave the maximum amount of time remaining for future activities.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/activity_selection.xs`):** Contains the solution logic

## Function Signature
- **Input:** `activities` - An array of objects, where each object has:
  - `start` (int): Start time of the activity
  - `end` (int): End time of the activity
- **Output:** Array of selected activities (maximum non-overlapping subset)

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[{start: 1, end: 4}, {start: 3, end: 5}, {start: 0, end: 6}, {start: 5, end: 7}, {start: 3, end: 8}, {start: 5, end: 9}, {start: 6, end: 10}, {start: 8, end: 11}, {start: 8, end: 12}, {start: 2, end: 13}, {start: 12, end: 14}]` | `[{start: 1, end: 4}, {start: 5, end: 7}, {start: 8, end: 11}, {start: 12, end: 14}]` |
| `[]` (empty array) | `[]` |
| `[{start: 1, end: 2}]` (single activity) | `[{start: 1, end: 2}]` |
| `[{start: 1, end: 5}, {start: 2, end: 3}, {start: 3, end: 4}]` | `[{start: 2, end: 3}, {start: 3, end: 4}]` |

## Complexity
- **Time Complexity:** O(n²) due to bubble sort implementation (could be O(n log n) with efficient sort)
- **Space Complexity:** O(n) for storing the result

## Real-world Applications
- Scheduling meetings in a conference room
- Course scheduling to maximize number of courses
- CPU job scheduling
- Resource allocation problems
