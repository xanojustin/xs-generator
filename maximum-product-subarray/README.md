# Maximum Product Subarray

## Problem
Given an integer array `nums`, find a contiguous non-empty subarray that has the largest product, and return the product.

The subarray must contain at least one number.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/maximum-product-subarray.xs`):** Contains the solution logic

## Function Signature
- **Input:** 
  - `nums` (int[]): Array of integers that can contain positive, negative numbers, and zeros
- **Output:** 
  - Integer representing the maximum product of any contiguous subarray

## Algorithm
This solution uses a dynamic programming approach that tracks both the maximum and minimum product ending at each position:

1. **Track both max and min:** Since multiplying by a negative number flips the sign, the minimum product can become the maximum when multiplied by a negative number.

2. **For each element**, calculate:
   - New max: `max(current, max_so_far * current, min_so_far * current)`
   - New min: `min(current, max_so_far * current, min_so_far * current)`

3. **Update global maximum** after processing each element.

### Time & Space Complexity
- **Time:** O(n) - single pass through the array
- **Space:** O(1) - only tracking a few variables

## Test Cases
| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[2, 3, -2, 4]` | `6` | Subarray `[2, 3]` gives product 6 |
| `[-2, 0, -1]` | `0` | Subarray `[0]` gives product 0 (better than -2 or -1) |
| `[-2]` | `-2` | Single element (must pick at least one) |
| `[0, 2]` | `2` | Skip the 0, take `[2]` |
| `[-1, -2, -9, -6]` | `108` | Subarray `[-2, -9, -6]` gives product 108 |
| `[-2, 3, -4]` | `24` | Entire array: -2 * 3 * -4 = 24 |

## Why This Problem Is Interesting
Unlike the maximum sum subarray (Kadane's algorithm), tracking only the maximum isn't enough. A negative number multiplied by a large negative minimum can produce a large positive maximum. This requires tracking both extremes at each step.
