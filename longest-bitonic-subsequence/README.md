# Longest Bitonic Subsequence

## Problem

Given an array of integers, find the length of the **longest bitonic subsequence**.

A **bitonic sequence** is a sequence that is first strictly increasing and then strictly decreasing. A sequence sorted in increasing order is considered bitonic with the decreasing part as empty. Similarly, a sequence sorted in decreasing order is considered bitonic with the increasing part as empty.

A **subsequence** is a sequence that can be derived from another sequence by deleting some or no elements without changing the order of the remaining elements.

### Example

For the array `[1, 11, 2, 10, 4, 5, 2, 1]`, one longest bitonic subsequence is `[1, 2, 4, 5, 2, 1]` with length 6. The sequence increases from 1 to 5, then decreases to 1.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/longest_bitonic_subsequence.xs`):** Contains the solution logic using dynamic programming

## Function Signature

- **Input:**
  - `nums` (int[]): Array of integers
- **Output:**
  - `length` (int): Length of the longest bitonic subsequence

## Algorithm

The solution uses dynamic programming with two passes:

1. **LIS (Longest Increasing Subsequence) from left to right:**
   - `lis[i]` = length of longest increasing subsequence ending at index `i`
   
2. **LDS (Longest Decreasing Subsequence) from right to left:**
   - `lds[i]` = length of longest decreasing subsequence starting at index `i`

3. **Combine results:**
   - For each position `i`, the longest bitonic subsequence with peak at `i` is `lis[i] + lds[i] - 1`
   - Subtract 1 because the peak element is counted in both LIS and LDS

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[1, 11, 2, 10, 4, 5, 2, 1]` | 6 | Bitonic: `[1, 2, 4, 5, 2, 1]` |
| `[1, 2, 3, 4, 5]` | 5 | Purely increasing, decreasing part is empty |
| `[5, 4, 3, 2, 1]` | 5 | Purely decreasing, increasing part is empty |
| `[1]` | 1 | Single element |
| `[]` | 0 | Empty array |
| `[1, 2, 1]` | 3 | Classic mountain shape |
| `[80, 60, 30, 40, 20, 10]` | 5 | Bitonic: `[80, 60, 40, 20, 10]` or `[80, 60, 30, 20, 10]` |

## Complexity Analysis

- **Time Complexity:** O(n²) where n is the length of the array
  - We use nested loops for both LIS and LDS computations
  
- **Space Complexity:** O(n) for storing the LIS and LDS arrays
