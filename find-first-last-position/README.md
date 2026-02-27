# Find First and Last Position of Element in Sorted Array

## Problem
Given a sorted array of integers `nums` and a target value `target`, find the starting and ending position of the target value in the array.

If the target is not found in the array, return `[-1, -1]`.

The algorithm must run in **O(log n)** time complexity.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/find_first_last_position.xs`):** Contains the solution logic using modified binary search

## Function Signature
- **Input:**
  - `nums` (int[]): A sorted array of integers in ascending order
  - `target` (int): The target value to search for
- **Output:**
  - Returns an array `[first_position, last_position]` where:
    - `first_position` is the index of the first occurrence of target
    - `last_position` is the index of the last occurrence of target
  - Returns `[-1, -1]` if the target is not found

## Approach
This solution uses **modified binary search** to achieve O(log n) time complexity:

1. **Find First Position:** Run binary search but when target is found, continue searching in the left half to find the leftmost occurrence.

2. **Find Last Position:** Run binary search but when target is found, continue searching in the right half to find the rightmost occurrence.

3. **Edge Cases:** Handle empty arrays and targets not present in the array.

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `nums: [5, 7, 7, 8, 8, 10], target: 8` | `[3, 4]` |
| `nums: [5, 7, 7, 8, 8, 10], target: 6` | `[-1, -1]` |
| `nums: [], target: 0` | `[-1, -1]` |
| `nums: [1], target: 1` | `[0, 0]` |
| `nums: [2, 2, 2, 2], target: 2` | `[0, 3]` |
| `nums: [1, 2, 3, 4, 5], target: 3` | `[2, 2]` |

### Test Case Explanations:
- **Basic case:** Target `8` appears at indices 3 and 4
- **Not found:** Target `6` is not in the array
- **Empty array:** Edge case with no elements
- **Single element:** Array with one element that matches
- **All same elements:** All elements are the target
- **Single occurrence:** Target appears exactly once

## Complexity Analysis
- **Time Complexity:** O(log n) - Two binary searches, each O(log n)
- **Space Complexity:** O(1) - Only a few variables used, no additional data structures
