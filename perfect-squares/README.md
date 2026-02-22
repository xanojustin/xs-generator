# Perfect Squares

## Problem

Given an integer `n`, return the least number of perfect square numbers that sum to `n`.

A **perfect square** is an integer that is the square of an integer; in other words, it is the product of some integer with itself. For example, `1`, `4`, `9`, and `16` are perfect squares while `3` and `11` are not.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test input `n = 12`
- **Function (`function/perfect_squares.xs`):** Contains the dynamic programming solution

## Function Signature

- **Input:** `n` (int) - A positive integer (n ≥ 1)
- **Output:** int - The minimum number of perfect squares that sum to n

## Algorithm

This solution uses **dynamic programming**:

1. Create a DP array where `dp[i]` represents the minimum number of perfect squares that sum to `i`
2. Initialize `dp[0] = 0` (zero squares sum to zero)
3. Initialize `dp[i] = i` for all i (worst case: using i ones)
4. For each number from 1 to n:
   - Try all perfect squares `j*j` where `j*j <= num`
   - Update `dp[num] = min(dp[num], dp[num - j*j] + 1)`
5. Return `dp[n]`

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| 12 | 3 | 4 + 4 + 4 |
| 13 | 2 | 4 + 9 |
| 1 | 1 | 1 is a perfect square |
| 2 | 2 | 1 + 1 |
| 3 | 3 | 1 + 1 + 1 |
| 4 | 1 | 4 is a perfect square |
| 100 | 1 | 100 is a perfect square (10²) |

## Legendre's Three-Square Theorem

This problem is based on a mathematical theorem by Legendre: a natural number can be represented as the sum of three squares if and only if it's not of the form `4^a(8b + 7)` for non-negative integers a and b. This means the answer is always between 1 and 4.
