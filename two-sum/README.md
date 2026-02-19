# Two Sum

## Problem

Given an array of integers `nums` and an integer `target`, return the indices of the two numbers such that they add up to `target`.

You may assume that each input would have exactly one solution, and you may not use the same element twice. You can return the answer in any order.

This is a classic coding interview question that tests basic array traversal and search algorithms.

## Function Signature

- **Input:**
  - `nums` (int[]) - An array of integers to search through
  - `target` (int) - The target sum value to find
- **Output:** `int[]` - An array containing exactly two indices [i, j] where nums[i] + nums[j] == target

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| nums: [2, 7, 11, 15], target: 9 | [0, 1] |
| nums: [3, 2, 4], target: 6 | [1, 2] |
| nums: [3, 3], target: 6 | [0, 1] |
| nums: [1, 2, 3, 4, 5], target: 9 | [3, 4] |
| nums: [0, 4, 3, 0], target: 0 | [0, 3] |
| nums: [], target: 5 | [] (no solution) |

### Edge Cases Explained

1. **Basic case [2, 7, 11, 15], target 9**: The classic example - 2 + 7 = 9, indices 0 and 1
2. **Same values [3, 3], target 6**: Tests that we can use duplicate values at different indices
3. **Non-consecutive [1, 2, 3, 4, 5], target 9**: 4 + 5 = 9, indices 3 and 4, not adjacent
4. **Zeros [0, 4, 3, 0], target 0**: 0 + 0 = 0, testing edge case with zero values
5. **Empty array []**: No solution possible, should return empty array
6. **Negative numbers**: Algorithm works with negative integers as well

## Algorithm

This implementation uses a brute-force approach with nested loops:
1. Iterate through each element with index `i`
2. For each `i`, iterate through remaining elements with index `j`
3. Check if nums[i] + nums[j] equals target
4. If found, return the indices [i, j]
5. If no solution found after checking all pairs, return empty array

**Time Complexity:** O(n²) where n is the length of the array
**Space Complexity:** O(1) - only uses a constant amount of extra space

**Note:** A more optimal O(n) solution exists using a hash map, but this implementation demonstrates the fundamental nested loop pattern.
