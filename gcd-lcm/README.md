# GCD and LCM Calculator

## Problem
Calculate the **Greatest Common Divisor (GCD)** and **Least Common Multiple (LCM)** of two positive integers.

The GCD is the largest positive integer that divides both numbers without a remainder. The LCM is the smallest positive integer that is divisible by both numbers.

### Mathematical Background
- **GCD** is calculated using the Euclidean algorithm: repeatedly replace the larger number with the remainder of dividing the two numbers until the remainder is zero.
- **LCM** is calculated using the relationship: `LCM(a, b) = (a × b) / GCD(a, b)`

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs (a=48, b=18)
- **Function (`function/gcd_lcm.xs`):** Contains the solution logic using the Euclidean algorithm

## Function Signature
- **Input:**
  - `a` (int): First positive integer (must be ≥ 1)
  - `b` (int): Second positive integer (must be ≥ 1)
- **Output:** Object containing:
  - `gcd` (int): Greatest Common Divisor of a and b
  - `lcm` (int): Least Common Multiple of a and b
  - `a` (int): Original first input value
  - `b` (int): Original second input value

## Test Cases

| Input (a, b) | Expected Output |
|--------------|-----------------|
| (48, 18) | GCD: 6, LCM: 144 |
| (56, 98) | GCD: 14, LCM: 392 |
| (1, 1) | GCD: 1, LCM: 1 |
| (100, 25) | GCD: 25, LCM: 100 |
| (17, 13) | GCD: 1, LCM: 221 (coprime) |

### Explanation of Test Cases
1. **Basic case (48, 18):** 48 = 2⁴ × 3, 18 = 2 × 3², GCD = 2 × 3 = 6, LCM = 144
2. **Typical case (56, 98):** Both even numbers with common factors
3. **Edge case (1, 1):** Minimum valid inputs
4. **Divisible case (100, 25):** One number divides the other
5. **Coprime case (17, 13):** Prime numbers with no common factors (GCD = 1)
