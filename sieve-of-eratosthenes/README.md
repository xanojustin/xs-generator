# Sieve of Eratosthenes

## Problem
Implement the Sieve of Eratosthenes algorithm to find all prime numbers up to a given positive integer `n`.

The Sieve of Eratosthenes is an ancient algorithm for finding all prime numbers up to any given limit. It works by iteratively marking as composite (not prime) the multiples of each prime, starting from 2.

### Algorithm Steps:
1. Create a boolean array of size `n+1`, initialized to `true` (representing "potentially prime")
2. Mark 0 and 1 as `false` (not prime)
3. For each number `i` from 2 to √n:
   - If `i` is still marked as prime, mark all multiples of `i` (starting from `i*i`) as not prime
4. Return all indices that are still marked as prime

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test input (limit: 30)
- **Function (`function/sieve_of_eratosthenes.xs`):** Contains the Sieve of Eratosthenes implementation

## Function Signature
- **Input:** 
  - `limit` (int, required): The upper bound (inclusive) for finding prime numbers. Must be ≥ 2.
- **Output:** 
  - Returns an array of integers (`int[]`) containing all prime numbers from 2 to `limit`, in ascending order

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| 10 | [2, 3, 5, 7] |
| 30 | [2, 3, 5, 7, 11, 13, 17, 19, 23, 29] |
| 2 | [2] |
| 100 | [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97] |
| 50 | [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47] |

### Edge Cases:
- **Minimum input (2):** Should return [2], the smallest prime
- **Small input (10):** Classic test with 4 primes
- **Larger input (100):** Tests the algorithm's efficiency with more primes

## Complexity Analysis
- **Time Complexity:** O(n log log n) — The harmonic series of primes
- **Space Complexity:** O(n) — For the boolean array

## Why This Algorithm?
The Sieve of Eratosthenes is one of the most efficient ways to find all primes up to a limit. While modern algorithms exist for finding very large primes, this remains a classic teaching tool and practical solution for ranges up to millions.