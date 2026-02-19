# Two Sum

## Problem

Given an array of integers `numbers` and an integer `target`, return the indices of the two numbers such that they add up to `target`.

You may assume that each input would have **exactly one solution**, and you may not use the same element twice.

The function should return the indices as an array `[index1, index2]` where `index1 < index2`, or `null` if no solution exists.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/two_sum.xs`):** Contains the solution logic using a hash map for O(n) time complexity

## Function Signature

- **Input:**
  - `numbers` (json): Array of integers to search through
  - `target` (int): The target sum to find
- **Output:**
  - Returns a json array `[index1, index2]` containing the indices of the two numbers that sum to target
  - Returns `null` if no solution is found or if input is invalid

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `numbers: [2, 7, 11, 15]`, `target: 9` | `[0, 1]` (2 + 7 = 9) |
| `numbers: [3, 2, 4]`, `target: 6` | `[1, 2]` (2 + 4 = 6) |
| `numbers: [3, 3]`, `target: 6` | `[0, 1]` (3 + 3 = 6) |
| `numbers: []`, `target: 5` | `null` (edge case: empty array) |
| `numbers: [5]`, `target: 5` | `null` (edge case: single element) |
| `numbers: [1, 2, 3]`, `target: 10` | `null` (no valid pair) |

## Algorithm

The solution uses a hash map (object) to achieve O(n) time complexity:

1. Iterate through the array once
2. For each number, check if its complement (target - current number) exists in the hash map
3. If found, return the indices
4. If not found, store the current number's complement in the hash map with its index
5. If no pair is found after iterating, return null

This is more efficient than the brute force O(n²) approach of checking all pairs.
