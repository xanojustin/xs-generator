# Build Array from Permutation

## Problem

Given a **zero-based permutation** `nums` (0-indexed), build an array `ans` of the same length where `ans[i] = nums[nums[i]]` for each `0 <= i < nums.length`, and return it.

A **zero-based permutation** `nums` is an array of distinct integers from `0` to `nums.length - 1` (inclusive).

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/build_array.xs`):** Contains the solution logic

## Function Signature

- **Input:** `int[] nums` — A zero-based permutation array containing distinct integers from 0 to n-1
- **Output:** `int[]` — The built array where each element at index i is `nums[nums[i]]`

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[0, 2, 1, 5, 3, 4]` | `[0, 1, 2, 4, 5, 3]` |
| `[5, 0, 1, 2, 3, 4]` | `[4, 5, 0, 1, 2, 3]` |
| `[0]` | `[0]` |
| `[1, 0]` | `[0, 1]` |

### Explanation of Test Cases

**Example 1:** `[0, 2, 1, 5, 3, 4]`
- `ans[0] = nums[nums[0]] = nums[0] = 0`
- `ans[1] = nums[nums[1]] = nums[2] = 1`
- `ans[2] = nums[nums[2]] = nums[1] = 2`
- `ans[3] = nums[nums[3]] = nums[5] = 4`
- `ans[4] = nums[nums[4]] = nums[3] = 5`
- `ans[5] = nums[nums[5]] = nums[4] = 3`

**Example 2:** `[5, 0, 1, 2, 3, 4]`
- `ans[0] = nums[nums[0]] = nums[5] = 4`
- `ans[1] = nums[nums[1]] = nums[0] = 5`
- `ans[2] = nums[nums[2]] = nums[1] = 0`
- `ans[3] = nums[nums[3]] = nums[2] = 1`
- `ans[4] = nums[nums[4]] = nums[3] = 2`
- `ans[5] = nums[nums[5]] = nums[4] = 3`

**Edge Case — Single Element:** `[0]`
- `ans[0] = nums[nums[0]] = nums[0] = 0`

**Edge Case — Two Elements:** `[1, 0]`
- `ans[0] = nums[nums[0]] = nums[1] = 0`
- `ans[1] = nums[nums[1]] = nums[0] = 1`
