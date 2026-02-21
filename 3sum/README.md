# 3Sum

## Problem
Given an integer array `nums`, find all unique triplets `[nums[i], nums[j], nums[k]]` such that:
- `i != j`, `i != k`, and `j != k`
- `nums[i] + nums[j] + nums[k] == 0`

The solution set must not contain duplicate triplets.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/three_sum.xs`):** Contains the solution logic using the two-pointer technique

## Function Signature
- **Input:** 
  - `nums` (int[]): Array of integers to search for triplets
- **Output:** 
  - Array of triplets (int[][]), where each triplet is an array of 3 integers that sum to zero

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[-1, 0, 1, 2, -1, -4]` | `[[-1, -1, 2], [-1, 0, 1]]` |
| `[]` | `[]` |
| `[0, 0, 0]` | `[[0, 0, 0]]` |
| `[1, -1, -1, 0]` | `[[-1, 0, 1]]` |
| `[-2, 0, 1, 1, 2]` | `[[-2, 0, 2], [-2, 1, 1]]` |

### Test Case Explanations
1. **Basic case:** Classic example with multiple valid triplets, including handling of duplicate values
2. **Empty array:** Edge case - returns empty array when input is too small
3. **All zeros:** Simple case where the only valid triplet is three zeros
4. **Duplicates in output:** Verifies that duplicate triplets are eliminated (only one `[-1, 0, 1]` in output)
5. **Multiple valid combinations:** Tests various combinations with positive and negative numbers
