# Sum of Digits

## Problem

Write a function that calculates the sum of all digits in a given integer.

For example:
- Input: `123` → Output: `6` (1 + 2 + 3 = 6)
- Input: `-456` → Output: `15` (4 + 5 + 6 = 15, negatives are treated as positive)
- Input: `0` → Output: `0`

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test input (12345)
- **Function (`function/sum_of_digits.xs`):** Contains the solution logic that extracts and sums each digit

## Function Signature

- **Input:** `number` (int) - The integer whose digits will be summed
- **Output:** `sum` (int) - The sum of all digits in the input number

## Algorithm

The solution uses a while loop to repeatedly:
1. Extract the last digit using modulo 10 (`n % 10`)
2. Add the digit to the running sum
3. Remove the last digit using integer division (`n / 10`)

This handles negative numbers by first converting to absolute value.

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `12345` | `15` | 1 + 2 + 3 + 4 + 5 = 15 |
| `0` | `0` | Single zero digit |
| `-456` | `15` | Negative treated as positive: 4 + 5 + 6 = 15 |
| `999` | `27` | 9 + 9 + 9 = 27 |
| `7` | `7` | Single digit |

## Files

- `run.xs` - Run job entry point
- `function/sum_of_digits.xs` - Solution implementation
