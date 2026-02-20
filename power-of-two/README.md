# Power of Two

## Problem
Determine if a given integer is a power of two. A number is a power of two if it can be expressed as 2^k where k is a non-negative integer (i.e., 1, 2, 4, 8, 16, 32, 64, etc.).

This implementation uses an efficient bit manipulation technique rather than iterative division or logarithms.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/is_power_of_two.xs`):** Contains the bit manipulation solution

## Function Signature
- **Input:** 
  - `n` (int): The integer to check
- **Output:** 
  - (bool): `true` if n is a power of two, `false` otherwise

## Algorithm Explanation

The bit manipulation trick: `n > 0 && (n & (n - 1)) == 0`

**Why this works:**
- Powers of two in binary have exactly one bit set:
  - 1 = 0001
  - 2 = 0010
  - 4 = 0100
  - 8 = 1000
- Subtracting 1 from a power of two flips all bits after and including the set bit
  - 4 (0100) - 1 = 3 (0011)
  - 8 (1000) - 1 = 7 (0111)
- When we AND `n` with `n-1`, the single set bit is cleared
- For powers of two, this results in 0 since there was only one bit set

**Edge cases handled:**
- Zero is not a power of two (the `n > 0` check)
- Negative numbers are not powers of two

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| 1 | true | 2^0 = 1 |
| 16 | true | 2^4 = 16 |
| 64 | true | 2^6 = 64 |
| 0 | false | Zero is not a power of two |
| -8 | false | Negative numbers are not powers of two |
| 3 | false | 3 = 2 + 1, not a power of two |
| 18 | false | 18 = 16 + 2, not a power of two |
| 1024 | true | 2^10 = 1024 (boundary case) |

## Complexity
- **Time Complexity:** O(1) - Constant time bit operations
- **Space Complexity:** O(1) - Constant extra space
