# Candy Distribution

## Problem
There are `n` children standing in a line. Each child is assigned a rating value given in the integer array `ratings`.

You are giving candies to these children subjected to the following requirements:
1. Each child must have at least one candy.
2. Children with a higher rating get more candies than their neighbors.

Return the **minimum** number of candies you need to have to distribute the candies to the children.

### Examples

**Example 1:**
- Input: `ratings = [1,0,2]`
- Output: `5`
- Explanation: You can allocate to the first, second and third child with 2, 1, 2 candies respectively.

**Example 2:**
- Input: `ratings = [1,2,2]`
- Output: `4`
- Explanation: You can allocate to the first, second and third child with 1, 2, 1 candies respectively.
  The third child gets 1 candy because it satisfies the conditions.

## Structure
- **Run Job (`run.xs`):** Calls the candy function with 7 test cases covering various scenarios
- **Function (`function/candy.xs`):** Contains the greedy algorithm solution

## Algorithm
The solution uses a two-pass greedy approach:
1. **Left-to-right pass:** If a child has a higher rating than their left neighbor, they get one more candy than the left neighbor.
2. **Right-to-left pass:** If a child has a higher rating than their right neighbor AND doesn't already have more candies, they get one more candy than the right neighbor.

This ensures both constraints are satisfied with the minimum total candies.

## Function Signature
- **Input:**
  - `ratings` (int[]): Array of ratings for each child
- **Output:**
  - (int): Minimum number of candies needed to distribute

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[1, 0, 2]` | 5 | Peak in middle: [2, 1, 2] |
| `[1, 2, 2]` | 4 | Equal ratings: [1, 2, 1] |
| `[5]` | 1 | Single child (edge case) |
| `[3, 3, 3, 3]` | 4 | All same: [1, 1, 1, 1] |
| `[1, 2, 3, 4, 5]` | 15 | Strictly increasing: [1, 2, 3, 4, 5] |
| `[5, 4, 3, 2, 1]` | 15 | Strictly decreasing: [5, 4, 3, 2, 1] |
| `[]` | 0 | Empty input (edge case) |

## Complexity Analysis
- **Time Complexity:** O(n) - Two passes through the array
- **Space Complexity:** O(n) - For the candies array
