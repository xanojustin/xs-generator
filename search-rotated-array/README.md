# Search in Rotated Sorted Array

## Problem

There is an integer array `nums` sorted in ascending order (with distinct values).

Prior to being passed to your function, `nums` is possibly rotated at an unknown pivot index `k` (1 <= k < nums.length) such that the resulting array is:

`[nums[k], nums[k+1], ..., nums[n-1], nums[0], nums[1], ..., nums[k-1]]` (0-indexed)

For example, `[0,1,2,4,5,6,7]` might be rotated at pivot index 3 and become `[4,5,6,7,0,1,2]`.

Given the array `nums` after the possible rotation and an integer `target`, return the index of `target` if it is in `nums`, or `-1` if it is not in `nums`.

**Constraints:**
- The algorithm must run in O(log n) time complexity
- All values in `nums` are distinct
- 1 <= nums.length <= 5000

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/search_rotated_array.xs`):** Contains the modified binary search solution

## Function Signature

- **Input:**
  - `nums` (int[]): A sorted array that has been rotated at an unknown pivot, containing distinct integers
  - `target` (int): The value to search for in the array
- **Output:**
  - (int): The index of the target if found, otherwise -1

## Approach

This solution uses a modified binary search that handles the rotation:

1. Calculate the middle index
2. If the target is at the middle, return the index
3. Determine which half is sorted by comparing `nums[left]` with `nums[mid]`
4. If the left half is sorted:
   - Check if target lies within the left sorted range
   - If yes, search left; otherwise search right
5. If the right half is sorted:
   - Check if target lies within the right sorted range
   - If yes, search right; otherwise search left

This maintains O(log n) time complexity by eliminating half the search space each iteration, just like standard binary search.

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `nums: [4,5,6,7,0,1,2], target: 0` | `4` |
| `nums: [4,5,6,7,0,1,2], target: 3` | `-1` |
| `nums: [1], target: 0` | `-1` |
| `nums: [1,3], target: 3` | `1` |
| `nums: [5,1,3], target: 5` | `0` |

### Test Case Descriptions

1. **Basic case (target in rotated section):** Array `[4,5,6,7,0,1,2]` was rotated at index 4. Target `0` is found at index 4.
2. **Target not found:** Target `3` doesn't exist in the array.
3. **Edge case (single element):** Array with one element where target doesn't match.
4. **Edge case (two elements):** Small array where target is the second element.
5. **Boundary case (target at pivot):** Target is the first element (original pivot point).
