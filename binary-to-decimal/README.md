# Binary to Decimal Conversion

## Problem

Convert a binary string (containing only '0's and '1's) to its decimal (base-10) integer equivalent.

In binary representation:
- Each digit represents a power of 2
- The leftmost digit has the highest power: 2^(n-1) where n is string length
- The rightmost digit is 2⁰ (1)
- We calculate the decimal value by summing: (bit × 2^position) for each bit

### Algorithm
1. Initialize decimal result to 0
2. Get the length of the binary string
3. For each character in the binary string (left to right):
   - Convert the character "0" or "1" to integer 0 or 1
   - Calculate its position power: 2^(length - index - 1)
   - Add (bit × power) to the decimal result
4. Return the accumulated decimal value

## Structure

- **Run Job (`run.xs`):** Calls the `binary_to_decimal` function with test input ("101010")
- **Function (`function/binary_to_decimal.xs`):** Contains the conversion logic using positional powers of 2

## Function Signature

- **Input:** 
  - `binary_string` (text): A string containing only '0's and '1's representing a binary number
- **Output:** 
  - `decimal` (int): The decimal (base-10) integer equivalent

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| "" | 0 | Edge case: empty string returns 0 |
| "0" | 0 | Single zero bit |
| "1" | 1 | Single one bit: 2⁰ = 1 |
| "101" | 5 | 4 + 1 = 5 → (1×2²) + (0×2¹) + (1×2⁰) |
| "1010" | 10 | 8 + 2 = 10 → (1×2³) + (0×2²) + (1×2¹) + (0×2⁰) |
| "101010" | 42 | 32 + 8 + 2 = 42 |
| "11111111" | 255 | Maximum 8-bit value: sum of 2⁰ to 2⁷ = 255 |
| "10000000000" | 1024 | Power of 2: 2¹⁰ = 1024 |

### Example Walkthrough: "101010" → 42

| Index | Bit | Position | Power (2^pos) | Bit × Power | Running Sum |
|-------|-----|----------|---------------|-------------|-------------|
| 0 | 1 | 5 | 32 | 32 | 32 |
| 1 | 0 | 4 | 16 | 0 | 32 |
| 2 | 1 | 3 | 8 | 8 | 40 |
| 3 | 0 | 2 | 4 | 0 | 40 |
| 4 | 1 | 1 | 2 | 2 | 42 |
| 5 | 0 | 0 | 1 | 0 | 42 |

Final result: **42**
