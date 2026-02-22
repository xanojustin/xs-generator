# Multiply Strings

## Problem
Given two non-negative integers represented as strings, return their product, also represented as a string.

This problem demonstrates how to handle arbitrarily large number multiplication without using built-in big integer libraries. The numbers may be too large to fit in standard 32-bit or 64-bit integers, so we must perform the multiplication digit by digit using the elementary school algorithm.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/multiply_strings.xs`):** Contains the solution logic

## Function Signature
- **Input:** 
  - `num1` (text): First non-negative integer as a string
  - `num2` (text): Second non-negative integer as a string
- **Output:** 
  - (text): Product of num1 and num2 as a string

## Algorithm
The solution uses the elementary school multiplication approach:
1. Handle edge case where either number is "0" → return "0"
2. Create a result array of size len1 + len2 (maximum possible result length)
3. Multiply each digit of num1 with each digit of num2
4. Position the partial results correctly based on digit positions
5. Handle carries appropriately
6. Convert the result array to a string, skipping leading zeros

## Test Cases

| num1 | num2 | Expected Output |
|------|------|-----------------|
| "123" | "456" | "56088" |
| "2" | "3" | "6" |
| "0" | "123" | "0" |
| "999" | "999" | "998001" |
| "123456789" | "987654321" | "121932631112635269" |

### Test Case Descriptions
1. **Basic case:** Standard 3-digit multiplication (123 × 456 = 56088)
2. **Single digit:** Simple single-digit multiplication (2 × 3 = 6)
3. **Edge case (zero):** Any number multiplied by zero equals zero
4. **Carry-heavy:** Multiple carries throughout calculation (999 × 999)
5. **Large numbers:** Big integers that would overflow standard types
