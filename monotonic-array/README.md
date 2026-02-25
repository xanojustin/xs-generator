# Monotonic Array

## Problem
An array is **monotonic** if it is either entirely non-increasing or entirely non-decreasing.

Given an array of integers `nums`, determine if the array is monotonic.

- An array is **monotonically increasing** if for all `i <= j`, `nums[i] <= nums[j]`
- An array is **monotonically decreasing** if for all `i <= j`, `nums[i] >= nums[j]`

An array with 0 or 1 elements is considered monotonic.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/monotonic-array.xs`):** Contains the solution logic

## Function Signature
- **Input:** 
  - `nums` (int[]): Array of integers to check
- **Output:** 
  - `bool`: `true` if the array is monotonic (either non-decreasing or non-increasing), `false` otherwise

## Algorithm
The solution tracks two boolean flags:
1. `$increasing` - stays `true` if array is non-decreasing
2. `$decreasing` - stays `true` if array is non-increasing

We iterate through the array once, comparing each element with its previous element:
- If `nums[i-1] > nums[i]`, the array is not non-decreasing, so set `$increasing = false`
- If `nums[i-1] < nums[i]`, the array is not non-increasing, so set `$decreasing = false`

The array is monotonic if either `$increasing` or `$decreasing` remains `true` after the iteration.

**Time Complexity:** O(n) where n is the length of the array
**Space Complexity:** O(1) - only using two boolean flags

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[1, 2, 2, 3]` | `true` | Non-decreasing (monotonically increasing) |
| `[6, 5, 4, 4]` | `true` | Non-increasing (monotonically decreasing) |
| `[1, 3, 2]` | `false` | Neither (increases then decreases) |
| `[]` | `true` | Empty array is monotonic |
| `[5]` | `true` | Single element is monotonic |
| `[1, 1, 1, 1]` | `true` | All equal is both non-decreasing and non-increasing |
| `[1, 2, 3, 2]` | `false` | Increases then decreases |
| `[5, 4, 3, 4]` | `false` | Decreases then increases |
| `[1, 2, 3, 4, 5]` | `true` | Strictly increasing |
| `[5, 4, 3, 2, 1]` | `true` | Strictly decreasing |

## Example Run

```
Input: [1, 2, 2, 3]
Output: true
Explanation: The array is non-decreasing (1 ≤ 2 ≤ 2 ≤ 3)

Input: [1, 3, 2]
Output: false
Explanation: The array is neither non-decreasing (3 > 2) nor non-increasing (1 < 3)
```
