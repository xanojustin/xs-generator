# The Kth Factor of N

## Problem

Given two positive integers `n` and `k`, find the kth factor of `n` in ascending order, or return `-1` if `n` has fewer than `k` factors.

A factor of a number `n` is an integer `i` such that `n % i == 0` (i divides n evenly).

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/kth_factor.xs`):** Contains the solution logic

## Function Signature

- **Input:**
  - `n` (int): A positive integer to find factors of
  - `k` (int): The position of the factor to return (1-indexed)
- **Output:**
  - (int): The kth factor of `n`, or `-1` if `n` has fewer than `k` factors

## Test Cases

| n | k | Expected Output | Explanation |
|---|---|-----------------|-------------|
| 12 | 3 | 3 | Factors: 1, 2, **3**, 4, 6, 12 |
| 7 | 2 | 7 | Factors: 1, **7** |
| 4 | 4 | -1 | Factors: 1, 2, 4 (only 3 factors) |
| 1 | 1 | 1 | Factors: **1** |
| 100 | 9 | -1 | Factors: 1, 2, 4, 5, 10, 20, 25, 50, 100 (only 9 factors, no 9th) |

### Test Case Categories

- **Basic cases:** Standard numbers with multiple factors (12, 7)
- **Edge case - prime number:** 7 has only 2 factors
- **Edge case - fewer factors than k:** 4 has only 3 factors, requesting 4th returns -1
- **Edge case - single factor:** 1 has only 1 factor
- **Boundary case:** Requesting exactly the count of factors (k=9 for n=100) returns -1 since we need at least k factors
