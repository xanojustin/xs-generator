# Maximum Subarray Sum (Circular)

## Problem

Given an integer array `nums` arranged in a **circular** fashion (where the end connects to the beginning), find the maximum possible sum of a non-empty subarray.

A circular array means that the subarray can wrap around from the end of the array to the beginning. For example, in `[5, -3, 5]`, the subarray `[5, 5]` (wrapping around the -3) is valid and sums to 10.

### Key Insight

For a circular array, the maximum subarray sum is either:
1. **Non-circular case**: The regular maximum subarray sum (found using Kadane's algorithm)
2. **Circular case**: The total sum of all elements minus the minimum subarray sum (this represents the subarray that wraps around)

Edge case: If all numbers are negative, the circular case would incorrectly return 0 (total - min = 0), so we must only return the regular maximum subarray in this case.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with 8 test inputs and logs the results
- **Function (`function/max_subarray_circular.xs`):** Contains the solution logic using a modified Kadane's algorithm

## Function Signature

- **Input:**
  - `nums` (int[]): An array of integers (can contain positive, negative, or zero values)
  
- **Output:**
  - `result` (int): The maximum subarray sum considering the circular nature of the array

## Algorithm

The solution uses two passes of Kadane's algorithm:

1. **First pass**: Find the maximum subarray sum (standard Kadane's)
2. **Second pass**: Find the minimum subarray sum (reverse Kadane's)
3. **Calculate total sum** of all elements
4. **Compare**:
   - If all elements are negative (total == min), return max_subarray
   - Otherwise, return max(max_subarray, total - min_subarray)

### Time Complexity: O(n)
### Space Complexity: O(1)

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[5, -3, 5]` | `10` | `5 + 5` (wraps around) |
| `[1, -2, 3, -2]` | `3` | Just the single element `3` |
| `[3, -2, 2, -3]` | `3` | Either `[3]` or `[3, -2, 2]` |
| `[-2, -3, -1]` | `-1` | Largest single element (edge case: all negative) |
| `[5]` | `5` | Single element edge case |
| `[8, -1, 3, 4]` | `15` | `8 + 3 + 4` (wraps around, skipping -1) |
| `[1, 2]` | `3` | `1 + 2` (sum of all elements) |
| `[5, -2, 3, 4, -5]` | `12` | `3 + 4 + 5` (wraps around, skipping negatives) |

## Example Usage

```xs
// Call from another function or run job
function.run "max_subarray_circular" {
  input = { nums: [5, -3, 5] }
} as $result

// $result will be 10
```
