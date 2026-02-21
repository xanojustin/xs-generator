# Remove Element

## Problem
Given an integer array `nums` and an integer `val`, remove all occurrences of `val`. Return the number of elements in `nums` which are not equal to `val`.

Since XanoScript does not allow in-place modification of input arrays, we create a working copy and simulate the in-place modification. The function returns the count of valid elements (the new "length").

This is a classic array manipulation problem that tests understanding of:
- Two-pointer technique
- Array traversal and modification
- Edge case handling (empty arrays, all elements removed, no elements removed)

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/remove_element.xs`):** Contains the two-pointer solution logic

## Function Signature
- **Input:**
  - `nums` (int[]): The input array of integers
  - `val` (int): The value to remove from the array
- **Output:** (int) The number of elements remaining after removing all instances of `val`

## Algorithm
The solution uses the **two-pointer technique** for O(n) time complexity:

1. Create a working copy of the input array
2. Initialize a `write` pointer at index 0
3. Iterate through the original array with a foreach loop
4. When the current element is NOT equal to `val`:
   - Copy it to the `write` position in the working array
   - Increment the `write` pointer
5. Return the `write` pointer value (represents the new length)

Note: In a true in-place implementation, this would be O(1) space. In XanoScript, we use O(n) space to create a working copy since input variables cannot be modified directly.

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `nums: [3, 2, 2, 3], val: 3` | `2` (keeps `[2, 2]`) |
| `nums: [0, 1, 2, 2, 3, 0, 4, 2], val: 2` | `5` (keeps `[0, 1, 3, 0, 4]`) |
| `nums: [], val: 1` | `0` (empty array) |
| `nums: [1, 1, 1, 1], val: 1` | `0` (all elements removed) |
| `nums: [1, 2, 3, 4, 5], val: 6` | `5` (no elements removed) |
| `nums: [4], val: 4` | `0` (single element, removed) |
| `nums: [4], val: 5` | `1` (single element, kept) |

## Complexity Analysis
- **Time Complexity:** O(n) - single pass through the array
- **Space Complexity:** O(n) - working copy of the array (would be O(1) in true in-place implementation)

## Why Two Pointers?
This approach is optimal because:
1. It processes each element exactly once
2. It maintains the relative order of non-matching elements
3. It's a common interview pattern for array manipulation problems
4. Even with the working copy, it demonstrates the core algorithm clearly

## LeetCode Reference
This problem is LeetCode #27: https://leetcode.com/problems/remove-element/
