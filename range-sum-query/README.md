# Range Sum Query - Immutable

## Problem

Given an integer array `nums`, handle multiple queries of the form: sum of elements between indices `left` and `right` (inclusive), where `left <= right`.

Implement the `range_sum_query` function that efficiently computes range sums. Since the array is immutable (never changes after creation), we can use **prefix sums** to answer each query in O(1) time after O(n) preprocessing.

### Algorithm

1. **Precompute prefix sums**: Create an array `prefix` where `prefix[i]` equals the sum of all elements from index 0 to i-1 (i.e., `prefix[0] = 0`, `prefix[1] = nums[0]`, `prefix[2] = nums[0] + nums[1]`, etc.)

2. **Answer queries**: To find the sum of elements from `left` to `right` (inclusive), use: `prefix[right + 1] - prefix[left]`

This approach reduces each query from O(n) to O(1) time complexity.

## Structure

- **Run Job (`run.xs`):** Calls the `run_tests` function to execute all test cases
- **Function (`function/range_sum_query.xs`):** Contains the solution logic with prefix sum computation
- **Test Runner (`function/run_tests.xs`):** Helper function that runs multiple test cases and returns results

## Function Signature

- **Input:**
  - `nums` (int[]): The immutable integer array to query
  - `left` (int): Starting index (inclusive), must be >= 0
  - `right` (int): Ending index (inclusive), must be >= left and < length of nums

- **Output:**
  - Returns (int): The sum of elements `nums[left] + nums[left+1] + ... + nums[right]`

## Test Cases

| Test | nums | left | right | Expected Output | Description |
|------|------|------|-------|-----------------|-------------|
| 1 | [-2, 0, 3, -5, 2, -1] | 0 | 2 | 1 | Sum of first 3 elements: -2 + 0 + 3 = 1 |
| 2 | [-2, 0, 3, -5, 2, -1] | 2 | 5 | -1 | Sum of middle 4 elements: 3 + (-5) + 2 + (-1) = -1 |
| 3 | [-2, 0, 3, -5, 2, -1] | 0 | 5 | -3 | Sum of entire array: -2 + 0 + 3 + (-5) + 2 + (-1) = -3 |
| 4 | [-2, 0, 3, -5, 2, -1] | 3 | 3 | -5 | Single element at index 3 |
| 5 | [5] | 0 | 0 | 5 | Edge case: single element array |
| 6 | [1, 2] | 0 | 1 | 3 | Edge case: two element array |

## Complexity Analysis

- **Preprocessing Time:** O(n) where n is the length of nums
- **Query Time:** O(1) per query
- **Space Complexity:** O(n) for the prefix sum array

## Example

```xs
// Query: sum of elements from index 0 to 2
function.run "range_sum_query" {
  input = {
    nums: [-2, 0, 3, -5, 2, -1]
    left: 0
    right: 2
  }
} as $result

// $result = 1 (because -2 + 0 + 3 = 1)
```
