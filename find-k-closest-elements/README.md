# Find K Closest Elements

## Problem
Given a sorted integer array `arr`, two integers `k` and `x`, return the `k` closest integers to `x` in the array. The result should also be sorted in ascending order.

An integer `a` is closer to `x` than an integer `b` if:
- `|a - x| < |b - x|`, or
- `|a - x| == |b - x|` and `a < b`

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/find_k_closest_elements.xs`):** Contains the solution logic

## Function Signature
- **Input:**
  - `arr` (int[]): Sorted array of integers
  - `k` (int): Number of closest elements to find
  - `x` (int): Target value to find closest elements to
- **Output:** int[] - Array of k closest integers in ascending order

## Algorithm
1. Handle edge cases (k <= 0, empty array, k >= array length)
2. Use binary search to find the position in the array closest to x
3. Use two pointers to expand outward from that position, picking the closer element at each step
4. Return the result sorted in ascending order

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `arr=[1,2,3,4,5]`, `k=4`, `x=3` | `[1,2,3,4]` |
| `arr=[1,2,3,4,5]`, `k=4`, `x=-1` | `[1,2,3,4]` |
| `arr=[1,1,2,2,2,2,3,3]`, `k=3`, `x=3` | `[2,3,3]` |
| `arr=[]`, `k=2`, `x=5` | `[]` |
| `arr=[1,2,3]`, `k=5`, `x=2` | `[1,2,3]` |

## Complexity
- **Time Complexity:** O(log n + k) - Binary search O(log n) + Two pointer expansion O(k)
- **Space Complexity:** O(k) - Result array of size k
