# Pow(x, n)

## Problem
Implement a function to calculate `x` raised to the power `n` (i.e., `x^n`).

The solution should handle:
- Positive exponents
- Negative exponents (returning 1/x^|n|)
- Zero exponent (any number^0 = 1)

**Constraints:**
- Use fast exponentiation (divide and conquer) for O(log n) time complexity
- Do not use built-in power operators
- Handle edge cases properly

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs (2^10 = 1024)
- **Function (`function/pow_x_n.xs`):** Main entry point that handles negative exponents
- **Function (`function/fast_pow.xs`):** Recursive helper using divide-and-conquer fast exponentiation

## Function Signature
- **Input:** 
  - `x` (decimal): The base number
  - `n` (int): The exponent (can be negative)
- **Output:** 
  - (decimal): The result of x^n

## Algorithm

### Fast Exponentiation (Divide and Conquer)
Instead of multiplying x by itself n times (O(n)), we use the properties:

- If n == 0: x^0 = 1
- If n < 0: x^n = 1 / x^(-n)
- If n is even: x^n = (x^2)^(n/2)
- If n is odd: x^n = x * x^(n-1)

This reduces time complexity from O(n) to O(log n).

## Test Cases

| Input (x, n) | Expected Output | Notes |
|--------------|-----------------|-------|
| (2.0, 10) | 1024.0 | Basic positive exponent |
| (2.0, -2) | 0.25 | Negative exponent (1/4) |
| (5.0, 0) | 1.0 | Zero exponent edge case |
| (2.0, 1) | 2.0 | Single power |
| (3.0, 3) | 27.0 | Odd exponent |
| (10.0, 5) | 100000.0 | Large result |

## Complexity
- **Time:** O(log n) - We halve the exponent at each step
- **Space:** O(log n) - Recursive call stack depth
