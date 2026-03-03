# Continuous Subarray Sum

## Problem
Given an integer array `nums` and an integer `k`, check if the array has a **continuous subarray** of size at least 2 whose elements sum up to a multiple of `k`.

More formally, check if there exists a subarray `nums[i..j]` where:
- `j - i + 1 >= 2` (subarray has at least 2 elements)
- The sum of elements in the subarray is divisible by `k`

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/check_subarray_sum.xs`):** Contains the solution logic using prefix sum + modulo trick

## Function Signature
- **Input:** 
  - `nums` (int[]): The integer array to check
  - `k` (int): The divisor to check against
- **Output:** 
  - `has_subarray` (bool): True if a valid continuous subarray exists, false otherwise

## Algorithm
The solution uses the **prefix sum + modulo** trick:
- If `prefix_sum[j] % k == prefix_sum[i] % k`, then the subarray from `i+1` to `j` has a sum divisible by `k`
- We store the first occurrence of each modulo value in a hash map
- If we see the same modulo again at index `j`, and `j - i >= 2`, we found a valid subarray
- Special case when `k = 0`: look for two consecutive zeros (since modulo by 0 is undefined)

## Test Cases
| Input | Expected Output |
|-------|-----------------|
| `nums: [23, 2, 4, 6, 7]`, `k: 6` | `has_subarray: true` (2+4=6, or 6 itself) |
| `nums: [23, 2, 6, 4, 7]`, `k: 6` | `has_subarray: true` (23+2+6+4+7=42, divisible by 6) |
| `nums: [23, 2, 6, 4, 7]`, `k: 13` | `has_subarray: false` |
| `nums: [0, 0]`, `k: 0` | `has_subarray: true` (two consecutive zeros) |
| `nums: [1]`, `k: 1` | Error: Array must contain at least 2 elements |

## Time & Space Complexity
- **Time Complexity:** O(n) where n is the length of nums
- **Space Complexity:** O(k) for the hash map (at most k different modulos)
