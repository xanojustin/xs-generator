# Bitwise ORs of Subarrays

## Problem

Given an integer array `arr`, return the number of distinct bitwise OR results of all the non-empty subarrays of `arr`.

A subarray is a contiguous non-empty sequence of elements within an array. The bitwise OR of a subarray is the result of OR-ing all elements in that subarray.

## Example

For input `[1, 2, 4]`:
- Subarray `[1]` → 1
- Subarray `[1, 2]` → 1 | 2 = 3
- Subarray `[1, 2, 4]` → 1 | 2 | 4 = 7
- Subarray `[2]` → 2
- Subarray `[2, 4]` → 2 | 4 = 6
- Subarray `[4]` → 4

Distinct OR values: {1, 2, 3, 4, 6, 7}

Result: **6**

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/bitwise_ors_of_subarrays.xs`):** Contains the solution logic

## Function Signature

- **Input:** 
  - `arr` (int[]): Array of integers
- **Output:** 
  - `int`: Count of distinct bitwise OR results from all subarrays

## Algorithm

The key insight is that for each position `i`, we only need to track OR values of subarrays ending at position `i`. When we extend a subarray by adding a new element, the OR can only increase or stay the same (since OR is monotonic).

For each element at position `i`:
1. Start a new subarray containing just `arr[i]`
2. Extend all subarrays ending at position `i-1` by OR-ing with `arr[i]`
3. Remove duplicates to keep the set minimal
4. Add all new OR values to the global distinct set

This gives us O(n × k) complexity where k is the number of distinct OR values at each position (which is bounded by log(max_value) since OR values can only increase).

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[1, 2, 4]` | 6 |
| `[0]` | 1 |
| `[1, 1, 1]` | 1 |
| `[1, 11, 89, 31, 9]` | 13 |

### Test Case Descriptions

1. **Basic case (`[1, 2, 4]`):** Standard test with distinct powers of 2
2. **Edge case (`[0]`):** Single element - only one subarray possible
3. **Edge case (`[1, 1, 1]`):** All same elements - all subarrays have same OR
4. **Interesting case (`[1, 11, 89, 31, 9]`):** Multiple overlapping OR values
