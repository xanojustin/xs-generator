# Combination Sum

## Problem
Given an array of **distinct** integers `candidates` and a target integer `target`, return a list of all **unique combinations** of `candidates` where the chosen numbers sum to `target`. You may use the same number from `candidates` an unlimited number of times.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/combination_sum.xs`):** Contains the solution logic using iterative backtracking

## Function Signature
- **Input:**
  - `candidates` (int[]): Array of distinct integers to use for combinations
  - `target` (int): The target sum to achieve
- **Output:**
  - Array of arrays (int[][]), where each inner array is a unique combination of numbers that sum to target

## Algorithm
The solution uses an **iterative backtracking approach** with a manual stack to simulate recursion:

1. Sort the candidates array for consistent results
2. Use a stack to track exploration states (current sum, start index, current combination)
3. For each state, try adding each candidate from the current start index
4. If the sum equals target, add the combination to results
5. If the sum is less than target, push new states to continue exploration
6. Use start index to allow reusing the same candidate (unlimited usage)

**Time Complexity:** O(N^(T/M)) where N = candidates length, T = target, M = minimum candidate
**Space Complexity:** O(T/M) for the recursion stack (simulated via manual stack)

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `candidates: [2, 3, 6, 7], target: 7` | `[[2, 2, 3], [7]]` |
| `candidates: [2, 3, 5], target: 8` | `[[2, 2, 2, 2], [2, 3, 3], [3, 5]]` |
| `candidates: [2], target: 1` | `[]` (empty - no solution possible) |
| `candidates: [1], target: 2` | `[[1, 1]]` |
| `candidates: [], target: 7` | `[]` (empty array edge case) |

### Basic/Happy Path Cases
1. **Multiple solutions:** `[2, 3, 6, 7]` with target `7` returns `[[2,2,3], [7]]`
2. **Single solution:** `[2, 3, 5]` with target `8` returns three valid combinations

### Edge Cases
1. **No solution possible:** `[2]` with target `1` returns empty array
2. **Single element repeated:** `[1]` with target `2` returns `[[1, 1]]`
3. **Empty candidates:** `[]` with any target returns empty array

### Boundary/Interesting Cases
1. **Large target with small candidates:** Tests the iteration depth
2. **Candidates larger than target:** Should be skipped automatically
