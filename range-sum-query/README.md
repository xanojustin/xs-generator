# Range Sum Query

## Problem
Given an integer array `nums`, handle multiple queries asking for the sum of elements between indices `left` and `right` (inclusive).

The naive approach of summing elements for each query would be O(n) per query. We can optimize this to O(1) per query by precomputing a **prefix sum array**.

### Prefix Sum Approach
- Build an array `prefix` where `prefix[i]` represents the sum of all elements from index 0 to i-1
- `prefix[0] = 0` (sum of zero elements)
- `prefix[i+1] = prefix[i] + nums[i]`
- Range sum from `left` to `right` = `prefix[right+1] - prefix[left]`

**Example:**
- Input: `nums = [-2, 0, 3, -5, 2, -1]`, query `(0, 2)`
- Prefix array: `[0, -2, -2, 1, -4, -2, -3]`
- Range sum = `prefix[3] - prefix[0] = 1 - 0 = 1`
- Verification: `-2 + 0 + 3 = 1` ✓

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/range_sum_query.xs`):** Contains the prefix sum solution logic

## Function Signature
- **Input:**
  - `nums: int[]` - Array of integers
  - `left: int` - Left index (inclusive, 0-based)
  - `right: int` - Right index (inclusive, 0-based)
- **Output:** `int` - Sum of elements from index left to right (inclusive)

## Test Cases

| nums | left | right | Expected Output |
|------|------|-------|-----------------|
| `[-2, 0, 3, -5, 2, -1]` | 0 | 2 | 1 |
| `[-2, 0, 3, -5, 2, -1]` | 2 | 5 | -1 |
| `[-2, 0, 3, -5, 2, -1]` | 0 | 5 | -3 |
| `[5]` | 0 | 0 | 5 |
| `[1, 2, 3, 4, 5]` | 1 | 3 | 9 |

### Test Case Explanations
1. **Basic case:** Sum of first 3 elements: `-2 + 0 + 3 = 1`
2. **Middle range:** Sum from index 2 to 5: `3 + (-5) + 2 + (-1) = -1`
3. **Full array:** Sum of all elements: `-2 + 0 + 3 + (-5) + 2 + (-1) = -3`
4. **Edge case (single element):** Array with one element
5. **Positive numbers:** Sum of middle elements: `2 + 3 + 4 = 9`

## Complexity Analysis
- **Preprocessing Time:** O(n) to build prefix sum array
- **Query Time:** O(1) per query
- **Space Complexity:** O(n) for the prefix sum array

## Applications
- Range sum queries in immutable arrays
- Building blocks for 2D range sum queries (integral image)
- Cumulative frequency tables
