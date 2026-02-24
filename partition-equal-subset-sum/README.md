# Partition Equal Subset Sum

## Problem

Given an array of positive integers, determine if the array can be partitioned into two subsets such that the sum of elements in both subsets is equal.

**Key Insight:** This is equivalent to finding a subset that sums to exactly half of the total sum. If the total sum is odd, it's impossible to partition equally.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/partition_equal_subset_sum.xs`):** Contains the dynamic programming solution logic

## Function Signature

- **Input:** `nums` - An array of positive integers (int[])
- **Output:** Boolean - `true` if the array can be partitioned into two subsets with equal sum, `false` otherwise

## Algorithm

The solution uses **Dynamic Programming** with the following approach:

1. **Calculate Total Sum:** Sum all elements in the array
2. **Check Odd Sum:** If total sum is odd, return `false` immediately (cannot split odd sum equally)
3. **Set Target:** Target = total_sum / 2
4. **Edge Cases:** Handle empty array, single element, and elements larger than target
5. **DP Array:** Create a boolean array `dp` where `dp[i]` represents whether sum `i` can be achieved
6. **Fill DP Array:** For each number, update the dp array backwards to mark achievable sums
7. **Return Result:** `dp[target]` indicates if we can achieve the target sum

**Time Complexity:** O(n × target) where n is array length and target is sum/2
**Space Complexity:** O(target) for the dp array

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[1, 5, 11, 5]` | `true` | Can partition into [1, 5, 5] and [11], both sum to 11 |
| `[1, 2, 3, 5]` | `false` | Total sum is 11 (odd), cannot partition equally |
| `[1, 2, 5]` | `false` | Total sum is 8, target is 4, no subset sums to 4 |
| `[]` | `false` | Empty array cannot be partitioned |
| `[1]` | `false` | Single element cannot be partitioned |
| `[1, 1]` | `true` | Can partition into [1] and [1] |
| `[3, 3, 3, 4, 5]` | `true` | Can partition into [3, 3, 4] and [3, 5], both sum to 10 |
