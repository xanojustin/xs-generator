# Sieve of Eratosthenes

## Problem

Find all prime numbers up to a given number `n` using the Sieve of Eratosthenes algorithm.

The Sieve of Eratosthenes is an ancient algorithm for finding all prime numbers up to any given limit. It works by:
1. Creating a list of consecutive integers from 2 through n
2. Initially marking all numbers as potentially prime
3. Starting from 2, if the number is still marked as prime, mark all its multiples as not prime
4. Repeat for all numbers up to the square root of n
5. All numbers still marked as prime are the primes up to n

This is a classic algorithm that demonstrates efficient prime number generation with O(n log log n) time complexity.

## Function Signature

- **Input:** `n` (int) - The upper limit for finding primes (must be >= 2, max 100000)
- **Output:** `int[]` - An array of all prime numbers from 2 to n (inclusive)

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| 2 | `[2]` |
| 10 | `[2, 3, 5, 7]` |
| 30 | `[2, 3, 5, 7, 11, 13, 17, 19, 23, 29]` |
| 100 | `[2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97]` |
| 1 | Error (validation: min:2) |
| 2 | Single prime - tests the lower boundary |
| 100 | Contains 25 primes - tests a larger range with multiple primes |
