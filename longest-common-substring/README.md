# Longest Common Substring

## Problem
Given two strings, find the **length** of the longest common substring. A substring is a contiguous sequence of characters within a string.

For example:
- `"abc"` and `"abc"` have LCS length 3 (the entire string)
- `"abcde"` and `"abfde"` have LCS length 2 (`"ab"`)
- `"GeeksforGeeks"` and `"GeeksQuiz"` have LCS length 5 (`"Geeks"`)

Note: This is different from the **Longest Common Subsequence** problem, where characters don't need to be consecutive.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/longest_common_substring.xs`):** Contains the solution logic using dynamic programming

## Function Signature
- **Input:**
  - `str1` (text): First input string
  - `str2` (text): Second input string
- **Output:** 
  - (int): Length of the longest common substring

## Algorithm
This solution uses dynamic programming with space optimization:
- `dp[i][j]` represents the length of the longest common substring ending at `str1[i-1]` and `str2[j-1]`
- If characters match: `dp[i][j] = dp[i-1][j-1] + 1`
- If characters don't match: `dp[i][j] = 0`
- Only store the previous row to reduce space from O(m×n) to O(n)

## Test Cases

| Input str1 | Input str2 | Expected Output | Explanation |
|------------|------------|-----------------|-------------|
| `"abcde"` | `"abfde"` | 2 | `"ab"` is the longest common substring |
| `"GeeksforGeeks"` | `"GeeksQuiz"` | 5 | `"Geeks"` is the longest common substring |
| `""` | `"anything"` | 0 | Empty string has no common substring |
| `"xyz"` | `"abc"` | 0 | No common characters |
| `"aaaa"` | `"aa"` | 2 | `"aa"` is the longest common substring |
| `"abcdef"` | `"zbcdef"` | 5 | `"bcdef"` is the longest common substring |

## Complexity
- **Time Complexity:** O(m × n) where m and n are the lengths of the two strings
- **Space Complexity:** O(n) using the optimized approach with only two rows
