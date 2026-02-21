# Sum of Two Integers

## Problem

Write a function that adds two integers `a` and `b` **without using the `+` or `-` operators**.

This classic bit manipulation exercise demonstrates how addition works at the binary level using only bitwise operations.

### Algorithm

1. **XOR (`^`)** gives the sum of two bits without considering the carry
   - `0 ^ 0 = 0`, `0 ^ 1 = 1`, `1 ^ 0 = 1`, `1 ^ 1 = 0`
   
2. **AND (`&`) + left shift** gives the carry
   - Carry occurs only when both bits are 1: `1 & 1 = 1`
   - The carry is added to the next higher bit position: `carry << 1`

3. Repeat until there is no carry left (`b == 0`)

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs (5 + 7 = 12)
- **Function (`function/sum_of_two_integers.xs`):** Contains the bit manipulation solution logic

## Function Signature

- **Input:**
  - `a` (int): First integer to add
  - `b` (int): Second integer to add
- **Output:**
  - (int): The sum of a and b

## Test Cases

| Input (a, b) | Expected Output | Explanation |
|--------------|-----------------|-------------|
| (5, 7) | 12 | 5 + 7 = 12 |
| (10, 20) | 30 | Basic addition |
| (0, 5) | 5 | Adding zero |
| (0, 0) | 0 | Both zeros |
| (-5, 5) | 0 | Negative and positive cancel |
| (100, 200) | 300 | Larger numbers |

### Test Case Descriptions

1. **Basic case (5, 7):** Tests standard positive integer addition
2. **Larger numbers (10, 20):** Tests with multi-bit numbers
3. **Edge case - add zero (0, 5):** Tests that adding zero works correctly
4. **Edge case - both zeros (0, 0):** Tests minimum case
5. **Negative number (-5, 5):** Tests two's complement handling (if supported)
6. **Large numbers (100, 200):** Tests with larger bit patterns
