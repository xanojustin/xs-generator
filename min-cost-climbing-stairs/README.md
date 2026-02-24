# Min Cost Climbing Stairs

## Problem
You are given an integer array `cost` where `cost[i]` is the cost of the `i`-th step on a staircase. Once you pay the cost, you can either climb one or two steps.

You can either start from the step with index `0`, or the step with index `1`.

Return the minimum cost to reach the top of the floor (beyond the last step).

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/min_cost_climbing_stairs.xs`):** Contains the dynamic programming solution

## Function Signature
- **Input:** `costs` - An array of integers where `costs[i]` represents the cost of the i-th step
- **Output:** An integer representing the minimum cost to reach the top of the stairs

## Approach
This solution uses dynamic programming with O(1) space complexity:
- We only need to track the minimum cost to reach the previous two steps
- For each step i, the minimum cost = cost[i] + min(cost to reach i-1, cost to reach i-2)
- The answer is the minimum of reaching from the last step or second-to-last step

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[10, 15, 20]` | `15` | Cheapest: start at step 1 (cost 15), then jump to top |
| `[1, 100, 1, 1, 1, 100, 1, 1, 100, 1]` | `6` | Cheapest: take 1-step paths avoiding 100-cost steps |
| `[]` | `0` | Edge case: no stairs, no cost |
| `[5]` | `5` | Edge case: single step, must pay to climb it |
| `[1, 2]` | `1` | Can start at step 0 (cost 1) and jump 2 steps to top |
