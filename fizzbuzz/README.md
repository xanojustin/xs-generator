# FizzBuzz

## Problem

Generate the FizzBuzz sequence from 1 to n.

For each number from 1 to n (inclusive):
- If the number is divisible by 3 and 5, return "FizzBuzz"
- If the number is divisible by 3, return "Fizz"
- If the number is divisible by 5, return "Buzz"
- Otherwise, return the number as a string

This is a classic coding interview question that tests basic control flow (conditionals and loops) and string manipulation.

## Function Signature

- **Input:** `n` (int) - The upper limit of the sequence (must be >= 1, max 10000)
- **Output:** `text[]` - An array of strings representing the FizzBuzz sequence

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| 3 | `["1", "2", "Fizz"]` |
| 5 | `["1", "2", "Fizz", "4", "Buzz"]` |
| 15 | `["1", "2", "Fizz", "4", "Buzz", "Fizz", "7", "8", "Fizz", "Buzz", "11", "Fizz", "13", "14", "FizzBuzz"]` |
| 1 | `["1"]` |
| 0 | Error (validation: min:1) |
| 30 | Contains "FizzBuzz" at positions 15 and 30 |

### Edge Cases Explained

1. **n = 1**: Single element array with just "1" - tests the lower boundary
2. **n = 15**: First occurrence of "FizzBuzz" - tests the divisibility check for both 3 and 5
3. **n = 0**: Should fail validation since n must be >= 1
4. **Large n (10000)**: Tests performance with maximum allowed input
