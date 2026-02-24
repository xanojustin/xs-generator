# Gray Code Generator

## Problem
Generate an n-bit **Gray Code** sequence.

Gray Code is a binary numeral system where two successive values differ in exactly one bit. This property makes it useful in applications like digital communications, error correction, and Karnaugh maps.

### Algorithm
The Gray Code sequence is generated iteratively:
1. Start with `[0]`
2. For each bit position from 1 to n:
   - Mirror the current sequence (traverse it in reverse)
   - Add `2^(i-1)` to each mirrored value
   - Append these values to the original sequence

### Example
For n = 2:
- Start: `[0]`
- After i=1: `[0, 1]` (0 + 2^0 = 1 added)
- After i=2: `[0, 1, 3, 2]` (1 + 2^1 = 3, 0 + 2^1 = 2 added)

Binary representations:
- 0 = 00
- 1 = 01
- 3 = 11
- 2 = 10

Notice how consecutive values differ by exactly one bit!

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/gray_code.xs`):** Contains the solution logic

## Function Signature
- **Input:** 
  - `n` (int): Number of bits. Must be >= 1.
- **Output:** 
  - `int[]`: Array of integers representing the Gray Code sequence of length 2^n

## Test Cases

| Input (n) | Expected Output | Length |
|-----------|-----------------|--------|
| 1 | `[0, 1]` | 2 |
| 2 | `[0, 1, 3, 2]` | 4 |
| 3 | `[0, 1, 3, 2, 6, 7, 5, 4]` | 8 |
| 0 | `[]` | 0 (edge case) |
| 4 | `[0, 1, 3, 2, 6, 7, 5, 4, 12, 13, 15, 14, 10, 11, 9, 8]` | 16 |

### Verification
To verify the Gray Code property, check that consecutive numbers differ by exactly one bit:
```
0 (000) → 1 (001): differs in bit 0 ✓
1 (001) → 3 (011): differs in bit 1 ✓
3 (011) → 2 (010): differs in bit 0 ✓
2 (010) → 6 (110): differs in bit 2 ✓
...and so on
```

## Complexity
- **Time Complexity:** O(2^n) - We generate 2^n values
- **Space Complexity:** O(2^n) - We store 2^n values
