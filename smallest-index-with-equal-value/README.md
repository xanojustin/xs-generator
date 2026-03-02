# Smallest Index with Equal Value

## Problem

Given a 0-indexed integer array `nums`, return the **smallest** index `i` such that `i mod 10 == nums[i]`. If no such index exists, return `-1`.

An index `i` satisfies the condition when the remainder of `i` divided by 10 equals the value at `nums[i]`.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/smallest_index.xs`):** Contains the solution logic

## Function Signature

- **Input:** 
  - `nums` (int[]): An array of integers to search
- **Output:** 
  - (int): The smallest index `i` where `i % 10 == nums[i]`, or `-1` if no such index exists

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[0, 1, 2]` | `0` | Index 0: 0 % 10 = 0, nums[0] = 0 ✓ |
| `[4, 3, 2, 1]` | `2` | Index 2: 2 % 10 = 2, nums[2] = 2 ✓ |
| `[1, 2, 3, 4, 5, 6, 7, 8, 9, 0]` | `-1` | No index satisfies the condition |
| `[2, 1, 3, 5, 2]` | `1` | Index 1: 1 % 10 = 1, nums[1] = 1 ✓ |
| `[]` | `-1` | Empty array returns -1 |
| `[7]` | `-1` | Single element doesn't match |
| `[0]` | `0` | Single element matches at index 0 |

### Test Case Categories

- **Basic/Happy Path:** `[0, 1, 2]` → `0`, `[4, 3, 2, 1]` → `2`
- **Edge Cases:** Empty array `[]` → `-1`, single element `[0]` → `0` and `[7]` → `-1`
- **Boundary/Interesting:** `[1, 2, 3, 4, 5, 6, 7, 8, 9, 0]` → `-1` (values 0-9 but at wrong positions)
