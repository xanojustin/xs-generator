# Counting Bits

## Problem

Given an integer `n`, return an array `ans` of length `n + 1` such that for each `i` (0 <= `i` <= `n`), `ans[i]` is the number of 1's in the binary representation of `i`.

This is also known as counting the "population count" or "Hamming weight" of each number.

### Example
- 0 in binary is `0` → 0 bits set
- 1 in binary is `1` → 1 bit set
- 2 in binary is `10` → 1 bit set
- 3 in binary is `11` → 2 bits set
- 4 in binary is `100` → 1 bit set
- 5 in binary is `101` → 2 bits set

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/counting-bits.xs`):** Contains the solution logic

## Function Signature

- **Input:**
  - `n` (int, min: 0) - The upper bound number (inclusive)
- **Output:** 
  - Array of integers where each element at index `i` represents the count of 1 bits in the binary representation of `i`

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| 2 | [0, 1, 1] | 0→0, 1→1, 10→1 |
| 5 | [0, 1, 1, 2, 1, 2] | 0→0, 1→1, 10→1, 11→2, 100→1, 101→2 |
| 0 | [0] | Single number, no bits set |
| 7 | [0, 1, 1, 2, 1, 2, 2, 3] | All numbers 0-7, max bits is 3 (for 7 = 111) |

## Algorithm

The solution uses a brute-force approach:
1. Iterate through each number from 0 to n
2. For each number, count the set bits by:
   - Repeatedly checking the least significant bit (num % 2)
   - Right-shifting (dividing by 2) to process the next bit
3. Store the count and continue

Time Complexity: O(n log n) - for each of n numbers, we process log(n) bits
Space Complexity: O(n) - for the result array
