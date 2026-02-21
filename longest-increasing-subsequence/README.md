# Longest Increasing Subsequence

## Problem
Given an array of integers, find the length of the longest **strictly increasing subsequence**.

A **subsequence** is a sequence that can be derived from an array by deleting some or no elements without changing the order of the remaining elements. For example, `[3, 5, 7]` is a subsequence of `[10, 9, 2, 5, 3, 7, 101, 18]`.

A **strictly increasing subsequence** is a subsequence where each element is greater than the previous one.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/longest_increasing_subsequence.xs`):** Contains the solution logic using dynamic programming

## Function Signature
- **Input:**
  - `nums` (int[]): Array of integers to find the LIS in
- **Output:**
  - `int`: Length of the longest strictly increasing subsequence

## Algorithm
This solution uses **dynamic programming** with O(n²) time complexity:

1. Create a `dp` array where `dp[i]` represents the length of the longest increasing subsequence ending at index `i`
2. Initialize all `dp` values to 1 (each element is a subsequence of length 1)
3. For each element at index `i`, look at all previous elements at index `j` (where `j < i`)
4. If `nums[j] < nums[i]`, we can extend the subsequence ending at `j` by including `nums[i]`
5. Update `dp[i]` to be the maximum of its current value and `dp[j] + 1`
6. Return the maximum value in the `dp` array

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[10, 9, 2, 5, 3, 7, 101, 18]` | 4 | The LIS is `[2, 3, 7, 101]` |
| `[0, 1, 0, 3, 2, 3]` | 4 | The LIS is `[0, 1, 2, 3]` |
| `[7, 7, 7, 7, 7, 7, 7]` | 1 | All elements are equal, so LIS is any single element |
| `[]` | 0 | Empty array has no subsequence |
| `[1]` | 1 | Single element array |
| `[1, 2, 3, 4, 5]` | 5 | Already strictly increasing |
| `[5, 4, 3, 2, 1]` | 1 | Strictly decreasing, so LIS is any single element |

## Example
```
Input: [10, 9, 2, 5, 3, 7, 101, 18]

DP array evolution:
- Start: [1, 1, 1, 1, 1, 1, 1, 1]
- i=1:  [1, 1, 1, 1, 1, 1, 1, 1]  (9 < 10, no update)
- i=2:  [1, 1, 1, 1, 1, 1, 1, 1]  (2 is smallest)
- i=3:  [1, 1, 1, 2, 1, 1, 1, 1]  (5 > 2, dp[3] = dp[2] + 1 = 2)
- i=4:  [1, 1, 1, 2, 2, 1, 1, 1]  (3 > 2, dp[4] = dp[2] + 1 = 2)
- i=5:  [1, 1, 1, 2, 2, 3, 1, 1]  (7 > 2,3,5; dp[5] = max(dp[2],dp[4],dp[3])+1 = 3)
- i=6:  [1, 1, 1, 2, 2, 3, 4, 1]  (101 > all previous; dp[6] = 4)
- i=7:  [1, 1, 1, 2, 2, 3, 4, 4]  (18 > 2,3,5,7; dp[7] = 4)

Result: max(dp) = 4
```
