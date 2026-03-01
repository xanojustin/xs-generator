# Convert a Number to Hexadecimal

## Problem

Given an integer `num`, return a string representing its hexadecimal representation.

For negative integers, two's complement method is used (32-bit representation).
All letters in the answer string should be lowercase characters, and there should not be any leading zeros in the answer except for the zero itself.

**Note:** In two's complement notation, negative numbers are represented by inverting all bits of the absolute value and adding 1. For 32-bit integers, this is equivalent to adding 2^32 (4294967296) to the negative number.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/number-to-hexadecimal.xs`):** Contains the solution logic

## Function Signature

- **Input:** 
  - `num` (int): The integer to convert to hexadecimal
- **Output:** 
  - (text): The hexadecimal representation as a lowercase string

## Algorithm

1. Handle the zero case specially (return "0")
2. For negative numbers, convert to positive using two's complement (add 2^32)
3. Repeatedly divide by 16 and use the remainder to index into hex characters
4. Build the result string from least significant to most significant digit

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| 26 | "1a" | 26 = 1×16 + 10 = "1a" |
| -1 | "ffffffff" | Two's complement of -1 in 32-bit is 4294967295 = 0xFFFFFFFF |
| 0 | "0" | Zero is a special case |
| 255 | "ff" | 255 = 15×16 + 15 = "ff" |
| -2 | "fffffffe" | Two's complement of -2 |
