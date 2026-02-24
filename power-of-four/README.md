# Power of Four

## Problem

Given an integer `n`, return `true` if it is a power of four. Otherwise, return `false`.

An integer `n` is a power of four if there exists an integer `x` such that `n == 4^x`.

Examples of powers of four: 1, 4, 16, 64, 256, 1024, ...

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/is_power_of_four.xs`):** Contains the solution logic using bit manipulation

## Function Signature

- **Input:**
  - `number` (int): The integer to check
- **Output:** 
  - (bool): `true` if the number is a power of four, `false` otherwise

## Approach

This solution uses bit manipulation for O(1) time complexity:

1. **Check positive:** A power of four must be positive (n > 0)
2. **Check power of 2:** A number is a power of 2 if it has exactly one bit set. This is verified using `n & (n-1) == 0`
3. **Check even position:** The set bit must be in an even position (0, 2, 4, 6, ...). We check this using `n & 0x55555555 != 0`, where `0x55555555` has bits set only in even positions.

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| 16 | true | 16 = 4^2 |
| 1 | true | 1 = 4^0 |
| 64 | true | 64 = 4^3 |
| 5 | false | Not a power of four |
| 0 | false | Zero is not a power of four |
| -16 | false | Negative numbers are not powers of four |
| 2 | false | 2 is a power of 2 but not a power of 4 |
| 8 | false | 8 is a power of 2 but not a power of 4 |

## Why Bit Manipulation?

- **Time Complexity:** O(1) - constant time
- **Space Complexity:** O(1) - no extra space needed
- This is more efficient than iterative division or logarithmic approaches
