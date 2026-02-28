# Minimum Absolute Difference

## Problem
Given an array of distinct integers, find the **minimum absolute difference** between any two elements in the array.

The absolute difference between two numbers `a` and `b` is `|a - b|`.

### Example
- Input: `[4, 2, 1, 3]`
- Output: `1`
- Explanation: The pairs with minimum absolute difference are (1,2), (2,3), and (3,4), all with difference 1.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/minimum_absolute_difference.xs`):** Contains the solution logic

## Function Signature
- **Input:** 
  - `nums` (int[]): Array of integers
- **Output:** 
  - `int`: The minimum absolute difference between any two elements

## Algorithm
1. Sort the array in ascending order
2. Initialize `min_diff` with the difference between the first two elements
3. Iterate through adjacent pairs in the sorted array
4. Update `min_diff` if a smaller difference is found
5. Return `min_diff`

**Time Complexity:** O(n log n) due to sorting
**Space Complexity:** O(n) for the sorted copy

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[4, 2, 1, 3]` | `1` | Pairs (1,2), (2,3), (3,4) all have diff 1 |
| `[10, 5, 1]` | `4` | Minimum diff is between 5 and 1 |
| `[1]` | `0` | Single element, no pairs possible |
| `[]` | `0` | Empty array, no pairs possible |
| `[100, 50, 25, 12, 6, 3]` | `3` | Minimum diff is 3 (between 3 and 6, or 6 and 12) |
| `[1, 1000]` | `999` | Only one pair possible |
