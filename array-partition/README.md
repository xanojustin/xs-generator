# Array Partition

## Problem

Given an integer array `nums` of **2n** integers, group these integers into `n` pairs `(a1, b1), (a2, b2), ..., (an, bn)` such that the sum of `min(ai, bi)` for all `i` is **maximized**. Return the maximized sum.

### Example
- Input: `[1, 4, 3, 2]`
- Output: `4`
- Explanation: The optimal pairing is (1, 2) and (3, 4). The sum is min(1, 2) + min(3, 4) = 1 + 3 = 4

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/array_partition.xs`):** Contains the solution logic

## Function Signature

- **Input:** 
  - `nums` (int[]) - An array of 2n integers
- **Output:** 
  - (int) - The maximum possible sum of minimums of all pairs

## Algorithm

The greedy approach works because:
1. Sort the array in ascending order
2. Pair adjacent elements: (nums[0], nums[1]), (nums[2], nums[3]), etc.
3. The minimum of each pair will be the first element (at even indices)
4. Sum all elements at even indices (0, 2, 4, ...)

This strategy maximizes the sum because by pairing adjacent sorted elements, we minimize the "loss" from larger numbers that get discarded as maximums in each pair.

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[1, 4, 3, 2]` | `4` | Pairs: (1,2), (3,4). Sum: 1 + 3 = 4 |
| `[6, 2, 6, 5, 1, 2]` | `9` | Sorted: [1,2,2,5,6,6]. Sum: 1 + 2 + 6 = 9 |
| `[1, 1]` | `1` | Single pair: (1,1). Sum: 1 |
| `[1, 2, 3, 4, 5, 6, 7, 8]` | `16` | Sorted pairs: (1,2), (3,4), (5,6), (7,8). Sum: 1+3+5+7 = 16 |
| `[10, 20]` | `10` | Single pair with large spread. Sum: 10 |

## Complexity

- **Time Complexity:** O(n log n) due to sorting
- **Space Complexity:** O(n) for the sorted copy (or O(1) if sorting in-place)
