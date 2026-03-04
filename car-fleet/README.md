# Car Fleet

## Problem

There are `n` cars traveling to the same destination along a one-lane road. The destination is `target` miles away.

You are given two arrays of integers:
- `position`: an array where `position[i]` is the position of the `i-th` car (in miles from the start)
- `speed`: an array where `speed[i]` is the speed of the `i-th` car (in miles per hour)

A car **cannot** pass another car ahead of it, but it can catch up to it and drive bumper to bumper at the same speed. In this case, the two cars become a single fleet moving at the slower car's speed.

A **car fleet** is a group of one or more cars traveling at the same speed at the same position. Note that a single car is also considered a fleet.

Return the **number of car fleets** that will arrive at the destination.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs (target=12, position=[10,8,0,5,3], speed=[2,4,1,1,3])
- **Function (`function/car_fleet.xs`):** Contains the solution logic that calculates the number of fleets

## Function Signature

- **Input:**
  - `target` (int): The destination distance in miles (must be positive)
  - `position` (int[]): Array of car positions from the start
  - `speed` (int[]): Array of car speeds in mph
  
- **Output:**
  - Returns (int): The number of car fleets that arrive at the destination

## Algorithm

1. Calculate the time it takes for each car to reach the target: `(target - position) / speed`
2. Sort cars by position in descending order (starting from the car closest to the target)
3. Iterate through sorted cars and count fleets:
   - If a car's time is greater than the current fleet's time, it forms a new fleet (it's slower)
   - Otherwise, it merges with the current fleet (it's faster but blocked by slower cars ahead)

## Test Cases

| Target | Position | Speed | Expected Output | Explanation |
|--------|----------|-------|-----------------|-------------|
| 12 | [10, 8, 0, 5, 3] | [2, 4, 1, 1, 3] | **3** | Used in run.xs - Cars at positions 10, 8 form one fleet; positions 5, 3 form another; position 0 forms the third |
| 10 | [3] | [3] | **1** | Single car - one fleet |
| 100 | [0, 2, 4] | [4, 2, 1] | **1** | All cars form one fleet (faster cars catch up and are blocked) |
| 10 | [] | [] | **0** | Edge case: no cars |
| 12 | [0, 5] | [1, 1] | **2** | Two cars same speed - two fleets |

## Example Walkthrough

For target=12, position=[10, 8, 0, 5, 3], speed=[2, 4, 1, 1, 3]:

| Car | Position | Speed | Time to Target |
|-----|----------|-------|----------------|
| 0 | 10 | 2 | (12-10)/2 = 1.0 |
| 1 | 8 | 4 | (12-8)/4 = 1.0 |
| 2 | 0 | 1 | (12-0)/1 = 12.0 |
| 3 | 5 | 1 | (12-5)/1 = 7.0 |
| 4 | 3 | 3 | (12-3)/3 = 3.0 |

Sorted by position (descending): 10→8→5→3→0

Processing order:
1. Car at 10: time=1.0 → **New fleet #1** (first car)
2. Car at 8: time=1.0 ≤ 1.0 → merges with fleet #1
3. Car at 5: time=7.0 > 1.0 → **New fleet #2**
4. Car at 3: time=3.0 ≤ 7.0 → merges with fleet #2
5. Car at 0: time=12.0 > 7.0 → **New fleet #3**

Result: **3 fleets**
