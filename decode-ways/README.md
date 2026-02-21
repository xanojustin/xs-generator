# Decode Ways

## Problem

A message containing letters from **A-Z** can be encoded into numbers using the following mapping:
- 'A' → 1
- 'B' → 2
- ...
- 'Z' → 26

Given a string `s` containing only digits, return the **number of ways** to decode it.

### Examples

- **Input:** `"12"`
  - **Output:** `2`
  - **Explanation:** "12" could be decoded as "AB" (1, 2) or "L" (12).

- **Input:** `"226"`
  - **Output:** `3`
  - **Explanation:** "226" could be decoded as:
    - "BZ" (2, 26)
    - "VF" (22, 6)
    - "BBF" (2, 2, 6)

- **Input:** `"0"`
  - **Output:** `0`
  - **Explanation:** No valid decoding (0 doesn't map to any letter).

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/decode_ways.xs`):** Contains the solution logic using dynamic programming

## Function Signature

- **Input:** 
  - `s` (text): A string containing only digits (0-9)
- **Output:** 
  - (int): The number of ways to decode the string

## Algorithm

This solution uses **dynamic programming** with **O(n)** time complexity and **O(1)** space complexity:

1. `dp[i]` represents the number of ways to decode the substring `s[0..i-1]`
2. **Base case:** `dp[0] = 1` (empty string has one way to decode)
3. **Recurrence:**
   - **Single digit:** If `s[i-1]` is not '0', add `dp[i-1]` (decode last digit alone)
   - **Two digits:** If `s[i-2..i-1]` forms a number between 10 and 26, add `dp[i-2]` (decode last two digits together)
4. **Space optimization:** Since we only need the previous two values, we use variables instead of an array

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `"12"` | `2` | "AB" (1,2) or "L" (12) |
| `"226"` | `3` | "BZ" (2,26), "VF" (22,6), or "BBF" (2,2,6) |
| `"0"` | `0` | Invalid - no mapping for 0 |
| `"10"` | `1` | Only "J" (10) - single digit '0' can't be decoded alone |
| `"27"` | `1` | Only "BG" (2,7) - 27 > 26, so can't be decoded as a pair |
| `"11106"` | `2` | "AAJF" (1,1,10,6) or "KJF" (11,10,6) |
| `""` | `0` | Empty string - edge case |
| `"1"` | `1` | Only "A" |
| `"101"` | `1` | "JA" (10, 1) |
