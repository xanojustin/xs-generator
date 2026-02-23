# K-Diff Pairs

## Problem
Given an array of integers `nums` and an integer `k`, return the number of **unique** k-diff pairs in the array.

A **k-diff pair** is an integer pair `(nums[i], nums[j])` where:
- `0 <= i, j < nums.length`
- `i != j`
- `|nums[i] - nums[j]| == k`

**Note:** The pair `(a, b)` is considered the same as `(b, a)`. Only count each unique pair once.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/count_k_diff_pairs.xs`):** Contains the solution logic

## Function Signature
- **Input:**
  - `nums` (int[]): Array of integers
  - `k` (int): The target difference
- **Output:** 
  - `result` (int): The count of unique k-diff pairs

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `nums: [3, 1, 4, 1, 5], k: 2` | `2` (pairs: (1,3) and (3,5)) |
| `nums: [1, 2, 3, 4, 5], k: 1` | `4` (pairs: (1,2), (2,3), (3,4), (4,5)) |
| `nums: [1, 3, 1, 5, 4], k: 0` | `1` (pair: (1,1) - appears twice) |
| `nums: [1, 2, 3], k: -1` | `0` (k must be non-negative) |
| `nums: [], k: 2` | `0` (empty array) |
| `nums: [1], k: 0` | `0` (single element) |
