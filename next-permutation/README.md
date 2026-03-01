# Next Permutation

## Problem

Given an array of integers, rearrange the numbers into the **lexicographically next greater permutation** of numbers. If such an arrangement is not possible (i.e., the array is in descending order), the array must be rearranged to the lowest possible order (i.e., sorted in ascending order).

The replacement must be **in-place** and use only constant extra memory.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/next_permutation.xs`):** Contains the solution logic implementing the next permutation algorithm

## Function Signature

- **Input:** 
  - `nums` (int[]): Array of integers to find next permutation for
- **Output:** 
  - `result` (int[]): The next lexicographical permutation of the input array

## Algorithm

The solution follows the classic next permutation algorithm:

1. **Find the pivot:** Scan from right to left to find the first element that is smaller than its next element (call this index `i`). This identifies where the ordering breaks.

2. **Find the successor:** If a pivot exists, scan from right to left again to find the smallest element larger than `nums[i]` (call this index `j`).

3. **Swap:** Swap the elements at indices `i` and `j`.

4. **Reverse suffix:** Reverse the sub-array starting from index `i+1` to the end. This gives the smallest possible ordering for the suffix, ensuring we get the next permutation, not just any larger one.

5. **No pivot case:** If no pivot is found (array is in descending order), the entire array is reversed to get the lowest order (ascending).

## Test Cases

| Input | Expected Output | Description |
|-------|-----------------|-------------|
| `[1, 2, 3]` | `[1, 3, 2]` | Basic case - next permutation |
| `[3, 2, 1]` | `[1, 2, 3]` | Descending order - wraps to ascending |
| `[1, 1, 5]` | `[1, 5, 1]` | With duplicates |
| `[1]` | `[1]` | Single element - edge case |
| `[]` | `[]` | Empty array - edge case |
| `[2, 3, 1]` | `[3, 1, 2]` | Pivot not at end |

## Time & Space Complexity

- **Time Complexity:** O(n) - Single pass to find pivot, single pass to find successor, and single pass to reverse suffix
- **Space Complexity:** O(n) - We create new arrays during manipulation (in a true in-place implementation this would be O(1))
