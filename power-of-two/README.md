# Power of Two

## Problem

Determine if a given integer is a power of two.

A number is a power of two if it can be written as 2^k where k is a non-negative integer.

Examples of powers of two:
- 1 = 2^0
- 2 = 2^1  
- 4 = 2^2
- 8 = 2^3
- 16 = 2^4

Numbers that are NOT powers of two:
- 0 (2^k is never 0)
- Negative numbers (2^k is always positive)
- 3, 5, 6, 7, 9, 10, etc. (not exact powers of 2)

## Function Signature

- **Input:** `n` (int) - The number to check (can be any integer: positive, negative, or zero)
- **Output:** `bool` - `true` if n is a power of two, `false` otherwise

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| 1 | `true` | 1 = 2^0, the smallest power of two |
| 2 | `true` | 2 = 2^1 |
| 4 | `true` | 4 = 2^2 |
| 8 | `true` | 8 = 2^3 |
| 16 | `true` | 16 = 2^4 |
| 3 | `false` | 3 is not a power of two |
| 5 | `false` | 5 is not a power of two |
| 6 | `false` | 6 is not a power of two |
| 0 | `false` | Zero is not a power of two |
| -1 | `false` | Negative numbers are not powers of two |
| -8 | `false` | Negative numbers are not powers of two |
| 1024 | `true` | 1024 = 2^10, a larger power of two |
| 2147483648 | `true` | 2^31, a very large power of two |
| 2147483647 | `false` | Max 32-bit int, not a power of two |

### Edge Cases Explained

1. **n = 1**: The smallest power of two (2^0 = 1). This is a boundary case that must return true.
2. **n = 0**: Zero is mathematically not a power of two since 2^k > 0 for all k.
3. **Negative numbers**: All powers of two are positive, so any negative number should return false.
4. **Large powers of two**: Testing with 1024 (2^10) or larger values ensures the algorithm handles bigger numbers correctly.
