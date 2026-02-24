# Is Subsequence

## Problem
Given two strings `s` and `t`, return `true` if `s` is a **subsequence** of `t`, or `false` otherwise.

A **subsequence** of a string is a new string that is formed from the original string by deleting some (can be none) of the characters without disturbing the relative positions of the remaining characters.

For example:
- `"ace"` is a subsequence of `"abcde"` (delete 'b' and 'd')
- `"aec"` is **not** a subsequence of `"abcde"` ('a' and 'e' are in wrong relative order)

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/is_subsequence.xs`):** Contains the solution logic using two-pointer technique

## Function Signature
- **Input:**
  - `s` (text): The potential subsequence string
  - `t` (text): The target string to check against
- **Output:** (boolean): `true` if `s` is a subsequence of `t`, `false` otherwise

## Algorithm
This solution uses the **two-pointer technique**:
1. Initialize a pointer for string `s` at index 0
2. Iterate through string `t` with another pointer
3. When characters match, advance the `s` pointer
4. Always advance the `t` pointer
5. If the `s` pointer reaches the end of `s`, all characters were found in order

**Time Complexity:** O(n) where n is the length of `t`  
**Space Complexity:** O(1) - only using two index variables

## Test Cases

| s | t | Expected Output | Explanation |
|---|---|-----------------|-------------|
| `"abc"` | `"ahbgdc"` | `true` | 'a' → 'h' → 'b' → 'g' → 'd' → 'c' - all chars found in order |
| `"axc"` | `"ahbgdc"` | `false` | 'x' not found in t |
| `""` | `"ahbgdc"` | `true` | Empty string is subsequence of any string |
| `"abc"` | `""` | `false` | Non-empty string can't be subsequence of empty string |
| `"ace"` | `"abcde"` | `true` | Classic subsequence example |
| `"aec"` | `"abcde"` | `false` | Wrong order - 'e' appears before 'c' can match |
