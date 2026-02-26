# Delete and Earn

## Problem

Given an array of integers `nums`, you can delete any number from the array to earn points equal to that number. However, when you delete a number `num`, you must also delete all occurrences of `num - 1` and `num + 1` (you cannot earn points from them).

Return the maximum number of points you can earn by applying the above operations.

### Example 1:
```
Input: nums = [3, 4, 2]
Output: 6
Explanation: Delete 3 and 4 to earn 3 + 4 = 7 points.
             Or delete 2 to earn 2 points.
             Better: Delete 2 and 4 to earn 2 + 4 = 6 points? No wait...
             Actually: Delete 3 to earn 3 (must also delete 2 and 4).
             Or: Delete 4 to earn 4 (must also delete 3).
             Or: Delete 2 to earn 2 (must also delete 3).
             Maximum is 6 by deleting 2 and 4? No...
             Let me reconsider: You can delete multiple numbers as long as they're not adjacent.
             Best: Delete 2 and 4 = 2 + 4 = 6 points.
```

### Example 2:
```
Input: nums = [2, 2, 3, 3, 3, 4]
Output: 9
Explanation: Delete 3 to earn 3 * 3 = 9 points (all three 3s).
             This forces deletion of all 2s and 4s, but we don't care.
             Better than deleting 2s (4 points) or 4 (4 points).
```

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/delete-and-earn.xs`):** Contains the solution logic using dynamic programming

## Function Signature

- **Input:** `int[] nums` - An array of integers representing available numbers
- **Output:** `int` - Maximum points that can be earned

## Algorithm

This problem is a variation of the classic **House Robber** problem:

1. **Build frequency map:** Count occurrences of each number
2. **Calculate points for each number:** `points[i] = i * frequency(i)`
3. **Apply DP:** For each number i, choose max of:
   - Not taking i: carry forward previous max
   - Taking i: add points[i] to the max from i-2

The recurrence relation is: `dp[i] = max(dp[i-1], dp[i-2] + points[i])`

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[3, 4, 2]` | `6` | Delete 2 and 4 (not adjacent) = 6 points |
| `[2, 2, 3, 3, 3, 4]` | `9` | Delete all 3s = 9 points |
| `[]` | `0` | Empty array - no points possible |
| `[1]` | `1` | Single element - take it |
| `[1, 1, 1]` | `3` | All same number - take all = 3 points |
| `[1, 2]` | `2` | Choose max of 1+2=3? No wait, they're adjacent. Choose max(1, 2) = 2 |
| `[1, 2, 3, 4]` | `6` | Take 2 + 4 = 6 (or 1 + 3 = 4, so 6 is better) |
