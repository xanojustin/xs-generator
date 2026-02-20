# Meeting Rooms

## Problem
Given an array of meeting time intervals consisting of start and end times, determine if a person can attend all meetings without any conflicts.

A conflict occurs when one meeting overlaps with another - specifically, if meeting A ends after meeting B starts, they cannot both be attended.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/can_attend_all_meetings.xs`):** Contains the solution logic

## Function Signature
- **Input:** `object[] intervals` - An array of objects, each containing:
  - `start` (int): The start time of the meeting
  - `end` (int): The end time of the meeting
- **Output:** `bool` - Returns `true` if all meetings can be attended without conflicts, `false` otherwise

## Algorithm
1. Handle edge cases (0 or 1 meetings always return `true`)
2. Sort intervals by start time using bubble sort
3. Iterate through sorted intervals and check for overlaps
4. Return `false` if any overlap is found, `true` otherwise

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[{start: 0, end: 30}, {start: 5, end: 10}, {start: 15, end: 20}]` | `false` | Meeting 1 overlaps with meetings 2 and 3 |
| `[{start: 7, end: 10}, {start: 2, end: 4}]` | `true` | No overlaps, meetings are separate |
| `[]` | `true` | Empty input - no meetings to conflict |
| `[{start: 1, end: 5}]` | `true` | Single meeting - no conflict possible |
| `[{start: 1, end: 5}, {start: 5, end: 10}]` | `true` | Back-to-back meetings (end == start) is allowed |
| `[{start: 1, end: 10}, {start: 2, end: 6}, {start: 8, end: 12}]` | `false` | Multiple overlapping meetings |
