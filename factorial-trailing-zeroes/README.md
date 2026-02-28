# Factorial Trailing Zeroes

## Problem

Given an integer `n`, return the number of trailing zeroes in `n!` (n factorial).

**Note:** Your solution should work efficiently for large values of `n` (up to 10^9 or more).

### Mathematical Insight

Trailing zeroes are created by factors of 10 in the number. Since 10 = 2 × 5, and factorials always have more factors of 2 than 5, the number of trailing zeroes equals the number of times 5 is a factor in the numbers from 1 to n.

This is computed using **Legendre's Formula**:
- Count multiples of 5: ⌊n/5⌋
- Count multiples of 25 (extra factor of 5 each): ⌊n/25⌋
- Count multiples of 125: ⌊n/125⌋
- Continue until n/(5^k) = 0

**Total trailing zeroes = n/5 + n/25 + n/125 + n/625 + ...**

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test input (n = 100)
- **Function (`function/trailing_zeroes.xs`):** Contains the solution logic using Legendre's formula

## Function Signature

- **Input:**
  - `n` (int): A non-negative integer (0 ≤ n)

- **Output:**
  - (int): The number of trailing zeroes in n!

## Test Cases

| Input (n) | Expected Output | Explanation |
|-----------|-----------------|-------------|
| 0 | 0 | 0! = 1, no trailing zeroes |
| 5 | 1 | 5! = 120, one trailing zero |
| 10 | 2 | 10! = 3,628,800, two trailing zeroes |
| 25 | 6 | 25/5 + 25/25 = 5 + 1 = 6 |
| 100 | 24 | 100/5 + 100/25 + 100/125 = 20 + 4 + 0 = 24 |
| 200 | 49 | 200/5 + 200/25 + 200/125 = 40 + 8 + 1 = 49 |

## Why Not Just Calculate n! ?

Calculating n! directly fails for n ≥ 21 because factorial grows extremely fast:
- 20! = 2,432,902,008,176,640,000 (fits in 64-bit integer)
- 21! = 51,090,942,171,709,440,000 (exceeds 64-bit signed integer max)

For n = 100, n! has 158 digits — far too large for standard integer types.

## Complexity Analysis

- **Time Complexity:** O(log₅ n) — we divide n by powers of 5 until it reaches 0
- **Space Complexity:** O(1) — only uses a few integer variables

## References

- [Factorial on Wikipedia](https://en.wikipedia.org/wiki/Factorial)
- [Legendre's Formula](https://en.wikipedia.org/wiki/Legendre%27s_formula)
- [LeetCode #172: Factorial Trailing Zeroes](https://leetcode.com/problems/factorial-trailing-zeroes/)
