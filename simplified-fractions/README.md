# Simplified Fractions

## Problem

Given an integer `n`, return a list of all simplified fractions between 0 and 1 (exclusive) such that:
- The denominator is less than or equal to `n`
- The fraction is in its simplest form (numerator and denominator have GCD of 1)
- The numerator is always less than the denominator

A fraction is considered "simplified" (or in its "reduced form") when the greatest common divisor (GCD) of the numerator and denominator is 1.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test input `n = 4`
- **Function (`function/simplified_fractions.xs`):** Contains the solution logic using the Euclidean algorithm to compute GCD

## Function Signature

- **Input:** 
  - `n` (int): The maximum denominator value (must be >= 2)
- **Output:** 
  - Array of strings, where each string is a simplified fraction in the format "numerator/denominator"

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| 2 | ["1/2"] |
| 3 | ["1/2", "1/3", "2/3"] |
| 4 | ["1/2", "1/3", "2/3", "1/4", "3/4"] |
| 5 | ["1/2", "1/3", "2/3", "1/4", "3/4", "1/5", "2/5", "3/5", "4/5"] |

### Explanation of Test Cases

- **n = 2:** Only one valid fraction: 1/2 (already simplified)
- **n = 3:** Adds 1/3 and 2/3. Note: 2/4 would not appear because we only consider fractions where denominator <= n directly
- **n = 4:** Includes 1/4 and 3/4. Excludes 2/4 because GCD(2,4) = 2 (not simplified)

## Implementation Notes

The solution uses the **Euclidean algorithm** to compute GCD:
1. While `b != 0`, replace `(a, b)` with `(b, a % b)`
2. When `b` becomes 0, `a` contains the GCD

This is an efficient O(log min(a,b)) algorithm for computing greatest common divisors.
