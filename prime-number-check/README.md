# Prime Number Check

## Problem

Determine if a given integer is a **prime number**.

A prime number is a natural number greater than 1 that has no positive divisors other than 1 and itself. In other words, a number is prime if it can only be divided evenly by 1 and itself.

### Examples:
- **2** is prime (only divisible by 1 and 2)
- **3** is prime (only divisible by 1 and 3)
- **4** is NOT prime (divisible by 1, 2, and 4)
- **17** is prime (only divisible by 1 and 17)
- **18** is NOT prime (divisible by 1, 2, 3, 6, 9, and 18)

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/prime_number_check.xs`):** Contains the solution logic for checking primality

## Function Signature

- **Input:** 
  - `n` (int): The number to check for primality
  
- **Output:** 
  - (bool): `true` if the number is prime, `false` otherwise

## Algorithm

The function uses an optimized approach:
1. Numbers less than 2 are not prime
2. 2 is the only even prime number
3. Even numbers greater than 2 are not prime
4. For odd numbers, check divisibility only up to the square root of n
5. Only check odd divisors (skip even ones)

## Test Cases

| Input | Expected Output | Notes |
|-------|-----------------|-------|
| 2 | `true` | Smallest prime number |
| 17 | `true` | Standard prime |
| 4 | `false` | Smallest non-prime > 2 |
| 1 | `false` | Edge case: less than 2 |
| 0 | `false` | Edge case: zero |
| -5 | `false` | Edge case: negative number |
| 97 | `true` | Larger prime |
| 100 | `false` | Larger non-prime (even) |
| 49 | `false` | Square of a prime (7²) |
