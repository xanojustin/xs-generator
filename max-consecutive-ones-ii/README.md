# Max Consecutive Ones II

## Problem

Given a binary array `nums` (containing only 0s and 1s), return the maximum number of consecutive 1s in the array if you can flip at most one 0 to 1.

This is LeetCode 487.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/max_consecutive_ones_ii.xs`):** Contains the solution logic

## Function Signature

- **Input:** `nums` (int[]) - A binary array containing only 0s and 1s
- **Output:** `int` - The maximum number of consecutive 1s found after flipping at most one 0

## Algorithm

The solution uses a sliding window (two-pointer) approach:

1. **`$left`** - Left boundary of the window
2. **`$zeros_count`** - Count of zeros in the current window
3. **`$max_length`** - Maximum window size found so far

We iterate through the array with the right pointer (using `foreach`):
- When we encounter a 0, increment `$zeros_count`
- While `$zeros_count > 1`, shrink the window from the left
- Update `$max_length` with the current valid window size

This approach runs in O(n) time with O(1) space complexity.

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[1, 0, 1, 1, 0]` | `4` |
| `[1, 1, 1, 0, 1, 1, 1, 1]` | `8` |
| `[0, 0, 0, 0]` | `1` |
| `[1, 1, 1, 1, 1]` | `5` |
| `[]` | `0` |
| `[0]` | `1` |
| `[1]` | `1` |

### Test Case Descriptions

1. **Flip one zero to connect two groups** - `[1,0,1,1,0]` → flip the first 0 to get `[1,1,1,1,0]` = 4 consecutive 1s
2. **Flip the single zero to get all 1s** - `[1,1,1,0,1,1,1,1]` → flip the 0 to get 8 consecutive 1s
3. **All zeros** - Must flip one 0 to get at least 1 one, so result is 1
4. **All ones** - No flip needed, result is array length
5. **Empty array** - Boundary case with no elements
6. **Single zero** - Flip it to get 1 one
7. **Single one** - Already optimal, result is 1
