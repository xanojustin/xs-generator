# Find Numbers with Even Number of Digits

## Problem

Given an array of integers, return how many of them contain an **even number of digits**.

### Examples
- **Input:** `[12, 345, 2, 6, 7896]` → **Output:** `2`
  - 12 has 2 digits (even) ✓
  - 345 has 3 digits (odd)
  - 2 has 1 digit (odd)
  - 6 has 1 digit (odd)
  - 7896 has 4 digits (even) ✓

- **Input:** `[555, 901, 482, 1771]` → **Output:** `1`
  - Only 1771 has 4 digits (even)

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/count_even_digit_numbers.xs`):** Contains the solution logic

## Function Signature

- **Input:** `int[] nums` — An array of integers (may include negative numbers, zero, and positive numbers)
- **Output:** `int` — The count of numbers that have an even number of digits

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[12, 345, 2, 6, 7896]` | `2` | 12 (2 digits), 7896 (4 digits) have even digits |
| `[555, 901, 482, 1771]` | `1` | Only 1771 has 4 digits (even) |
| `[]` | `0` | Empty array — edge case |
| `[0]` | `0` | Zero has 1 digit (odd) — edge case |
| `[1, 22, 333, 4444, 55555]` | `2` | 22 (2 digits), 4444 (4 digits) have even digits |
| `[-12, -345, -6789]` | `2` | -12 (2 digits), -6789 (4 digits) — negative numbers handled |

## Approach

1. Iterate through each number in the array
2. Convert the absolute value of the number to text
3. Count the length of the text representation
4. Check if the length is even (divisible by 2)
5. Increment counter for each number with even digit count
6. Return the final count
