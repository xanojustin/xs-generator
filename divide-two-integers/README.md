# Divide Two Integers

## Problem
Given two integers `dividend` and `divisor`, divide two integers without using multiplication, division, and mod operators.

The integer division should truncate toward zero, which means losing its fractional part. For example, `truncate(8.345) = 8` and `truncate(-2.7335) = -2`.

Return the quotient after dividing `dividend` by `divisor`.

**Note:** Assume we are dealing with an environment that could only store integers within the 32-bit signed integer range: `[−2³¹, 2³¹ − 1]`. For this problem, if the quotient is strictly greater than `2³¹ − 1`, then return `2³¹ − 1`, and if the quotient is strictly less than `−2³¹`, then return `−2³¹`.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/divide_integers.xs`):** Contains the solution logic using bit manipulation (binary long division)

## Function Signature
- **Input:** 
  - `dividend` (int): The number to be divided
  - `divisor` (int): The number to divide by (must be non-zero)
- **Output:** 
  - `quotient` (int): The result of integer division, truncated toward zero

## Algorithm
The solution uses **binary long division** (also known as the "exponential search" or "doubling" method):

1. Handle edge cases:
   - Divisor is zero (error)
   - Integer overflow: when dividend is MIN_INT (-2³¹) and divisor is -1, result would be 2³¹ which overflows, so return MAX_INT (2³¹ - 1)

2. Determine the sign of the result by checking if dividend and divisor have opposite signs

3. Convert both numbers to positive values for easier computation

4. Use binary long division:
   - Repeatedly find the largest multiple of the divisor that fits in the remaining dividend
   - Double the divisor and a counter until it no longer fits
   - Subtract the largest fitting value from dividend and add the corresponding multiple to quotient

5. Apply the sign to the result

**Time Complexity:** O(log²n) where n is the dividend
**Space Complexity:** O(1)

## Test Cases

| Dividend | Divisor | Expected Output | Notes |
|----------|---------|-----------------|-------|
| 10 | 3 | 3 | Basic case: 10/3 = 3.33... → 3 |
| 7 | -3 | -2 | Negative divisor: 7/-3 = -2.33... → -2 |
| -7 | 3 | -2 | Negative dividend: -7/3 = -2.33... → -2 |
| -7 | -3 | 2 | Both negative: -7/-3 = 2.33... → 2 |
| 0 | 1 | 0 | Edge case: zero dividend |
| 1 | 1 | 1 | Edge case: same value |
| -2147483648 | -1 | 2147483647 | Integer overflow case: returns MAX_INT |
| 100 | 3 | 33 | Larger dividend |
| 1 | 2 | 0 | Dividend smaller than divisor |
