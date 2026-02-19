# FizzBuzz

## Problem

Write a function that generates the FizzBuzz sequence up to a given number `n`.

For each number from 1 to n:
- If the number is divisible by both 3 and 5, output "FizzBuzz"
- If the number is divisible by 3, output "Fizz"
- If the number is divisible by 5, output "Buzz"
- Otherwise, output the number itself (as a string)

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/fizzbuzz.xs`):** Contains the solution logic

## Function Signature

- **Input:** 
  - `n` (int): Upper limit of the sequence (inclusive)
- **Output:** 
  - Array of strings/integers representing the FizzBuzz sequence

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| 5 | `["1", "2", "Fizz", "4", "Buzz"]` |
| 15 | `["1", "2", "Fizz", "4", "Buzz", "Fizz", "7", "8", "Fizz", "Buzz", "11", "Fizz", "13", "14", "FizzBuzz"]` |
| 1 | `["1"]` |
| 0 | `[]` |

### Test Case Descriptions

1. **Basic case (n=5):** Tests Fizz, Buzz, and regular numbers
2. **Full FizzBuzz case (n=15):** Tests the complete cycle including "FizzBuzz"
3. **Edge case (n=1):** Minimum valid input
4. **Edge case (n=0):** Empty sequence
