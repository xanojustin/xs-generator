# Add Digits (Digital Root)

## Problem
Given an integer `num`, repeatedly add all its digits until the result has only one digit, and return it.

This is known as the **digital root** of a number.

### Examples
- **Input:** num = 38  
  **Output:** 2  
  **Explanation:** 3 + 8 = 11, 1 + 1 = 2

- **Input:** num = 0  
  **Output:** 0

- **Input:** num = 9  
  **Output:** 9

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/add_digits.xs`):** Contains the solution logic using the mathematical digital root formula

## Function Signature
- **Input:** 
  - `num` (int): The integer to compute the digital root for
- **Output:** 
  - (int): The single digit result (0-9)

## Algorithm
This solution uses the **mathematical digital root formula**: `1 + (num - 1) % 9`

This formula works because of properties of modulo 9 arithmetic:
- The digital root of a number is congruent to the number modulo 9
- For positive numbers, the digital root cycles through 1-9
- Edge case: 0 returns 0

**Time Complexity:** O(1) - constant time mathematical operation  
**Space Complexity:** O(1) - no additional space used

## Test Cases
| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| 38 | 2 | 3 + 8 = 11 → 1 + 1 = 2 |
| 0 | 0 | Edge case: single digit zero |
| 9 | 9 | Single digit, no addition needed |
| 12345 | 6 | 1+2+3+4+5 = 15 → 1+5 = 6 |
| 999 | 9 | 9+9+9 = 27 → 2+7 = 9 |
| 1000 | 1 | 1+0+0+0 = 1 |
