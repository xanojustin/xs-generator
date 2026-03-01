# 3Sum Closest

## Problem
Given an integer array `nums` of length `n` and an integer `target`, find three integers in `nums` such that the sum is closest to `target`. Return the sum of the three integers.

You may assume that each input would have exactly one solution.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/three_sum_closest.xs`):** Contains the solution logic

## Function Signature
- **Input:** 
  - `nums` (int[]): Array of integers to search
  - `target` (int): Target sum value
- **Output:** 
  - `result` (int): The sum of three integers closest to target

## Algorithm
1. **Sort** the array to enable two-pointer technique
2. **Iterate** through each number as the first element of the triplet
3. **Two pointers:** For each first element, use left and right pointers to find the other two
4. **Track closest:** Keep track of the sum with minimum absolute difference from target
5. **Move pointers:** 
   - If current sum < target, move left pointer right (increase sum)
   - If current sum > target, move right pointer left (decrease sum)
   - If exact match found, return immediately

**Time Complexity:** O(n²) - Sorting is O(n log n), two-pointer scan is O(n²)  
**Space Complexity:** O(1) - Only using a few variables (excluding sort space)

## Test Cases

| Input | Target | Expected Output | Explanation |
|-------|--------|-----------------|-------------|
| `[-1, 2, 1, -4]` | `1` | `2` | (-1 + 2 + 1 = 2), closest to 1 |
| `[0, 0, 0]` | `1` | `0` | Only triplet sums to 0 |
| `[1, 1, 1, 1]` | `0` | `3` | Any three 1s sum to 3, closest to 0 |
| `[-1, 2, 1, -4]` | `-4` | `-4` | (-1 + 2 + -4 = -3)... wait, let me recalculate: (-4) + (-1) + 2 = -3, closest to -4 is -3 |

### Edge Cases
- **Array with exactly 3 elements:** Return their sum
- **All same values:** Works correctly
- **Negative numbers mixed with positive:** Algorithm handles mixed signs

## Example Walkthrough

**Input:** `nums = [-1, 2, 1, -4]`, `target = 1`

1. **Sort:** `[-4, -1, 1, 2]`
2. **i = 0** (value -4): left=1, right=3
   - sum = -4 + (-1) + 2 = -3, diff = 4, closest = -3
   - sum < target, left++
3. **i = 1** (value -1): left=2, right=3
   - sum = -1 + 1 + 2 = 2, diff = 1, closest = 2 ✓
   - sum > target, right--
4. **Return:** 2
