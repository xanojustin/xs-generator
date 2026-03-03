# Check If Array Is Sorted And Rotated

## Problem

Given an array `nums`, determine whether it was originally sorted in non-decreasing order, and then rotated some number of times (including zero).

An array is **sorted and rotated** if:
- It was originally sorted in non-decreasing order (e.g., `[1, 2, 3, 4, 5]`)
- It was then rotated some number of times to the right

For example:
- `[1, 2, 3, 4, 5]` is sorted (0 rotations)
- `[5, 1, 2, 3, 4]` is sorted and rotated 1 time
- `[3, 4, 5, 1, 2]` is sorted and rotated 3 times
- `[2, 1, 3, 4]` is NOT sorted and rotated (would break the sorted order)

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/check_sorted_rotated.xs`):** Contains the solution logic

## Function Signature

- **Input:** 
  - `nums` (int[]): The array to check
- **Output:** 
  - `bool`: `true` if the array is sorted and rotated, `false` otherwise

## Algorithm

The key insight is that in a sorted and rotated array, there can be at most **one** "pivot point" where a number is greater than the next number (the rotation point). 

For example:
- `[3, 4, 5, 1, 2]` has one pivot: 5 > 1 (the rotation point)
- `[1, 2, 3, 4, 5]` has zero pivots (already sorted)
- `[2, 1, 3, 4]` has one pivot: 2 > 1, but 4 > 2 is also a wrap-around violation

The algorithm:
1. If array length ≤ 1, return `true`
2. Count how many times `nums[i] > nums[i+1]` (using modulo for wrap-around)
3. If pivot count ≤ 1, return `true`; otherwise return `false`

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[3, 4, 5, 1, 2]` | `true` | Originally `[1, 2, 3, 4, 5]`, rotated 3 times |
| `[2, 1, 3, 4]` | `false` | Not a valid rotation - breaks sorted order |
| `[1, 2, 3]` | `true` | Already sorted, 0 rotations |
| `[1]` | `true` | Single element, always true |
| `[]` | `true` | Empty array, edge case |
| `[5, 5, 5, 5]` | `true` | All equal elements, always true |
| `[6, 7, 1, 2, 3, 4, 5]` | `true` | Originally `[1, 2, 3, 4, 5, 6, 7]`, rotated 2 times |
