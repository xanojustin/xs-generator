# Reverse Integer

## Problem
Given a signed 32-bit integer `x`, return `x` with its digits reversed. If reversing `x` causes the value to go outside the signed 32-bit integer range `[-2^31, 2^31 - 1]`, then return `0`.

**Environment:** Assume we are dealing with an environment that can only store integers within the 32-bit signed integer range.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test input
- **Function (`function/reverse-integer.xs`):** Contains the solution logic with overflow handling

## Function Signature
- **Input:** 
  - `x` (int): The integer to reverse
- **Output:** 
  - (int): The reversed integer, or 0 if overflow occurs

## Algorithm
1. Handle the sign by working with absolute values
2. Extract digits one by one using modulo and division
3. Build the reversed number digit by digit
4. **Overflow check:** Before adding each digit, verify that the new value won't exceed 32-bit bounds
5. Apply the original sign and return

## Test Cases

| Input | Expected Output | Notes |
|-------|-----------------|-------|
| 123 | 321 | Basic positive number |
| -123 | -321 | Negative number |
| 120 | 21 | Trailing zeros become leading zeros (which are dropped) |
| 0 | 0 | Edge case: zero |
| 1534236469 | 0 | Overflow case: reversed exceeds 2^31-1 |
| -2147483648 | 0 | Overflow case: reversed would be less than -2^31 |
| 1463847412 | 2147483641 | Boundary case: largest valid reverse |

## Constraints
- `-2^31 <= x <= 2^31 - 1`
- 32-bit signed integer overflow must return 0
