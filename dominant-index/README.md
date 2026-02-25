# Dominant Index

## Problem
You are given an integer array `nums` where the largest integer is unique.

Determine whether the largest element in the array is at least twice as much as every other number in the array. If it is, return the **index** of the largest element; otherwise, return **-1**.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/dominant_index.xs`):** Contains the solution logic

## Function Signature
- **Input:** 
  - `nums` (int[]): Array of integers where the largest element is unique
- **Output:** 
  - (int): Index of the dominant element if it exists (at least twice all others), otherwise -1

## Algorithm
1. Handle edge case: single element array returns 0
2. Traverse array once to find:
   - Maximum value and its index
   - Second maximum value
3. Check if `max >= 2 * second_max`
4. Return max index if true, -1 otherwise

**Time Complexity:** O(n) - single pass through array  
**Space Complexity:** O(1) - only tracking a few variables

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[3, 6, 1, 0]` | `1` | 6 is largest; 6 >= 2*3 (second largest), so return index 1 |
| `[1, 2, 3, 4]` | `-1` | 4 is largest; 4 < 2*3 (6), so return -1 |
| `[0]` | `0` | Single element is trivially dominant |
| `[1, 0]` | `0` | 1 >= 2*0, return index 0 |
| `[0, 0, 3, 2]` | `-1` | 3 is largest; 3 < 2*2 (4), so return -1 |
| `[10, 1, 1, 1]` | `0` | 10 >= 2*1, return index 0 |
