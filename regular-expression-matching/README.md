# Regular Expression Matching

## Problem
Given an input string `s` and a pattern `p`, implement regular expression matching with support for `.` and `*` where:

- `.` Matches any single character
- `*` Matches zero or more of the preceding element

The matching should cover the **entire** input string (not partial).

### Examples
- `s = "aa"`, `p = "a"` → `false` ("a" does not match the entire string "aa")
- `s = "aa"`, `p = "a*"` → `true` ("*" means zero or more of the preceding element, "a")
- `s = "ab"`, `p = ".*"` → `true` (".*" means zero or more of any character)
- `s = "aab"`, `p = "c*a*b"` → `true` ("c*" matches 0 c's, "a*" matches 2 a's, "b" matches b)

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/regular-expression-matching.xs`):** Contains the dynamic programming solution

## Function Signature
- **Input:**
  - `s` (text): The input string to match
  - `p` (text): The pattern containing letters, `.`, and `*`
- **Output:** (bool) `true` if the string matches the pattern, `false` otherwise

## Algorithm
This solution uses **Dynamic Programming** with a 2D DP table:
- `dp[i][j]` represents whether `s[0..i-1]` matches `p[0..j-1]`
- Base case: `dp[0][0] = true` (empty string matches empty pattern)
- For `*` in the pattern:
  - Zero occurrences: ignore `*` and its preceding character
  - One or more: use the match if the preceding character matches the current string character
- For `.` or matching characters: carry forward the diagonal value

### Complexity
- **Time:** O(m × n) where m = length of s, n = length of p
- **Space:** O(m × n) for the DP table

## Test Cases

| Input s | Input p | Expected Output |
|---------|---------|-----------------|
| `"aa"` | `"a"` | `false` |
| `"aa"` | `"a*"` | `true` |
| `"ab"` | `".*"` | `true` |
| `"aab"` | `"c*a*b"` | `true` |
| `"mississippi"` | `"mis*is*p*."` | `false` |
| `""` | `""` | `true` (edge case: empty strings) |
| `"a"` | `".*.."` | `true` (boundary: multiple dots with star) |
| `"aaa"` | `"a*a"` | `true` (multiple matches) |
| `"ab"` | `"c*ab"` | `true` (star with zero occurrences) |
| `"abc"` | `"abc"` | `true` (exact match) |
