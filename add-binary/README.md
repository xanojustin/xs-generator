# Add Binary

## Problem

Given two binary strings `a` and `b`, return their sum as a binary string.

The input strings are both non-empty and contain only characters `1` or `0`. The function simulates binary addition digit by digit from right to left, handling the carry properly.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/add_binary.xs`):** Contains the solution logic

## Function Signature

- **Input:**
  - `a` (text): First binary string (contains only 0s and 1s)
  - `b` (text): Second binary string (contains only 0s and 1s)
- **Output:**
  - Binary string representing the sum of `a` and `b`

## Algorithm

1. Initialize pointers at the end of both strings
2. Process digits from right to left:
   - Get current digit from each string (or 0 if exhausted)
   - Add digits plus any carry from previous position
   - Current digit = sum % 2, new carry = sum / 2
   - Prepend current digit to result
3. Continue until both strings are processed and no carry remains

## Test Cases

| Input a | Input b | Expected Output |
|---------|---------|-----------------|
| "11" | "1" | "100" |
| "1010" | "1011" | "10101" |
| "0" | "0" | "0" |
| "1" | "111" | "1000" |
| "1111" | "1111" | "11110" |
| "" | "101" | "101" |

### Test Case Descriptions

1. **Basic case ("11" + "1"):** Simple addition with carry propagation (3 + 1 = 4)
2. **Equal length ("1010" + "1011"):** Two 4-bit numbers (10 + 11 = 21)
3. **Edge case ("0" + "0"):** Both zeros
4. **Different lengths ("1" + "111"):** Single bit plus triple bit (1 + 7 = 8)
5. **Carry overflow ("1111" + "1111"):** 15 + 15 = 30, requires extra bit
6. **Empty string:** Handles edge case of empty input
