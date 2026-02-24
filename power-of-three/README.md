# Power of Three

## Problem

Given an integer `n`, return `true` if it is a power of three. Otherwise, return `false`.

An integer `n` is a power of three if there exists an integer `x` such that `n == 3^x`.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/is_power_of_three.xs`):** Contains the solution logic

## Function Signature

- **Input:** 
  - `n` (int): The integer to check
- **Output:** 
  - (bool): `true` if `n` is a power of three, `false` otherwise

## Algorithm

The solution uses iterative division:
1. Handle edge cases: numbers ≤ 0 are not powers of three
2. Handle base case: 1 is 3^0, so it's a power of three
3. Repeatedly divide by 3 while checking divisibility
4. If we can divide all the way down to 1, it's a power of three
5. If at any point the number is not divisible by 3, it's not a power of three

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| 27 | true | 27 = 3³ |
| 9 | true | 9 = 3² |
| 1 | true | 1 = 3⁰ |
| 0 | false | 0 is not a power of three |
| -9 | false | Negative numbers are not powers of three |
| 45 | false | 45 = 9 × 5, not a pure power of 3 |
| 3 | true | 3 = 3¹ |
| 81 | true | 81 = 3⁴ |
