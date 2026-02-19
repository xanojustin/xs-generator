# Two Sum

## Problem
Given an array of integers `nums` and an integer `target`, return the indices of the two numbers such that they add up to `target`.

You may assume that each input would have exactly one solution, and you may not use the same element twice. You can return the answer in any order.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/two_sum.xs`):** Contains the solution logic using a hash map for O(n) time complexity

## Function Signature
- **Input:** 
  - `nums` (int[]): Array of integers to search
  - `target` (int): Target sum value
- **Output:** 
  - (int[]): Array containing the indices of the two numbers that add up to target

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `nums: [2, 7, 11, 15], target: 9` | `[0, 1]` (because 2 + 7 = 9) |
| `nums: [3, 2, 4], target: 6` | `[1, 2]` (because 2 + 4 = 6) |
| `nums: [3, 3], target: 6` | `[0, 1]` (edge case: duplicate values) |
| `nums: [1, 2, 3, 4, 5], target: 9` | `[3, 4]` (because 4 + 5 = 9) |

## Algorithm
This solution uses a **hash map** (object/dictionary) approach:
1. Iterate through the array once
2. For each number, calculate its complement (`target - current_number`)
3. Check if the complement exists in the hash map
4. If found, return the indices
5. If not found, store the current number and its index in the hash map

**Time Complexity:** O(n) - single pass through the array  
**Space Complexity:** O(n) - for the hash map storage
