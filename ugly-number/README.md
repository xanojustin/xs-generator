# Ugly Number

## Problem

An **ugly number** is a positive integer whose prime factors are limited to `2`, `3`, and `5`.

Given an integer `n`, return `true` if `n` is an ugly number.

### Examples

- **Input:** `n = 6` → **Output:** `true` (6 = 2 × 3)
- **Input:** `n = 8` → **Output:** `true` (8 = 2 × 2 × 2)
- **Input:** `n = 14` → **Output:** `false` (14 = 2 × 7, contains 7)
- **Input:** `n = 1` → **Output:** `true` (1 has no prime factors, by convention is ugly)

## Structure

- **Run Job (`run.xs`):** Calls the `is_ugly_number` function with test input `n = 6`
- **Function (`function/is_ugly_number.xs`):** Contains the solution logic using repeated division

## Function Signature

- **Input:** `n` (int) - The number to check
- **Output:** `bool` - `true` if n is an ugly number, `false` otherwise

## Algorithm

The solution uses repeated division:
1. Return `false` for non-positive numbers
2. Return `true` for 1 (by definition)
3. Repeatedly divide `n` by 2, 3, and 5 as long as it's divisible
4. If the result is 1, only 2, 3, and 5 were factors → return `true`
5. Otherwise, another prime factor exists → return `false`

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| 6 | `true` | 6 = 2 × 3, only allowed primes |
| 8 | `true` | 8 = 2³, only allowed primes |
| 14 | `false` | 14 = 2 × 7, contains 7 |
| 1 | `true` | By convention, 1 is ugly |
| 0 | `false` | Must be positive |
| -6 | `false` | Must be positive |
| 30 | `true` | 30 = 2 × 3 × 5 |
| 7 | `false` | 7 is prime, not in {2,3,5} |
