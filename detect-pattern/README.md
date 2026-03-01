# Detect Pattern

## Problem
Given an array of positive integers `arr`, determine if there exists a pattern of length `m` that is repeated `k` or more times consecutively in the array.

A pattern is a subarray (consecutive elements) of length `m`. Two patterns are considered the same if all their corresponding elements are equal.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/detect_pattern.xs`):** Contains the solution logic

## Function Signature
- **Input:**
  - `arr` (int[]): Array of positive integers to search
  - `m` (int): Length of the pattern to detect
  - `k` (int): Minimum number of consecutive repetitions required
- **Output:** 
  - (bool): `true` if a pattern of length `m` repeats at least `k` times consecutively, `false` otherwise

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `arr = [1, 2, 4, 4, 4, 4], m = 1, k = 3` | `true` (4 repeats 4 times) |
| `arr = [1, 2, 1, 2, 1, 3], m = 2, k = 3` | `true` ([1, 2] repeats 3 times) |
| `arr = [1, 2, 3, 1, 2], m = 2, k = 2` | `false` (no consecutive repetition) |
| `arr = [], m = 1, k = 1` | `false` (empty array edge case) |
| `arr = [1, 2, 3], m = 2, k = 3` | `false` (array too small for 3 patterns of length 2) |
| `arr = [5, 5, 5, 5, 5], m = 1, k = 5` | `true` (5 repeats 5 times) |

## Algorithm
The solution iterates through all possible starting positions in the array and checks if a pattern of length `m` starting at that position repeats `k` times consecutively. The algorithm:

1. First checks if the array is large enough to contain `k` patterns of length `m`
2. For each possible starting position, compares the first pattern with each subsequent pattern
3. If all elements match for `k` consecutive repetitions, returns `true`
4. If no pattern is found after checking all positions, returns `false`
