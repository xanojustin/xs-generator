# Gas Station

## Problem

There are `n` gas stations along a circular route, where the amount of gas at the ith station is `gas[i]`. You have a car with an unlimited gas tank and it costs `cost[i]` of gas to travel from the ith station to its next `(i + 1)th` station. You begin the journey with an empty tank at one of the gas stations.

Given two integer arrays `gas` and `cost`, return the starting gas station's index if you can travel around the circuit once in the clockwise direction, otherwise return `-1`.

If there exists a solution, it is guaranteed to be unique.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/gas_station.xs`):** Contains the solution logic using a greedy algorithm

## Function Signature

- **Input:**
  - `gas` (int[]): Array where `gas[i]` is the amount of gas at station `i`
  - `cost` (int[]): Array where `cost[i]` is the cost to travel from station `i` to station `i+1`
- **Output:** 
  - `int`: The starting gas station's index if a solution exists, `-1` otherwise

## Algorithm Explanation

The solution uses a greedy approach with two key insights:

1. **Impossibility Check:** If the total gas available is less than the total cost required, it's impossible to complete the circuit.

2. **Greedy Starting Point:** If at any station the cumulative gas balance goes negative, we cannot start from any station between the previous start point and the current station. We reset our starting point to the next station.

This works because if we can't reach station `j` from station `i`, we also can't reach it from any station between `i` and `j` (they would have even less gas).

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `gas = [1,2,3,4,5]`, `cost = [3,4,5,1,2]` | `3` | Start at station 3: tank=0+4-1=3→3+5-2=6→6+1-3=4→4+2-4=2→2+3-5=0. Completes circuit. |
| `gas = [2,3,4]`, `cost = [3,4,3]` | `-1` | Total gas (9) < Total cost (10). Impossible to complete circuit. |
| `gas = [5]`, `cost = [4]` | `0` | Single station with enough gas. Start at station 0. |
| `gas = [5,1,2,3,4]`, `cost = [4,4,1,5,1]` | `4` | Start at station 4: tank=0+4-1=3→3+5-4=4→4+1-4=1→1+2-1=2→2+3-5=0. Completes circuit. |
| `gas = [3,1,1]`, `cost = [1,2,2]` | `0` | Start at station 0: tank=0+3-1=2→2+1-2=1→1+1-2=0. Completes circuit. |

## Complexity Analysis

- **Time Complexity:** O(n) - Single pass through the arrays
- **Space Complexity:** O(1) - Only using a few variables regardless of input size

## Notes

- Both `gas` and `cost` arrays have the same length `n` where `1 <= n <= 10^5`
- `0 <= gas[i], cost[i] <= 10^4`
- If a solution exists, it is guaranteed to be unique
