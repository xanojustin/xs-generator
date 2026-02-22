# Search Insert Position

## Problem

Given a sorted array of distinct integers and a target value, return the index if the target is found. If not, return the index where it would be if it were inserted in order.

You must write an algorithm with O(log n) runtime complexity.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/search_insert_position.xs`):** Contains the solution logic implementing binary search

## Function Signature

- **Input:**
  - `nums` (int[]): A sorted array of distinct integers in ascending order
  - `target` (int): The target value to search for or insert position for
- **Output:** 
  - `index` (int): The index of the target if found, or the insertion position if not found

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `nums = [1, 3, 5, 6], target = 5` | `2` (target found at index 2) |
| `nums = [1, 3, 5, 6], target = 2` | `1` (insert at index 1) |
| `nums = [1, 3, 5, 6], target = 7` | `4` (insert at end) |
| `nums = [], target = 5` | `0` (empty array edge case) |
| `nums = [1], target = 0` | `0` (insert before single element) |
| `nums = [1, 3, 5, 6], target = 0` | `0` (insert at beginning) |
