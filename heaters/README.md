# Heaters

## Problem
Winter is coming! You need to design a standard heater with a fixed warm radius to warm all houses. Every house can be warmed as long as it is within the heater's warm radius range.

Given the positions of `houses` and `heaters` on a horizontal line, return the minimum radius standard of heaters so that those heaters could cover all houses.

**Notice** that all the heaters follow your radius standard, and the warm radius is the same for all heaters.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/heaters.xs`):** Contains the solution logic using binary search

## Function Signature
- **Input:**
  - `houses` (int[]): Array of house positions on a horizontal line
  - `heaters` (int[]): Array of heater positions on a horizontal line
- **Output:** (int) The minimum radius required so that all houses are warmed

## Algorithm
1. Sort both the houses and heaters arrays
2. For each house, use binary search to find the nearest heater
3. Track the maximum distance from any house to its nearest heater
4. This maximum distance is the minimum required radius

## Test Cases

| Houses | Heaters | Expected Output | Explanation |
|--------|---------|-----------------|-------------|
| [1, 2, 3] | [2] | 1 | House 1 and 3 are 1 unit away from heater at 2 |
| [1, 2, 3, 4] | [1, 4] | 1 | Each house is at most 1 unit from nearest heater |
| [1, 5] | [2] | 3 | House 5 is 3 units away from heater at 2 |
| [1] | [1] | 0 | House is exactly at heater position |
| [1, 2, 3, 4, 5] | [2, 4] | 1 | All houses within 1 unit of nearest heater |

## Complexity
- **Time Complexity:** O(n log m) where n = number of houses, m = number of heaters
- **Space Complexity:** O(1) auxiliary space (not counting the sorted arrays)
