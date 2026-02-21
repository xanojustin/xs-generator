# Move Zeros

## Problem
Given an integer array `nums`, move all `0`s to the end of it while maintaining the relative order of the non-zero elements.

You must do this **in-place** without making a copy of the array.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/move_zeros.xs`):** Contains the solution logic using a two-pointer approach

## Function Signature
- **Input:** `nums` - An array of integers (int_array)
- **Output:** The modified array with all zeros moved to the end (int_array)

## Algorithm
The solution uses a two-pointer technique:
1. **First pass:** Iterate through the array with pointer `i`, use pointer `write_index` to place non-zero elements at the front
2. **Second pass:** Fill the remaining positions from `write_index` to end with zeros

This approach is:
- **Time Complexity:** O(n) - single pass through array
- **Space Complexity:** O(1) - in-place modification

## Test Cases
| Input | Expected Output |
|-------|-----------------|
| `[0, 1, 0, 3, 12]` | `[1, 3, 12, 0, 0]` |
| `[0, 0, 0]` | `[0, 0, 0]` |
| `[1, 2, 3]` | `[1, 2, 3]` |
| `[0]` | `[0]` |
| `[]` | `[]` |
| `[1, 0, 2, 0, 0, 3, 4]` | `[1, 2, 3, 4, 0, 0, 0]` |

## Examples

### Example 1
**Input:** `nums = [0, 1, 0, 3, 12]`
**Output:** `[1, 3, 12, 0, 0]`

### Example 2
**Input:** `nums = [0]`
**Output:** `[0]`

### Example 3
**Input:** `nums = [1, 2, 3]`
**Output:** `[1, 2, 3]` (no zeros to move)
