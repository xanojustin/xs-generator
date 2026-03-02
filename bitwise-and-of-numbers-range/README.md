# Bitwise AND of Numbers Range

## Problem

Given two integers `left` and `right` that represent the range `[left, right]`, return the bitwise AND of all numbers in this range, inclusive.

### Examples

- **Example 1:** Input: `left = 5`, `right = 7` → Output: `4`
  - Explanation: `5 & 6 & 7 = 4` (binary: `101 & 110 & 111 = 100`)
  
- **Example 2:** Input: `left = 0`, `right = 1` → Output: `0`
  - Explanation: `0 & 1 = 0`

### Key Insight

As numbers increase, lower bits change more frequently than higher bits. The bitwise AND of a range will preserve only the bits that remain 1 across ALL numbers in the range. This is equivalent to finding the common prefix of the binary representations of `left` and `right`.

The algorithm works by:
1. Right-shifting both numbers until they are equal (finding the common prefix)
2. Left-shifting the result back by the number of shifts

## Structure

- **Run Job (`run.xs`):** Defines the job that calls the solution function with test inputs
- **Function (`function/bitwise_and_range.xs`):** Contains the bit manipulation solution logic

## Function Signature

- **Input:**
  - `left` (int): The left bound of the range (inclusive)
  - `right` (int): The right bound of the range (inclusive)
  
- **Output:** 
  - Returns (int): The bitwise AND of all numbers in the range [left, right]

## Test Cases

| Input (left, right) | Expected Output | Explanation |
|---------------------|-----------------|-------------|
| (5, 7) | 4 | `5 & 6 & 7 = 4` |
| (8, 8) | 8 | Single number returns itself |
| (0, 1) | 0 | Edge case with zero |
| (10, 15) | 8 | `1010 & 1011 & ... & 1111 = 1000` |
| (16, 19) | 16 | Powers of 2 boundary |

### Test Case Breakdown

1. **Basic case (5, 7):** Tests the standard scenario with multiple numbers
2. **Single number (8, 8):** Edge case where range contains only one number
3. **Edge case with zero (0, 1):** Tests the boundary with zero
4. **Larger range (10, 15):** Tests with a range spanning multiple bits
5. **Power of 2 boundary (16, 19):** Tests around a power of 2 boundary where high bits are common
