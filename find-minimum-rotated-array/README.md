# Find Minimum in Rotated Sorted Array

## Problem

Suppose an array of length `n` sorted in ascending order is rotated between `1` and `n` times. For example, the array `nums = [0,1,2,4,5,6,7]` might become:

- `[4,5,6,7,0,1,2]` if it was rotated `4` times
- `[0,1,2,4,5,6,7]` if it was rotated `7` times (back to original)

Given the rotated sorted array `nums` of **unique** elements, return the minimum element of this array.

The algorithm must run in `O(log n)` time using a modified binary search approach.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/find_minimum_rotated.xs`):** Contains the solution logic using binary search

## Function Signature

- **Input:**
  - `nums` (int[]): A rotated sorted array of unique integers
  
- **Output:**
  - `result` (int or null): The minimum element in the array, or `null` if the array is empty

## Algorithm Explanation

The solution uses a modified binary search:

1. **Compare middle element with rightmost element** to determine which half contains the minimum
2. **If `nums[mid] < nums[right]`**: The right side is sorted, so the minimum must be on the left side (including mid or before it)
3. **If `nums[mid] > nums[right]`**: The left side is sorted, so the minimum must be on the right side (after mid)
4. **Track the minimum value** seen so far during the search

This achieves O(log n) time complexity by halving the search space each iteration.

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[3, 4, 5, 1, 2]` | `1` | Rotated at pivot 1; minimum is 1 |
| `[4, 5, 6, 7, 0, 1, 2]` | `0` | Rotated at pivot 0; minimum is 0 |
| `[11, 13, 15, 17]` | `11` | Not rotated (rotated n times); minimum is first element |
| `[2, 1]` | `1` | Two elements, rotated once |
| `[1]` | `1` | Single element edge case |
| `[]` | `null` | Empty array edge case |
| `[1, 2, 3, 4, 5]` | `1` | Not rotated; minimum is first element |
