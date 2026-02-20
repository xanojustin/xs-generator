# Longest Common Subsequence (LCS)

## Problem

Given two strings, find the length of the **longest common subsequence** (LCS).

A **subsequence** is a sequence that appears in the same relative order, but not necessarily contiguous. For example:
- "ace" is a subsequence of "abcde" (a → c → e)
- "abc" is a subsequence of "abc" (all characters)
- "MJAU" is a subsequence of "XMJYAUZ" (M → J → A → U)

### Example
- Input: `str1 = "abcde"`, `str2 = "ace"`
- Output: `3`
- Explanation: The longest common subsequence is "ace" with length 3.

## Structure

- **Run Job (`run.xs`):** Calls the test function `lcs_tests` which runs multiple test cases
- **Function (`function/lcs.xs`):** Contains the dynamic programming solution for LCS
- **Test Function (`function/lcs_tests.xs`):** Runs test cases and validates the LCS function

## Function Signature

- **Input:**
  - `str1` (text): First string
  - `str2` (text): Second string
- **Output:**
  - (int): The length of the longest common subsequence

## Algorithm

This solution uses **dynamic programming** with a 2D matrix:

1. Create a DP table where `dp[i][j]` represents the length of LCS of `str1[0..i-1]` and `str2[0..j-1]`
2. If characters match (`str1[i-1] == str2[j-1]`):
   - `dp[i][j] = dp[i-1][j-1] + 1` (extend the subsequence)
3. If characters don't match:
   - `dp[i][j] = max(dp[i-1][j], dp[i][j-1])` (take the best of excluding either character)
4. The answer is in `dp[len1][len2]`

**Time Complexity:** O(m × n) where m and n are the lengths of the strings  
**Space Complexity:** O(m × n) for the DP matrix

## Test Cases

| str1 | str2 | Expected Output | Description |
|------|------|-----------------|-------------|
| `""` | `""` | `0` | Both strings empty (edge case) |
| `""` | `"abc"` | `0` | One string empty (edge case) |
| `"abcde"` | `"ace"` | `3` | Basic case - "ace" |
| `"abc"` | `"abc"` | `3` | Identical strings |
| `"abc"` | `"def"` | `0` | No common characters |
| `"XMJYAUZ"` | `"MZJAWXU"` | `4` | Longer strings - "MJAU" |
| `"abcdef"` | `"def"` | `3` | Subsequence at end |

## Notes

- This is a classic dynamic programming problem often used in interviews
- Similar problems include: Edit Distance (Levenshtein), Longest Palindromic Subsequence, Shortest Common Supersequence
- The DP approach is optimal for this problem
