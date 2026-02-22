# Reverse Bits

## Problem
Reverse the bits of a given unsigned 32-bit integer.

For example, given the input `43261596` (binary: `00000010100101000000111101001100`), 
the function should return `964176192` (binary: `00110010111100000010100101000000`).

Note that in some languages (like Java), there is no unsigned integer type. In this case, 
both input and output will be given as signed integers, which should not affect the 
implementation (the internal binary representation is the same).

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/reverse_bits.xs`):** Contains the solution logic

## Function Signature
- **Input:** `n` (int) - An unsigned 32-bit integer whose bits need to be reversed
- **Output:** (int) - The integer value after reversing all 32 bits of the input

## How It Works
The algorithm iterates through all 32 bits of the input number:
1. Left shift the result by 1 to make room for the next bit
2. Extract the least significant bit (LSB) from the current number
3. Add that bit to the result
4. Right shift (divide by 2) the current number to process the next bit
5. Repeat for all 32 bits

This effectively builds the result by taking bits from the right of the input and 
appending them to the left of the result.

## Test Cases

| Input | Binary Input | Binary Output | Expected Output |
|-------|--------------|---------------|-----------------|
| 0 | `00000000000000000000000000000000` | `00000000000000000000000000000000` | 0 |
| 1 | `00000000000000000000000000000001` | `10000000000000000000000000000000` | 2147483648 |
| 43261596 | `00000010100101000000111101001100` | `00110010111100000010100101000000` | 964176192 |
| 4294967295 | `11111111111111111111111111111111` | `11111111111111111111111111111111` | 4294967295 |

### Edge Cases
- **Zero (0):** All bits are 0, reversed result is also 0
- **One (1):** Only LSB is set, reversed result has only MSB set (2147483648)
- **All bits set (4294967295):** Reversing all 1s still gives all 1s

## Complexity Analysis
- **Time Complexity:** O(1) - We always iterate exactly 32 times (constant)
- **Space Complexity:** O(1) - We only use a few variables regardless of input
