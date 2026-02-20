# Trapping Rain Water

## Problem
Given `n` non-negative integers representing an elevation map where the width of each bar is 1, compute how much water it can trap after raining.

### Example
```
Input:  [0,1,0,2,1,0,1,3,2,1,2,1]
Output: 6

Visualization:
     #
     # #   #
 #   ###  ###
#############
0123456789...

Water trapped: 6 units (shown as gaps between bars)
```

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/trapping_rain_water.xs`):** Contains the two-pointer solution logic

## Function Signature
- **Input:** `heights` (int[]) - Array of non-negative integers representing bar heights
- **Output:** `water` (int) - Total units of water trapped

## Algorithm
Uses the **two-pointer approach**:
1. Initialize two pointers at the start (`left`) and end (`right`) of the array
2. Track the maximum height seen from left (`left_max`) and right (`right_max`)
3. Process the side with the smaller current height:
   - If current height >= max, update the max
   - Else add (max - current height) to water trapped
4. Move the pointer inward and repeat until pointers meet

**Time Complexity:** O(n) - single pass through the array  
**Space Complexity:** O(1) - only using a few variables

## Test Cases

| Input | Expected Output | Description |
|-------|-----------------|-------------|
| `[0,1,0,2,1,0,1,3,2,1,2,1]` | 6 | Classic example with multiple water pockets |
| `[4,2,0,3,2,5]` | 9 | Different elevation pattern |
| `[]` | 0 | Empty array edge case |
| `[1]` | 0 | Single element edge case |
| `[1,2]` | 0 | Two elements - no container possible |
| `[3,0,2]` | 2 | Simple case with one pocket |
| `[5,4,3,2,1]` | 0 | Descending - no water trapped |
| `[1,2,3,4,5]` | 0 | Ascending - no water trapped |

## Why Two Pointers?
The key insight is that water trapped at any position depends on the **minimum** of the maximum heights to its left and right. By using two pointers and always processing the smaller side, we guarantee that the water level is bounded by the smaller of the two max values.
