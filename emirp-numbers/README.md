# Emirp Numbers

## Problem

An **emirp** (prime spelled backwards) is a prime number that results in a different prime when its decimal digits are reversed. For example, 13 is an emirp because both 13 and 31 are prime numbers.

Write a function that determines whether a given positive integer is an emirp number.

**Note:** Palindromic primes (like 11, 101) are NOT emirp numbers because the reversed number is the same as the original.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/emirp_numbers.xs`):** Contains the solution logic

## Function Signature

- **Input:** 
  - `n` (int): A non-negative integer to check
- **Output:** 
  - (bool): `true` if the number is an emirp, `false` otherwise

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| 13 | true | 13 is prime, 31 is prime, and 13 ≠ 31 |
| 2 | false | 2 is prime, but reversed is still 2 (palindrome) |
| 11 | false | 11 is prime, but reversed is still 11 (palindrome) |
| 4 | false | Not a prime number |
| 0 | false | Not a prime number |
| 1 | false | Not a prime number |
| 23 | true | 23 is prime, 32 is... wait, let me fix this - 23 reversed is 32 which is not prime. So 23 should be false. Let me recalculate: 23 is NOT an emirp. Let me use 17 instead - 17 reversed is 71, both prime. So 17 is an emirp. |

### Corrected Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| 13 | true | 13 is prime, 31 is prime, and 13 ≠ 31 ✓ |
| 17 | true | 17 is prime, 71 is prime, and 17 ≠ 71 ✓ |
| 2 | false | Prime but palindrome |
| 11 | false | Prime but palindrome |
| 23 | false | 23 is prime but 32 is not prime |
| 4 | false | Not prime |
| 0 | false | Not prime |
| 1 | false | Not prime |
