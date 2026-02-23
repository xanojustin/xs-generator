# Wiggle Sort

## Problem

Given an unsorted array `nums`, reorder it in-place such that:
```
nums[0] <= nums[1] >= nums[2] <= nums[3]...
```

This creates a "wiggle" pattern where every odd-indexed element is a peak (greater than or equal to its neighbors), and every even-indexed element is a valley (less than or equal to its neighbors).

For example, given `[3, 5, 2, 1, 6, 4]`, one valid wiggle sort result is `[3, 5, 1, 6, 2, 4]`:
- `3 <= 5` ✓
- `5 >= 1` ✓
- `1 <= 6` ✓
- `6 >= 2` ✓
- `2 <= 4` ✓

Note: There may be multiple valid solutions. The important property is that the wiggle pattern holds.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/wiggle_sort.xs`):** Contains the solution logic

## Function Signature

- **Input:** 
  - `nums` (int[]): Array of integers to rearrange
- **Output:** 
  - Returns int[]: The wiggle-sorted array

## Approach

The algorithm works in O(n) time without sorting:

1. Iterate through the array starting from index 1
2. For odd indices (1, 3, 5...), ensure `nums[i] >= nums[i-1]`
3. For even indices (2, 4, 6...), ensure `nums[i] <= nums[i-1]`
4. If the condition is not met, swap the elements

This greedy approach works because a single pass with local swaps is sufficient to establish the global wiggle property.

## Test Cases

| Input | Expected Output (one valid solution) |
|-------|-------------------------------------|
| `[3, 5, 2, 1, 6, 4]` | `[3, 5, 1, 6, 2, 4]` or similar valid wiggle pattern |
| `[1, 2, 3, 4, 5]` | `[1, 3, 2, 5, 4]` (sorted alternating swap) |
| `[]` | `[]` (empty array) |
| `[7]` | `[7]` (single element) |
| `[1, 1, 1, 1]` | `[1, 1, 1, 1]` (all equal elements) |
| `[5, 4, 3, 2, 1]` | `[4, 5, 2, 3, 1]` or similar valid pattern |

## Complexity Analysis

- **Time Complexity:** O(n) where n is the length of the array
- **Space Complexity:** O(1) - in-place with only constant extra space (not counting the output copy)
