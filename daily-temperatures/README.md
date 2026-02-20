# Daily Temperatures

## Problem
Given an array of daily temperatures `temperatures`, return an array `answer` such that `answer[i]` is the number of days you have to wait after the ith day to get a warmer temperature. If there is no future day for which this is possible, keep `answer[i] == 0` instead.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/daily_temperatures.xs`):** Contains the solution logic using a monotonic decreasing stack

## Function Signature
- **Input:** `temperatures` (json) - Array of integers representing daily temperatures
- **Output:** Array of integers where each element represents days until a warmer temperature

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[73, 74, 75, 71, 69, 72, 76, 73]` | `[1, 1, 4, 2, 1, 1, 0, 0]` | Day 0→1, Day 1→2, Day 2→6, Day 3→5, Day 4→5, Day 5→6, Day 6→none, Day 7→none |
| `[30, 40, 50, 60]` | `[1, 1, 1, 0]` | Each day has a warmer next day except last |
| `[60, 50, 40, 30]` | `[0, 0, 0, 0]` | Decreasing temps - never gets warmer |
| `[50]` | `[0]` | Single day - no future days |
| `[]` | `[]` | Empty input |

## Algorithm
This solution uses a **monotonic decreasing stack** approach:
1. Initialize result array with zeros
2. Iterate through each day's temperature
3. While stack not empty and current temp > temp at stack top:
   - Pop from stack and calculate days waited
   - Update result for that index
4. Push current index onto stack
5. Continue until all days processed

**Time Complexity:** O(n) - each index is pushed and popped at most once  
**Space Complexity:** O(n) - for the stack
