# Shortest Unsorted Continuous Subarray

## Problem
Given an integer array `nums`, find the length of the shortest continuous subarray that needs to be sorted in ascending order to make the whole array sorted.

For example, in the array `[2, 6, 4, 8, 10, 9, 15]`:
- The subarray `[6, 4, 8, 10, 9]` is out of order
- If we sort just this subarray to `[4, 6, 8, 9, 10]`, the whole array becomes `[2, 4, 6, 8, 9, 10, 15]` which is sorted
- The length of this subarray is 5

## Structure
- **Run Job (`run.xs`):** Calls the test function which runs multiple test cases
- **Function (`function/shortest_unsorted_subarray.xs`):** Contains the solution logic
- **Test Function (`function/run_tests.xs`):** Runs test cases and logs results

## Function Signature
- **Input:**
  - `nums` (int[]): Array of integers
- **Output:**
  - Returns (int): The length of the shortest unsorted continuous subarray. Returns 0 if the array is already sorted.

## Algorithm
1. Find the first element from the left that is out of order (where `nums[i] > nums[i+1]`)
2. Find the first element from the right that is out of order (where `nums[i] < nums[i-1]`)
3. Find the minimum and maximum values in the subarray between these boundaries
4. Extend the left boundary leftwards while there are elements greater than the minimum
5. Extend the right boundary rightwards while there are elements less than the maximum
6. Return the length of the resulting subarray

## Test Cases
| Input | Expected Output |
|-------|-----------------|
| `[2, 6, 4, 8, 10, 9, 15]` | 5 |
| `[1, 2, 3, 4]` | 0 (already sorted) |
| `[1]` | 0 (single element) |
| `[3, 2, 1]` | 3 (entire array) |
| `[1, 3, 2, 4, 5]` | 2 |
| `[]` | 0 (empty array) |

## Complexity
- **Time Complexity:** O(n) - Single pass to find boundaries, plus passes to extend boundaries
- **Space Complexity:** O(1) - Only using a constant amount of extra space
