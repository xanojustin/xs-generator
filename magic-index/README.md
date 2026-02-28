# Magic Index

## Problem

A **magic index** in an array is defined as an index `i` such that `arr[i] == i`. In other words, the value at the index equals the index itself.

Given a **sorted array of distinct integers**, write a function to find a magic index if one exists. If there are multiple magic indices, return the leftmost (smallest) one. Return `null` if no magic index exists.

### Example
- Array `[-1, 0, 2, 4, 5]` has a magic index at position `2` because `arr[2] == 2`
- Array `[0, 2, 4, 6]` has a magic index at position `0` because `arr[0] == 0`
- Array `[1, 2, 3, 4]` has no magic index

### Algorithm Note
Since the array is sorted and contains distinct elements, we can use a modified binary search approach to achieve O(log n) time complexity instead of the naive O(n) linear scan.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/magic_index.xs`):** Contains the solution logic using modified binary search

## Function Signature

- **Input:** 
  - `nums` (int[]): A sorted array of distinct integers
- **Output:** 
  - `int|null`: The leftmost magic index if found, otherwise `null`

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[-1, 0, 2, 4, 5]` | `2` | `nums[2] == 2`, magic index found |
| `[-10, -5, 0, 3, 7]` | `3` | `nums[3] == 3`, magic index found |
| `[0, 2, 4, 6, 8]` | `0` | `nums[0] == 0`, magic at first element |
| `[-2, -1, 0, 1, 4]` | `4` | `nums[4] == 4`, magic at last element |
| `[1, 2, 3, 4, 5]` | `null` | No magic index exists |
| `[]` | `null` | Empty array edge case |
| `[5]` | `null` | Single element, no magic |
| `[0]` | `0` | Single element with magic |

## Complexity Analysis

- **Time Complexity:** O(log n) - Modified binary search
- **Space Complexity:** O(1) - Only using a few variables

## Why Binary Search Works

In a sorted array with distinct elements:
- If `arr[mid] > mid`, then for all `j > mid`, we know `arr[j] >= arr[mid] + (j - mid) > j`, so no magic index can exist to the right
- If `arr[mid] < mid`, then for all `j < mid`, we know `arr[j] <= arr[mid] - (mid - j) < j`, so no magic index can exist to the left

This allows us to eliminate half the search space at each step, just like standard binary search.
