# Sum of Subarray Minimums

## Problem
Given an array of integers `arr`, find the sum of `min(b)`, where `b` ranges over every (contiguous) subarray of `arr`. Since the answer may be large, return the answer modulo `10^9 + 7`.

A subarray is a contiguous sequence of elements within an array.

### Example
- Input: `[3, 1, 2, 4]`
- Output: `17`
- Explanation:
  - Subarrays: `[3], [1], [2], [4], [3,1], [1,2], [2,4], [3,1,2], [1,2,4], [3,1,2,4]`
  - Minimums: `3, 1, 2, 4, 1, 1, 2, 1, 1, 1`
  - Sum: `3 + 1 + 2 + 4 + 1 + 1 + 2 + 1 + 1 + 1 = 17`

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test input `[3, 1, 2, 4]`
- **Function (`function/sum_of_subarray_minimums.xs`):** Contains the solution using monotonic stack approach

## Function Signature
- **Input:** 
  - `arr` (int[]) - Array of integers
- **Output:** 
  - (int) - Sum of minimums of all subarrays, modulo 10^9 + 7

## Algorithm
The solution uses a **monotonic stack** approach for O(n) time complexity:

1. **Previous Less Element (PLE):** For each element, find the distance to the previous element that is strictly smaller
2. **Next Less Element (NLE):** For each element, find the distance to the next element that is smaller or equal
3. **Contribution:** Each element's contribution to the total sum is: `arr[i] × left_distance × right_distance`
4. **Result:** Sum all contributions modulo 10^9 + 7

This approach avoids enumerating all O(n²) subarrays explicitly.

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[3, 1, 2, 4]` | `17` | 10 subarrays, minimums sum to 17 |
| `[1]` | `1` | Single element, single subarray |
| `[11, 81, 94, 43, 3]` | `444` | Larger test with decreasing pattern |

### Edge Cases
- **Single element:** Returns the element itself
- **All same elements:** Each element contributes equally
- **Strictly decreasing:** Each element is minimum for all subarrays starting at it
- **Strictly increasing:** Each element is minimum for all subarrays ending at it

## Complexity
- **Time:** O(n) - Each element is pushed and popped from stack at most once
- **Space:** O(n) - For the left/right distance arrays and stack
