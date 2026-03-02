# Maximum Average Subarray I

## Problem
Given an integer array `nums` consisting of `n` elements and an integer `k`, find a contiguous subarray whose length is equal to `k` that has the maximum average value and return this value. Any answer with a calculation error less than `10^-5` will be accepted.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/max_average_subarray.xs`):** Contains the solution logic using the sliding window technique

## Function Signature
- **Input:**
  - `nums` (int[]): Array of integers
  - `k` (int): Length of the subarray to find
- **Output:**
  - Returns a decimal representing the maximum average value of any contiguous subarray of length `k`

## Approach
This solution uses the **sliding window technique** for O(n) time complexity:

1. Calculate the sum of the first window (first k elements)
2. Slide the window one element at a time:
   - Subtract the element leaving the window (left side)
   - Add the element entering the window (right side)
   - Track the maximum sum seen
3. Return max_sum / k as the maximum average

This is more efficient than O(n*k) brute force because we only traverse the array once.

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| nums = [1, 12, -5, -6, 50, 3], k = 4 | 12.75 |
| nums = [5], k = 1 | 5.0 |
| nums = [0, 4, 0, 3, 2], k = 1 | 4.0 |
| nums = [4, 2, 1, 3, 5], k = 2 | 4.0 |

### Explanation of Test Cases
1. **Basic case:** Subarray [12, -5, -6, 50] has sum 51, average = 12.75
2. **Edge case (single element):** Only one element to consider
3. **Edge case (k=1):** Maximum single element in the array
4. **Mixed values:** Subarray [3, 5] has maximum average of 4.0
