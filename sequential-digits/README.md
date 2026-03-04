# Sequential Digits

## Problem
Given an inclusive range `[low, high]`, return a sorted list of all integers in that range that have **sequential digits**.

An integer has sequential digits if and only if each digit in the number is exactly one more than the previous digit.

### Examples
- `123` is sequential (digits: 1, 2, 3)
- `4567` is sequential (digits: 4, 5, 6, 7)
- `23456` is sequential (digits: 2, 3, 4, 5, 6)
- `124` is **not** sequential (1→2 is +1, but 2→4 is +2)
- `321` is **not** sequential (digits are decreasing)
- `135` is **not** sequential (skips digits)

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs `[100, 300]`
- **Function (`function/sequential_digits.xs`):** Contains the solution logic to generate sequential digit numbers

## Function Signature
- **Input:**
  - `low` (int): Lower bound of the range (inclusive)
  - `high` (int): Upper bound of the range (inclusive)
- **Output:**
  - `int[]`: Sorted array of all sequential digit numbers in the range

## Approach
The solution generates all possible sequential digit numbers by:
1. Starting with each digit from 1 to 9
2. Building numbers by appending the next sequential digit (current_digit + 1)
3. Checking if each generated number falls within the [low, high] range
4. Collecting and sorting valid numbers before returning

This approach is efficient because there are only a limited number of sequential digit numbers (max 45 for all 1-9 digit lengths combined).

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `low: 100, high: 300` | `[123, 234]` |
| `low: 1000, high: 13000` | `[1234, 2345, 3456, 4567, 5678, 6789, 12345]` |
| `low: 10, high: 20` | `[12]` |
| `low: 58, high: 155` | `[67, 78, 89, 123]` |
| `low: 1, high: 9` | `[]` (single digits don't have sequential digits) |
