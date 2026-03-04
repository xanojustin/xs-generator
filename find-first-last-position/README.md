# Find First and Last Position of Element in Sorted Array

## Problem
Given an array of integers `nums` sorted in non-decreasing order, find the starting and ending position of a given `target` value.

If `target` is not found in the array, return `[-1, -1]`.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/find_first_last_position.xs`):** Contains the solution logic using binary search

## Function Signature
- **Input:**
  - `nums` (int[]): Sorted array of integers in non-decreasing order
  - `target` (int): The target value to search for
- **Output:** 
  - int[]: An array containing two elements `[first_position, last_position]`
    - `first_position`: The index of the first occurrence of target, or -1 if not found
    - `last_position`: The index of the last occurrence of target, or -1 if not found

## Algorithm
The solution uses binary search twice:
1. First binary search finds the leftmost (first) occurrence of the target
2. Second binary search finds the rightmost (last) occurrence of the target

Time Complexity: O(log n) - two binary searches on the array
Space Complexity: O(1) - only using a few variables

## Test Cases

| Input | Expected Output | Description |
|-------|-----------------|-------------|
| `nums: [5, 7, 7, 8, 8, 10], target: 8` | `[3, 4]` | Basic case - target appears twice |
| `nums: [5, 7, 7, 8, 8, 10], target: 6` | `[-1, -1]` | Target not in array |
| `nums: [], target: 0` | `[-1, -1]` | Edge case - empty array |
| `nums: [1], target: 1` | `[0, 0]` | Edge case - single element, found |
| `nums: [2, 2], target: 2` | `[0, 1]` | Boundary case - all elements same as target |
| `nums: [1, 2, 3, 4, 5], target: 3` | `[2, 2]` | Target appears once |
