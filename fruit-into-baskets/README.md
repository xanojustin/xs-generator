# Fruit Into Baskets

## Problem
You are visiting a farm with a single row of fruit trees arranged from left to right. The trees are represented by an integer array `fruits` where `fruits[i]` is the type of fruit the i-th tree produces.

You want to collect as much fruit as possible, but you have two baskets and each basket can only hold one type of fruit. This means you can collect at most **two different types** of fruit in total.

Starting from any tree of your choice, you must pick exactly one fruit from every tree (including the start tree) while moving to the right. Once you reach a tree with fruit that cannot fit in your baskets (a third type), you must stop.

Given the integer array `fruits`, return the **maximum** number of fruits you can collect.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/fruit_into_baskets.xs`):** Contains the sliding window solution logic

## Function Signature
- **Input:** `fruits` (int[]) - An array where each element represents a fruit type
- **Output:** `max_fruits` (int) - Maximum number of fruits that can be collected with at most 2 types

## Approach
This problem uses the **sliding window** technique:
1. Use two pointers (`left` and `right`) to maintain a window
2. Expand the window by moving `right` pointer
3. Track fruit counts in a hash map (basket)
4. When we exceed 2 fruit types, shrink window from left until we're back to 2 types
5. Track the maximum window size throughout

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[1, 2, 1]` | 3 | Can collect all fruits (types 1 and 2) |
| `[0, 1, 2, 2]` | 3 | Best is `[1, 2, 2]` - 3 fruits of types 1 and 2 |
| `[1, 2, 3, 2, 2]` | 4 | Best is `[2, 3, 2, 2]` or `[2, 2]` - actually `[2, 2]` is type 2 only, so max is 4 with `[2, 3, 2, 2]` being types 2 and 3... wait, let me re-check: `[1, 2]` then hit 3 so stop = 2 fruits. Better: skip first, `[2, 3, 2, 2]` = 4 fruits of types 2 and 3 |
| `[]` | 0 | Empty array - no fruits to collect |
| `[1]` | 1 | Single fruit |
| `[1, 1, 1, 1]` | 4 | All same type |

## Complexity
- **Time:** O(n) - Each element is visited at most twice (once by right, once by left)
- **Space:** O(1) - At most 3 keys in the basket map (briefly 3 before shrinking)
