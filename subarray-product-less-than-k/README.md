# Subarray Product Less Than K

## Problem

Given an array of positive integers `nums` and an integer `k`, return the number of (contiguous) subarrays where the product of all the elements in the subarray is strictly less than `k`.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/subarray_product_less_than_k.xs`):** Contains the sliding window solution logic

## Function Signature

- **Input:**
  - `nums` (int[]): Array of positive integers
  - `k` (int): Threshold value for the product
- **Output:**
  - `count` (int): Number of contiguous subarrays with product strictly less than `k`

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| nums = [10,5,2,6], k = 100 | 8 |
| nums = [1,2,3], k = 0 | 0 |
| nums = [], k = 100 | 0 |
| nums = [5], k = 10 | 1 |
| nums = [5], k = 5 | 0 |

### Explanation of Test Cases

1. **Basic case:** [10,5,2,6] with k=100 has 8 valid subarrays: [10], [5], [2], [6], [5,2], [2,6], [5,2,6], [10,5]
2. **Edge case with k=0:** Since all numbers are positive, no product can be < 0
3. **Empty array:** No subarrays possible
4. **Single element valid:** [5] with k=10, product is 5 < 10
5. **Single element invalid:** [5] with k=5, product is 5 which is not strictly less than 5

## Algorithm

This solution uses the **sliding window technique** for O(n) time complexity:

1. Maintain a window [left, right] where the product of all elements is < k
2. Expand the window by moving `right` pointer, multiplying the running product
3. If product >= k, shrink window from left by dividing product and moving `left`
4. For each valid position of `right`, all subarrays ending at `right` with start in [left, right] are valid
5. Add `(right - left + 1)` to count for each iteration

**Time Complexity:** O(n) - each element is visited at most twice (once by right, once by left)
**Space Complexity:** O(1) - only using a few variables
