# Smallest Even Multiple

## Problem

Given a positive integer `n`, return the **smallest even multiple** of `n`.

An even multiple of `n` is a number that:
1. Is divisible by `n` (i.e., `result % n == 0`)
2. Is even (i.e., `result % 2 == 0`)

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/smallest_even_multiple.xs`):** Contains the solution logic

## Function Signature

- **Input:** 
  - `n` (int): A positive integer (n ≥ 1)
- **Output:** 
  - (int): The smallest even multiple of n

## Algorithm

The solution uses a simple mathematical observation:
- If `n` is already even (n % 2 == 0), then `n` itself is the smallest even multiple
- If `n` is odd, then `2 * n` is the smallest even multiple

This works because:
- An even number is always its own smallest even multiple
- For odd numbers, multiplying by 2 makes it even while keeping it a multiple of n

## Test Cases

| Input (n) | Expected Output | Explanation |
|-----------|-----------------|-------------|
| 5 | 10 | 5 is odd, so 5 × 2 = 10 |
| 6 | 6 | 6 is already even |
| 1 | 2 | 1 is odd, so 1 × 2 = 2 |
| 2 | 2 | 2 is already even |
| 7 | 14 | 7 is odd, so 7 × 2 = 14 |
| 100 | 100 | 100 is already even |
| 101 | 202 | 101 is odd, so 101 × 2 = 202 |

## Complexity Analysis

- **Time Complexity:** O(1) - Constant time arithmetic operations
- **Space Complexity:** O(1) - No additional space used
