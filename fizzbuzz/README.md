# FizzBuzz

## Problem
Write a function that generates the FizzBuzz sequence from 1 to n.
- For multiples of 3, return "Fizz"
- For multiples of 5, return "Buzz"
- For multiples of both 3 and 5, return "FizzBuzz"
- Otherwise, return the number itself

## Structure
- **Run Job (`run.xs`):** Calls the fizzbuzz function with test input n=15
- **Function (`function/fizzbuzz.xs`):** Contains the FizzBuzz solution logic

## Function Signature
- **Input:** `n` (int) - The upper bound of the sequence (inclusive)
- **Output:** Array of strings/integers - The FizzBuzz sequence from 1 to n

## Test Cases
| Input | Expected Output |
|-------|-----------------|
| 5 | `[1, 2, "Fizz", 4, "Buzz"]` |
| 15 | `[1, 2, "Fizz", 4, "Buzz", "Fizz", 7, 8, "Fizz", "Buzz", 11, "Fizz", 13, 14, "FizzBuzz"]` |
| 1 | `[1]` |
| 3 | `[1, 2, "Fizz"]` |
