# Max Consecutive Ones

## Problem

Given a binary array `nums` (containing only 0s and 1s), return the maximum number of consecutive 1s in the array.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/max_consecutive_ones.xs`):** Contains the solution logic

## Function Signature

- **Input:** `nums` (int[]) - A binary array containing only 0s and 1s
- **Output:** `int` - The maximum number of consecutive 1s found in the array

## Algorithm

The solution uses a single pass through the array with two counters:
1. `$current_count` - tracks the current streak of consecutive 1s
2. `$max_count` - tracks the maximum streak found so far

For each element:
- If it's a 1, increment `$current_count` and update `$max_count` if needed
- If it's a 0, reset `$current_count` to 0

This approach runs in O(n) time with O(1) space complexity.

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[1, 1, 0, 1, 1, 1]` | `3` |
| `[0, 0, 0, 0]` | `0` |
| `[1, 1, 1, 1, 1]` | `5` |
| `[]` | `0` |
| `[1]` | `1` |
| `[0]` | `0` |

### Test Case Descriptions

1. **Mixed values with multiple 1-groups** - Basic case with consecutive 1s separated by 0s
2. **All zeros** - Edge case with no 1s at all
3. **All ones** - Edge case where all elements are 1s
4. **Empty array** - Boundary case with no elements
5. **Single 1** - Boundary case with single element that is 1
6. **Single 0** - Boundary case with single element that is 0
