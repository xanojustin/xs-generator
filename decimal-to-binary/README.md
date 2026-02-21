# Decimal to Binary Conversion

## Problem

Convert a non-negative decimal (base-10) integer to its binary (base-2) string representation.

In binary representation:
- Each digit represents a power of 2
- The rightmost digit is 2⁰ (1), then 2¹ (2), 2² (4), and so on
- We build the binary number by repeatedly dividing by 2 and tracking remainders

### Algorithm
1. If the number is 0, return "0"
2. While the number is greater than 0:
   - Divide the number by 2
   - Record the remainder (0 or 1)
   - The remainder becomes the next binary digit (prepended to result)
   - Continue with the quotient
3. Return the accumulated binary string

## Structure

- **Run Job (`run.xs`):** Calls the `decimal_to_binary` function with test input (42)
- **Function (`function/decimal_to_binary.xs`):** Contains the conversion logic using repeated division

## Function Signature

- **Input:** 
  - `number` (int, non-negative): The decimal integer to convert
- **Output:** 
  - `binary_string` (text): The binary representation as a string of '0's and '1's

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| 0 | "0" | Edge case: zero is represented as "0" |
| 1 | "1" | Single bit: 2⁰ = 1 |
| 5 | "101" | 4 + 1 = 5 → binary 101 |
| 10 | "1010" | 8 + 2 = 10 → binary 1010 |
| 42 | "101010" | 32 + 8 + 2 = 42 → binary 101010 |
| 255 | "11111111" | Maximum 8-bit value: all ones |
| 1024 | "10000000000" | Power of 2: 2¹⁰ |

### Example Walkthrough: 42 → "101010"

| Step | Number | ÷ 2 | Remainder | Binary String |
|------|--------|-----|-----------|---------------|
| 1 | 42 | 21 | 0 | "0" |
| 2 | 21 | 10 | 1 | "10" |
| 3 | 10 | 5 | 0 | "010" |
| 4 | 5 | 2 | 1 | "1010" |
| 5 | 2 | 1 | 0 | "01010" |
| 6 | 1 | 0 | 1 | "101010" |
| Done | 0 | - | - | "101010" |

Final result: **"101010"**
