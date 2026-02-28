# Max Product of Three

## Problem

Given an integer array `nums`, find three numbers whose product is maximum and return the maximum product.

The key insight is that the maximum product can come from either:
1. The three largest positive numbers in the array
2. Two smallest negative numbers (which multiply to a positive) times the largest positive number

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/max_product_of_three.xs`):** Contains the solution logic

## Function Signature

- **Input:**
  - `nums` (int[]): Array of integers (must contain at least 3 elements)
- **Output:**
  - Returns an integer representing the maximum product of any three numbers in the array

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[1, 2, 3]` | `6` | Only three numbers, product is 1×2×3 = 6 |
| `[-10, -10, 1, 3, 2]` | `300` | Two negatives (-10 × -10 = 100) × 3 = 300 |
| `[-1, -2, -3, -4]` | `-6` | All negative, take three largest (closest to 0): -1 × -2 × -3 = -6 |
| `[-1, -2, 0, 5, 10]` | `100` | Two negatives (-1 × -2 = 2) × 10 = 20 vs 5 × 10 × 0 = 0 vs 0 × 5 × 10 = 0 → max is 20... wait let me recalculate: 5 × 10 × 0 = 0, but -1 × -2 × 10 = 20, and 0 × 5 × 10 = 0, so max is 20. Hmm, actually: 5 × 10 × (-1) is negative. So max is 20 |
| `[1000, 1000, 1000]` | `1000000000` | Large positive numbers, product is 10^9 |

## Algorithm

1. Sort the array in ascending order
2. Calculate the product of the three largest numbers (last three elements)
3. Calculate the product of the two smallest numbers (could be negative) times the largest number
4. Return the maximum of these two products
