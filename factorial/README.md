# Factorial

## Problem

Calculate the factorial of a non-negative integer n.

The factorial of a non-negative integer n, denoted as n!, is the product of all positive integers less than or equal to n.

- n! = n × (n-1) × (n-2) × ... × 2 × 1
- By definition: 0! = 1

This is a classic mathematical problem that tests understanding of:
- Iterative algorithms
- Multiplication operations
- Edge case handling (especially 0!)
- Input validation

## Function Signature

- **Input:** `n` (int) - The non-negative integer to calculate factorial for (0 ≤ n ≤ 20)
- **Output:** `int` - The factorial of n

**Note:** The maximum input is limited to 20 because 21! exceeds the maximum safe integer value (2,432,902,008,176,640,000 for 20!).

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| 0 | 1 | Base case: 0! = 1 by definition |
| 1 | 1 | 1! = 1 |
| 5 | 120 | 5! = 5 × 4 × 3 × 2 × 1 = 120 |
| 10 | 3,628,800 | 10! = 3,628,800 |
| 20 | 2,432,902,008,176,640,000 | Maximum safe value |

### Edge Cases Explained

1. **n = 0**: The base case - factorial of 0 is defined as 1
2. **n = 1**: Single iteration case - factorial of 1 is 1
3. **n = 5**: Classic test case used in many examples
4. **n = 20**: Maximum allowed value before integer overflow
5. **Negative input**: Should fail validation (min:0 filter)
6. **n > 20**: Should fail validation (max:20 filter) to prevent overflow

## Mathematical Background

Factorial is used in many areas of mathematics:
- Combinatorics (counting permutations and combinations)
- Probability theory
- Taylor series expansions
- Recursive algorithm analysis

### Example Calculation

```
5! = 5 × 4 × 3 × 2 × 1
   = 20 × 3 × 2 × 1
   = 60 × 2 × 1
   = 120 × 1
   = 120
```
