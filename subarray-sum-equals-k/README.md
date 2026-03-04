# Subarray Sum Equals K

## Problem
Given an array of integers `nums` and an integer `k`, return the total number of continuous subarrays whose sum equals to `k`.

A subarray is a contiguous non-empty sequence of elements within an array.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/subarray_sum_equals_k.xs`):** Contains the solution logic using prefix sum with hash map

## Function Signature
- **Input:**
  - `nums` (int[]): Array of integers
  - `k` (int): Target sum value
- **Output:**
  - `count` (int): Number of subarrays with sum equal to k

## Algorithm
This solution uses the **prefix sum** technique with a hash map for O(n) time complexity:

1. Maintain a running prefix sum as we iterate through the array
2. Use a hash map to store the frequency of each prefix sum encountered
3. For each position, check if `(prefix_sum - k)` exists in the map
   - If yes, it means there are that many subarrays ending at current position with sum = k
4. Update the frequency of the current prefix sum in the map

**Time Complexity:** O(n) where n is the length of the array
**Space Complexity:** O(n) for storing prefix sum frequencies

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `nums: [1, 1, 1], k: 2` | `2` | Subarrays: `[1,1]` (indices 0-1) and `[1,1]` (indices 1-2) |
| `nums: [1, 2, 3], k: 3` | `2` | Subarrays: `[1,2]` and `[3]` |
| `nums: [], k: 0` | `0` | Empty array has no subarrays |
| `nums: [5], k: 5` | `1` | Single element equals k |
| `nums: [1, -1, 0], k: 0` | `3` | Subarrays: `[1,-1]`, `[-1,0]`, and `[1,-1,0]` |
| `nums: [3, 4, 7, 2, -3, 1, 4, 2], k: 7` | `4` | Multiple subarrays sum to 7 |

## Example Walkthrough

For `nums = [1, 1, 1]`, `k = 2`:

1. Initialize: `prefix_sum = 0`, `prefix_counts = {"0": 1}`, `count = 0`
2. i=0: num=1, `prefix_sum = 1`, need `(1-2) = -1` (not in map), update map: `{"0": 1, "1": 1}`
3. i=1: num=1, `prefix_sum = 2`, need `(2-2) = 0` (found with freq 1), `count = 1`, update map: `{"0": 1, "1": 1, "2": 1}`
4. i=2: num=1, `prefix_sum = 3`, need `(3-2) = 1` (found with freq 1), `count = 2`, update map: `{"0": 1, "1": 1, "2": 1, "3": 1}`

Final result: **2** subarrays with sum = 2
