# GCD/LCM Calculator

## Problem

Write a function that calculates both the **Greatest Common Divisor (GCD)** and **Least Common Multiple (LCM)** of two integers.

### GCD (Greatest Common Divisor)
The GCD of two integers is the largest positive integer that divides both numbers without leaving a remainder. For example:
- GCD(12, 18) = 6 (6 is the largest number that divides both 12 and 18)
- GCD(7, 13) = 1 (7 and 13 are coprime - they share no common divisors other than 1)

### LCM (Least Common Multiple)
The LCM of two integers is the smallest positive integer that is divisible by both numbers. For example:
- LCM(4, 6) = 12 (12 is the smallest number divisible by both 4 and 6)
- LCM(3, 5) = 15

The LCM can be calculated using the formula:
```
LCM(a, b) = |a × b| / GCD(a, b)
```

This exercise demonstrates the classic **Euclidean algorithm** for computing GCD, which has been used for over 2,000 years and is one of the oldest algorithms still in common use.

## Function Signature

- **Input:** 
  - `a` (int) - First integer (can be negative, zero, or positive)
  - `b` (int) - Second integer (can be negative, zero, or positive)
- **Output:** `object` - An object containing:
  - `gcd` (int) - The greatest common divisor of a and b
  - `lcm` (int) - The least common multiple of a and b

## Test Cases

| Input (a, b) | Expected Output |
|--------------|-----------------|
| (12, 18) | `{"gcd": 6, "lcm": 36}` |
| (7, 13) | `{"gcd": 1, "lcm": 91}` |
| (48, 18) | `{"gcd": 6, "lcm": 144}` |
| (0, 5) | `{"gcd": 5, "lcm": 0}` |
| (5, 0) | `{"gcd": 5, "lcm": 0}` |
| (0, 0) | `{"gcd": 0, "lcm": 0}` |
| (-12, 18) | `{"gcd": 6, "lcm": 36}` |
| (17, 17) | `{"gcd": 17, "lcm": 17}` |
| (1, 1) | `{"gcd": 1, "lcm": 1}` |
| (100, 25) | `{"gcd": 25, "lcm": 100}` |

### Edge Cases Explained

1. **One input is zero (0, 5) or (5, 0)**: 
   - GCD(n, 0) = |n| (the absolute value of the non-zero number)
   - LCM(n, 0) = 0 (any number multiplied by 0 is 0)
   
2. **Both inputs are zero (0, 0)**:
   - GCD(0, 0) is mathematically undefined, but we return 0
   - LCM(0, 0) is also 0
   
3. **Negative numbers (-12, 18)**:
   - GCD is always positive, so we take absolute values
   - LCM is always positive
   
4. **Identical numbers (17, 17)**:
   - GCD is the number itself
   - LCM is also the number itself
   
5. **Coprime numbers (7, 13)**:
   - GCD is 1 (they share no common factors)
   - LCM is their product (7 × 13 = 91)

## Algorithm Approach

The solution uses the **Euclidean algorithm** to compute GCD:

1. Take absolute values of both inputs (GCD is always positive)
2. Apply the Euclidean algorithm:
   - While b ≠ 0:
     - temp = b
     - b = a % b (remainder of a divided by b)
     - a = temp
   - When b reaches 0, a contains the GCD

3. Calculate LCM using: `LCM(a, b) = |a × b| / GCD(a, b)`
   - If either number is 0, LCM is 0

### Why the Euclidean Algorithm Works
The algorithm is based on the principle that GCD(a, b) = GCD(b, a mod b). The remainder operation reduces the problem size at each step, making it very efficient.

**Time Complexity:** O(log(min(a, b))) - logarithmic in the smaller input  
**Space Complexity:** O(1) - only uses a few variables

## Historical Note

The Euclidean algorithm first appeared in Euclid's Elements around 300 BCE, making it one of the oldest algorithms still in use today. It's efficient, elegant, and demonstrates the power of iterative problem-solving.
