# Bulb Switcher

## Problem
There are `n` bulbs that are initially off. You first turn on all the bulbs, then you turn off every second bulb. On the third round, you toggle every third bulb (turning on if it's off or turning off if it's on). For the `i`-th round, you toggle every `i`-th bulb. For the `n`-th round, you only toggle the last bulb.

Return the number of bulbs that are on after `n` rounds.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/bulb_switcher.xs`):** Contains the solution logic

## Function Signature
- **Input:** `n` (int) - Number of bulbs and rounds (1 <= n <= 10^9)
- **Output:** (int) - Number of bulbs that remain on after n rounds

## Key Insight
A bulb ends up on if it's flipped an odd number of times. Bulb `i` is flipped once for each divisor of `i`. A number has an odd number of divisors only if it's a **perfect square** (since divisors normally come in pairs, except when the number is a square).

Therefore, the bulbs at positions 1, 4, 9, 16, 25, ... (perfect squares) will remain on. The count of perfect squares <= n is `floor(sqrt(n))`.

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| 3 | 1 | Bulbs 1, 2, 3 after rounds: [on, off, off] → only bulb 1 stays on |
| 0 | 0 | Edge case: no bulbs |
| 1 | 1 | Single bulb: turned on in round 1 |
| 4 | 2 | Perfect squares <= 4 are 1, 4 → 2 bulbs on |
| 9 | 3 | Perfect squares <= 9 are 1, 4, 9 → 3 bulbs on |
| 16 | 4 | Perfect squares <= 16 are 1, 4, 9, 16 → 4 bulbs on |
| 1000000000 | 31622 | Large input: floor(sqrt(10^9)) = 31622 |

## Complexity Analysis
- **Time Complexity:** O(1) - Constant time square root calculation
- **Space Complexity:** O(1) - Only uses a single variable
