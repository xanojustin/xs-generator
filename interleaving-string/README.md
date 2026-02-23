# Interleaving String

## Problem
Given three strings `s1`, `s2`, and `s3`, determine whether `s3` is formed by an **interleaving** of `s1` and `s2`.

An interleaving of two strings `s` and `t` is a configuration where they are divided into `n` and `m` substrings respectively, such that:
- `s = s₁ + s₂ + ... + sₙ`
- `t = t₁ + t₂ + ... + tₘ`
- The interleaving is `s₁ + t₁ + s₂ + t₂ + s₃ + t₃ + ...` or `t₁ + s₁ + t₂ + s₂ + ...`

In simpler terms: `s3` is an interleaving of `s1` and `s2` if it can be formed by taking characters from `s1` and `s2` while **preserving the relative order** of characters from each string.

### Example
- `s1 = "aabcc"`, `s2 = "dbbca"`, `s3 = "aadbbcbcac"` → **true**
  - Explanation: Take 'a' from s1, 'a' from s1, 'd' from s2, 'b' from s1, 'b' from s2, 'c' from s1, 'b' from s2, 'c' from s1, 'a' from s2, 'c' from s1
  
- `s1 = "aabcc"`, `s2 = "dbbca"`, `s3 = "aadbbbaccc"` → **false**
  - Explanation: The order of characters cannot be preserved

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/is_interleave.xs`):** Contains the dynamic programming solution logic

## Function Signature
- **Input:**
  - `s1` (text): First source string
  - `s2` (text): Second source string  
  - `s3` (text): Target string to check
- **Output:** (bool) `true` if `s3` can be formed by interleaving `s1` and `s2`, `false` otherwise

## Algorithm
This solution uses **Dynamic Programming** with a 2D table `dp[i][j]`:
- `dp[i][j]` = `true` if `s3[0..i+j-1]` can be formed by interleaving `s1[0..i-1]` and `s2[0..j-1]`

**Recurrence:**
- `dp[0][0] = true` (empty strings can form empty string)
- `dp[i][0] = dp[i-1][0] && s1[i-1] == s3[i-1]` (using only s1 characters)
- `dp[0][j] = dp[0][j-1] && s2[j-1] == s3[j-1]` (using only s2 characters)
- `dp[i][j] = (dp[i-1][j] && s1[i-1] == s3[i+j-1]) || (dp[i][j-1] && s2[j-1] == s3[i+j-1])`

**Time Complexity:** O(m × n) where m = len(s1), n = len(s2)  
**Space Complexity:** O(m × n) for the DP table

## Test Cases

| s1 | s2 | s3 | Expected Output |
|----|----|----|-----------------|
| "aabcc" | "dbbca" | "aadbbcbcac" | true |
| "aabcc" | "dbbca" | "aadbbbaccc" | false |
| "" | "" | "" | true |
| "a" | "" | "a" | true |
| "" | "b" | "b" | true |
| "a" | "b" | "ab" | true |
| "a" | "b" | "ba" | true |
| "abc" | "def" | "abcdef" | true |
| "abc" | "def" | "adbecf" | true |
| "abc" | "def" | "acebdf" | false |
