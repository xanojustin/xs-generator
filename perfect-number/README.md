# Perfect Number

## Problem

A **perfect number** is a positive integer that is equal to the sum of its proper divisors (positive divisors excluding the number itself).

For example:
- 6 is a perfect number because 1 + 2 + 3 = 6
- 28 is a perfect number because 1 + 2 + 4 + 7 + 14 = 28
- 496 is a perfect number because 1 + 2 + 4 + 8 + 16 + 31 + 62 + 124 + 248 = 496

Write a function that determines whether a given positive integer is a perfect number.

## Structure

- **Run Job (`run.xs`):** Calls the `perfect_number` function with test inputs
- **Function (`function/perfect_number.xs`):** Contains the solution logic to check if a number is perfect

## Function Signature

- **Input:**
  - `number` (int): A positive integer to check
  
- **Output:**
  - (bool): `true` if the number is perfect, `false` otherwise

## Algorithm

The solution uses an optimized approach:
1. Start with sum = 1 (since 1 is always a proper divisor for n > 1)
2. Iterate from 2 to √n to find divisors
3. For each divisor i found, add both i and n/i to the sum
4. Compare the sum to the original number

This optimization reduces the time complexity from O(n) to O(√n).

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| 6 | true | 1 + 2 + 3 = 6 |
| 28 | true | 1 + 2 + 4 + 7 + 14 = 28 |
| 496 | true | 1 + 2 + 4 + 8 + 16 + 31 + 62 + 124 + 248 = 496 |
| 1 | false | No proper divisors to sum |
| 2 | false | Proper divisor is just 1; 1 ≠ 2 |
| 12 | false | 1 + 2 + 3 + 4 + 6 = 16 ≠ 12 |
| 100 | false | 1 + 2 + 4 + 5 + 10 + 20 + 25 + 50 = 117 ≠ 100 |

## Known Perfect Numbers

The first few perfect numbers are: 6, 28, 496, 8128, 33550336, ...

All known perfect numbers are even. It is unknown whether any odd perfect numbers exist (this is an open problem in mathematics).
