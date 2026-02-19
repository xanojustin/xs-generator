# Prime Check

## Problem

Write a function that determines whether a given integer is a prime number.

A prime number is a natural number greater than 1 that has no positive divisors other than 1 and itself. For example:
- 2, 3, 5, 7, 11, 13, 17, 19, 23 are prime numbers
- 4, 6, 8, 9, 10, 12, 14, 15, 16 are not prime numbers

## Function Signature

- **Input:** `n` (int) - The integer to check for primality
- **Output:** `bool` - Returns `true` if the number is prime, `false` otherwise

## Algorithm

The function uses an optimized primality test:
1. Numbers less than 2 are not prime
2. 2 is prime (the only even prime)
3. Even numbers greater than 2 are not prime
4. For odd numbers ≥ 3, check divisibility by odd numbers from 3 up to √n
5. If no divisor is found, the number is prime

This optimization reduces the time complexity from O(n) to O(√n).

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| 2 | true | 2 is the smallest and only even prime |
| 3 | true | 3 is prime (no divisors other than 1 and 3) |
| 4 | false | 4 = 2 × 2, divisible by 2 |
| 17 | true | 17 is prime |
| 18 | false | 18 = 2 × 9, divisible by 2 and 3 |
| 97 | true | 97 is prime (largest prime less than 100) |
| 1 | false | 1 is not considered prime |
| 0 | false | 0 is not prime |
| -5 | false | Negative numbers are not prime |
| 1009 | true | Larger prime number (1009 is prime) |

## Edge Cases

- **Numbers less than 2:** Should return `false` (0, 1, and negatives are not prime)
- **Number 2:** The only even prime number
- **Large primes:** Algorithm efficiently handles primes up to at least 1 million
- **Perfect squares:** Numbers like 9, 25, 49 should return `false`
