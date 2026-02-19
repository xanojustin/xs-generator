# FizzBuzz

## Problem
Generate a FizzBuzz sequence up to a given number n.

For each number from 1 to n:
- If the number is divisible by 3, output "Fizz"
- If the number is divisible by 5, output "Buzz"
- If the number is divisible by both 3 and 5, output "FizzBuzz"
- Otherwise, output the number as a string

This is a classic coding interview question that tests basic loop and conditional logic.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test input n=15
- **Function (`function/fizzbuzz.xs`):** Contains the solution logic that generates the FizzBuzz sequence

## Function Signature
- **Input:** 
  - `n` (int): The upper limit of the sequence (inclusive)
- **Output:** 
  - `text[]`: Array of strings representing the FizzBuzz sequence

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| n = 1 | `["1"]` |
| n = 3 | `["1", "2", "Fizz"]` |
| n = 5 | `["1", "2", "Fizz", "4", "Buzz"]` |
| n = 15 | `["1", "2", "Fizz", "4", "Buzz", "Fizz", "7", "8", "Fizz", "Buzz", "11", "Fizz", "13", "14", "FizzBuzz"]` |
| n = 0 | `[]` (edge case: empty result) |
| n = -5 | `[]` (edge case: negative input) |

## Key Logic Points
1. The order of checks matters: check divisibility by both 3 and 5 first, then individual cases
2. Numbers not divisible by 3 or 5 are converted to strings
3. Uses modulo operator (`%`) to check divisibility
4. Returns empty array for invalid inputs (n < 1)
