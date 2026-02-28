# Digital Root

## Problem

The digital root of a number is the single-digit value obtained by an iterative process of summing digits, on each iteration using the result from the previous iteration as the input to the next, until a single-digit number is reached.

For example:
- 16 → 1 + 6 = **7**
- 942 → 9 + 4 + 2 = 15 → 1 + 5 = **6**
- 132189 → 1 + 3 + 2 + 1 + 8 + 9 = 24 → 2 + 4 = **6**

The digital root can also be computed using the mathematical formula: `1 + (n - 1) % 9` for positive numbers (returns 0 for n = 0).

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/digital_root.xs`):** Contains the solution logic using the mathematical formula

## Function Signature

- **Input:** 
  - `n` (int): A non-negative integer (0 or greater)
- **Output:** 
  - `result` (int): The digital root (a single digit from 0-9)

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| 16 | 7 | 1 + 6 = 7 |
| 942 | 6 | 9 + 4 + 2 = 15 → 1 + 5 = 6 |
| 132189 | 6 | 1 + 3 + 2 + 1 + 8 + 9 = 24 → 2 + 4 = 6 |
| 0 | 0 | Edge case: digital root of 0 is 0 |
| 9 | 9 | Single digit: already the result |
| 10 | 1 | 1 + 0 = 1 |
| 999999999999 | 9 | Large number test |

## Mathematical Approach

This implementation uses the efficient mathematical formula rather than iterative digit summing:
- For n > 0: `digital_root(n) = 1 + (n - 1) % 9`
- For n = 0: `digital_root(0) = 0`

This formula works because the digital root cycles through 1-9 repeatedly as numbers increase, similar to modulo 9 arithmetic with a special case for multiples of 9.
