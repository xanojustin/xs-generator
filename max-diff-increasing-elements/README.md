# Maximum Difference Between Increasing Elements

## Problem

Given an array of integers `nums`, find the **maximum difference** between two elements such that the larger element comes after the smaller element (i.e., `j > i` and `nums[j] > nums[i]`).

If no such pair exists where a larger element follows a smaller element, return `-1`.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/max-diff.xs`):** Contains the solution logic

## Function Signature

- **Input:** 
  - `nums`: `int[]` — An array of integers with at least 2 elements
- **Output:** 
  - `int` — The maximum difference between a larger element that appears after a smaller element, or `-1` if no valid pair exists

## Algorithm

The solution uses a single-pass approach with O(n) time complexity:

1. Track the minimum element seen so far (`min_so_far`)
2. For each subsequent element, check if it forms a valid increasing pair with `min_so_far`
3. If valid, calculate the difference and update `max_diff` if this difference is larger
4. Update `min_so_far` if the current element is smaller

This greedy approach ensures we always consider the smallest preceding element for maximum difference calculation.

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[7, 1, 5, 4]` | `4` | 5 - 1 = 4 (maximum difference) |
| `[9, 4, 3, 2]` | `-1` | No increasing pair exists (descending array) |
| `[1, 2, 3, 4, 5]` | `4` | 5 - 1 = 4 (maximum possible with this array) |
| `[5, 5, 5, 5]` | `-1` | No strictly increasing pair (all equal) |
| `[1, 5]` | `4` | Basic case with two elements |

### Edge Cases

- **Empty array or single element:** Precondition validation error (requires ≥ 2 elements)
- **Strictly decreasing array:** Returns `-1` (no increasing pairs possible)
- **All equal elements:** Returns `-1` (no strictly increasing pairs)
- **Already sorted ascending:** Returns difference between last and first element

## Complexity Analysis

- **Time Complexity:** O(n) — Single pass through the array
- **Space Complexity:** O(1) — Only uses a few variables regardless of input size

## Example Walkthrough

For input `[7, 1, 5, 4]`:

1. Initialize `min_so_far = 7`, `max_diff = -1`
2. At index 1 (value 1): `1 < 7`, so update `min_so_far = 1`
3. At index 2 (value 5): `5 > 1`, diff = 4, update `max_diff = 4`
4. At index 3 (value 4): `4 > 1`, diff = 3, but `3 < 4`, so `max_diff` stays 4
5. Return `max_diff = 4`
