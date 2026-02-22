# Find Pivot Index

## Problem
Given an array of integers `nums`, find the **pivot index** where the sum of all numbers strictly to the left of the index is equal to the sum of all numbers strictly to the right of the index.

If no such index exists, return `-1`.

### Example
For the array `[1, 7, 3, 6, 5, 6]`:
- At index 3 (value = 6), the left sum is `1 + 7 + 3 = 11` and the right sum is `5 + 6 = 11`
- Therefore, index 3 is the pivot index

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test input `[1, 7, 3, 6, 5, 6]`
- **Function (`function/find_pivot_index.xs`):** Contains the solution logic

## Function Signature
- **Input:** 
  - `nums` (int[]) - An array of integers to search for the pivot index
- **Output:** 
  - Returns an `int` representing:
    - The pivot index (0-based) where left sum equals right sum
    - `-1` if no such index exists

## Algorithm
1. Calculate the total sum of all elements in the array
2. Iterate through the array while maintaining a running left sum
3. At each index, calculate the right sum as: `total_sum - left_sum - current_element`
4. If `left_sum == right_sum`, return the current index
5. Otherwise, add the current element to left sum and continue
6. If no pivot is found after iterating through all elements, return `-1`

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[1, 7, 3, 6, 5, 6]` | `3` | Left sum at index 3: 1+7+3=11, Right sum: 5+6=11 |
| `[1, 2, 3]` | `-1` | No index has equal left and right sums |
| `[]` | `-1` | Empty array has no pivot index |
| `[0]` | `0` | Single element with value 0: left=0, right=0 |
| `[2, 1, -1]` | `0` | Index 0: left=0, right=1+(-1)=0 |

## Complexity Analysis
- **Time Complexity:** O(n) - Single pass to calculate total sum, single pass to find pivot
- **Space Complexity:** O(1) - Only using a few variables regardless of input size
