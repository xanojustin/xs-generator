# Shortest Common Supersequence

## Problem

Given two strings `str1` and `str2`, return the **shortest string** that has both `str1` and `str2` as **subsequences**. If there are multiple valid strings of the same length, return any of them.

A string `s` is a subsequence of string `t` if deleting some number of characters from `t` (possibly 0) results in the string `s`.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test input (str1="abac", str2="cab")
- **Function (`function/shortest-common-supersequence.xs`):** Contains the dynamic programming solution

## Function Signature

- **Input:**
  - `str1` (text): First input string
  - `str2` (text): Second input string
- **Output:** (text) The shortest common supersequence string

## Algorithm

The solution uses **Dynamic Programming** based on the Longest Common Subsequence (LCS):

1. **Build LCS DP Table:** Create a 2D table where `dp[i][j]` represents the length of the LCS of `str1[0..i-1]` and `str2[0..j-1]`

2. **Fill DP Table:**
   - If characters match: `dp[i][j] = dp[i-1][j-1] + 1`
   - If characters don't match: `dp[i][j] = max(dp[i-1][j], dp[i][j-1])`

3. **Backtrack to Build Result:** Starting from the bottom-right of the DP table:
   - If characters match: add the character to result, move diagonally up-left
   - If `dp[i-1][j] > dp[i][j-1]`: add `str1[i-1]`, move up
   - Otherwise: add `str2[j-1]`, move left
   - When one string is exhausted, append remaining characters from the other

**Time Complexity:** O(m × n) where m and n are the lengths of the strings  
**Space Complexity:** O(m × n) for the DP table

## Test Cases

| Input | Expected Output | Notes |
|-------|-----------------|-------|
| str1="abac", str2="cab" | "cabac" or "abacb" | Classic case with overlapping subsequences |
| str1="abc", str2="def" | "abcdef" | No common characters, result is concatenation |
| str1="abc", str2="ac" | "abc" | One string is subsequence of the other |
| str1="", str2="abc" | "abc" | Empty string edge case |
| str1="abc", str2="abc" | "abc" | Identical strings |

### Verification

For any result to be correct:
- `str1` must be a subsequence of the result
- `str2` must be a subsequence of the result
- The length should be `len(str1) + len(str2) - len(LCS)`