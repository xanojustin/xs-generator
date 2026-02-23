# Count Primes

## Problem

Given an integer `n`, return the number of prime numbers that are strictly less than `n`.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/count_primes.xs`):** Contains the Sieve of Eratosthenes implementation

## Function Signature

- **Input:**
  - `n` (int): Upper bound (exclusive) — count primes less than this number
- **Output:**
  - `count` (int): Number of prime numbers strictly less than n

## Algorithm

This solution uses the **Sieve of Eratosthenes** algorithm:

1. Create a boolean array of size n, initialized to true
2. Mark 0 and 1 as not prime
3. For each number i from 2 to √n:
   - If i is prime, mark all multiples of i (starting from i²) as not prime
4. Count all numbers still marked as prime

Time Complexity: O(n log log n)
Space Complexity: O(n)

## Test Cases

| Input (n) | Expected Output | Explanation |
|-----------|-----------------|-------------|
| 10 | 4 | Primes less than 10: 2, 3, 5, 7 |
| 0 | 0 | No primes less than 0 |
| 1 | 0 | No primes less than 1 |
| 2 | 0 | No primes less than 2 (2 itself is prime but not less than 2) |
| 3 | 1 | Only 2 is prime and less than 3 |
| 100 | 25 | There are 25 primes less than 100 |
| 1000000 | 78498 | Large input test |

## Example Walkthrough

For n = 10:
- Initial array: [false, false, true, true, true, true, true, true, true, true]
- After marking multiples of 2: [false, false, true, true, false, true, false, true, false, true]
- After marking multiples of 3: [false, false, true, true, false, true, false, true, false, false]
- Count of true values: 4 (indices 2, 3, 5, 7)
