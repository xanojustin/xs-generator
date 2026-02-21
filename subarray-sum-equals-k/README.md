# Subarray Sum Equals K

## Problem
Given an array of integers `nums` and an integer `k`, return the total number of **continuous subarrays** whose sum equals `k`.

A continuous subarray is a contiguous sequence of elements from the array. For example, in `[1, 2, 3]`, the continuous subarrays are `[1]`, `[2]`, `[3]`, `[1, 2]`, `[2, 3]`, and `[1, 2, 3]`.

This problem is commonly solved using a **prefix sum with hash map** approach for optimal O(n) time complexity.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/subarray_sum.xs`):** Contains the solution logic

## Function Signature
- **Input:**
  - `nums` (int[]): Array of integers to search
  - `k` (int): Target sum value
- **Output:**
  - Returns (int): The total count of continuous subarrays with sum equal to k

## Algorithm Explanation

The solution uses the **prefix sum** technique:

1. Maintain a running sum (`current_sum`) as we iterate through the array
2. Use a hash map (`prefix_counts`) to store how many times each prefix sum has occurred
3. For each element, check if `(current_sum - k)` exists in the hash map
   - If it does, it means there's a subarray ending at the current position that sums to k
4. Update the hash map with the current prefix sum

**Why this works:** If `prefix_sum[j] - prefix_sum[i] = k`, then the subarray from index `i+1` to `j` sums to k.

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `nums: [1, 1, 1], k: 2` | `2` | Subarrays: `[1, 1]` (indices 0-1), `[1, 1]` (indices 1-2) |
| `nums: [1, 2, 3], k: 3` | `2` | Subarrays: `[1, 2]`, `[3]` |
| `nums: [], k: 0` | `0` | Edge case: empty array |
| `nums: [5], k: 5` | `1` | Edge case: single element matches |
| `nums: [5], k: 3` | `0` | Edge case: single element doesn't match |
| `nums: [3, 4, 7, 2, -3, 1, 4, 2], k: 7` | `4` | Boundary case: includes negative numbers |

## Complexity Analysis
- **Time Complexity:** O(n) — single pass through the array with O(1) hash map operations
- **Space Complexity:** O(n) — hash map stores at most n prefix sums
