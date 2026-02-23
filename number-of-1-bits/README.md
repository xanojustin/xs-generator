# Number of 1 Bits

## Problem

Write a function that takes an unsigned integer and returns the number of '1' bits it has (also known as the **Hamming weight** or **population count**).

For example:
- The 32-bit integer `11` has binary representation `00000000000000000000000000001011`
- It has **3** set bits (three '1's)

## Structure

- **Run Job (`run.xs`):** Calls the solution function with a test input
- **Function (`function/count_bits.xs`):** Contains the bit counting solution logic

## Function Signature

- **Input:** `n` (int) - A non-negative integer to count bits in
- **Output:** `int` - The number of 1 bits in the binary representation of `n`

## Algorithm

The solution uses a simple iterative approach:
1. Initialize a counter to 0
2. While the number is greater than 0:
   - Check if the number is odd (LSB is 1) using modulo 2
   - If odd, increment the counter
   - Right-shift by dividing by 2 (using floor division)
3. Return the counter

This effectively checks each bit position from right to left.

## Test Cases

| Input | Binary Representation | Expected Output |
|-------|----------------------|-----------------|
| 0 | `0` | 0 |
| 1 | `1` | 1 |
| 11 | `1011` | 3 |
| 128 | `10000000` | 1 |
| 2147483645 | `1111111111111111111111111111101` | 31 |

### Test Case Descriptions

1. **Zero (Edge Case):** The number 0 has no 1 bits
2. **Single Bit:** The number 1 has exactly one 1 bit
3. **Multiple Bits (Happy Path):** 11 = 8 + 2 + 1 = `1011` in binary has 3 set bits
4. **Power of Two:** 128 = `10000000` has exactly one 1 bit (useful for checking single-bit numbers)
5. **Large Number (Boundary):** Near-maximum 32-bit integer with mostly 1s

## Complexity Analysis

- **Time Complexity:** O(log n) - We process each bit of the number
- **Space Complexity:** O(1) - Only using a constant amount of extra space

## Notes

This is a common interview question (LeetCode #191). The algorithm works by repeatedly checking the least significant bit and right-shifting the number. An alternative approach uses Brian Kernighan's algorithm which is more efficient for sparse bit patterns.
