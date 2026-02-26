# Armstrong Number

## Problem

An **Armstrong number** (also known as a narcissistic number) is a number that equals the sum of its own digits each raised to the power of the number of digits.

For example:
- **153** is an Armstrong number because: 1³ + 5³ + 3³ = 1 + 125 + 27 = **153**
- **9474** is an Armstrong number because: 9⁴ + 4⁴ + 7⁴ + 4⁴ = 6561 + 256 + 2401 + 256 = **9474**
- **123** is NOT an Armstrong number because: 1³ + 2³ + 3³ = 1 + 8 + 27 = 36 ≠ **123**

Write a function that determines whether a given non-negative integer is an Armstrong number.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test input (153)
- **Function (`function/is_armstrong_number.xs`):** Contains the solution logic to check if a number is an Armstrong number

## Function Signature

- **Input:**
  - `number` (int): A non-negative integer to check
- **Output:** 
  - (bool): `true` if the number is an Armstrong number, `false` otherwise

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| 0 | true | 0¹ = 0 |
| 1 | true | 1¹ = 1 |
| 153 | true | 1³ + 5³ + 3³ = 153 |
| 370 | true | 3³ + 7³ + 0³ = 27 + 343 + 0 = 370 |
| 371 | true | 3³ + 7³ + 1³ = 27 + 343 + 1 = 371 |
| 407 | true | 4³ + 0³ + 7³ = 64 + 0 + 343 = 407 |
| 9474 | true | 9⁴ + 4⁴ + 7⁴ + 4⁴ = 9474 |
| 123 | false | 1³ + 2³ + 3³ = 36 ≠ 123 |
| 100 | false | 1³ + 0³ + 0³ = 1 ≠ 100 |

## Additional Notes

- Single-digit numbers (0-9) are always Armstrong numbers
- There are only 88 Armstrong numbers in base 10
- The largest Armstrong number is 115132219018763992565095597973971522401
