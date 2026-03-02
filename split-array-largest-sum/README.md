# Split Array Largest Sum

## Problem

Given an array `nums` which consists of non-negative integers and an integer `m`, you can split the array into `m` non-empty continuous subarrays. Write an algorithm to minimize the largest sum among these `m` subarrays.

### Example
- **Input:** nums = [7, 2, 5, 10, 8], m = 2
- **Output:** 18
- **Explanation:** The best way is to split it into [7, 2, 5] and [10, 8], where the largest sum among the two subarrays is 18.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/split_array_largest_sum.xs`):** Contains the solution logic using binary search

## Function Signature

- **Input:**
  - `nums` (int[]): Array of non-negative integers to split
  - `m` (int): Number of subarrays to split into (minimum 1)
- **Output:**
  - (int): The minimized largest sum among the m subarrays

## Algorithm

This solution uses **binary search on the answer**:

1. The minimum possible largest sum is the maximum element in the array (at least one element must be in a subarray by itself)
2. The maximum possible largest sum is the sum of all elements (when m = 1)
3. Binary search between these bounds to find the smallest value where we can split the array into at most m subarrays

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| nums = [7, 2, 5, 10, 8], m = 2 | 18 | Split into [7,2,5]=14 and [10,8]=18 |
| nums = [1, 2, 3, 4, 5], m = 2 | 9 | Split into [1,2,3]=6 and [4,5]=9 |
| nums = [1, 4, 4], m = 3 | 4 | Each element in its own subarray |
| nums = [5], m = 1 | 5 | Single element array |
| nums = [1, 2, 3], m = 1 | 6 | Entire array as one subarray |
