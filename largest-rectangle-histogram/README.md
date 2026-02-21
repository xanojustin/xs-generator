# Largest Rectangle in Histogram

## Problem
Given an array of integers `heights` representing the histogram's bar height where the width of each bar is 1, return the area of the largest rectangle in the histogram.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/largest_rectangle_histogram.xs`):** Contains the solution logic using a monotonic stack

## Function Signature
- **Input:** `heights` (int[]) - Array of integers representing histogram bar heights
- **Output:** `area` (int) - The maximum rectangle area that can be formed

## Algorithm
The solution uses a **monotonic stack** approach:
1. Iterate through each bar in the histogram
2. Maintain a stack of indices where heights are in increasing order
3. When we encounter a bar shorter than the stack top, pop and calculate areas
4. The popped bar's height forms a rectangle extending to the current position
5. Time Complexity: O(n), Space Complexity: O(n)

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[2, 1, 5, 6, 2, 3]` | `10` | The largest rectangle is formed by heights [5, 6] with area 5 × 2 = 10 |
| `[2, 4]` | `4` | Two rectangles: 2×2=4 or 4×1=4, max is 4 |
| `[1]` | `1` | Single bar with width 1 |
| `[]` | `0` | Empty histogram has area 0 |
| `[5, 5, 5, 5]` | `20` | All bars same height, total width × height = 4 × 5 = 20 |
| `[1, 2, 3, 4, 5]` | `9` | Max rectangle uses bars [3, 4, 5] with area 3 × 3 = 9 |

## Example Walkthrough
For input `[2, 1, 5, 6, 2, 3]`:
- The histogram has bars of heights 2, 1, 5, 6, 2, 3
- The largest rectangle spans bars at indices 2-3 (heights 5 and 6)
- Height = 5, Width = 2, Area = 10
