# Wildcard Matching

## Problem

Implement wildcard pattern matching with support for `'?'` and `'*'`.

- `'?'` Matches any single character.
- `'*'` Matches any sequence of characters (including the empty sequence).

The matching should cover the **entire** input string (not partial).

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/wildcard_match.xs`):** Contains the dynamic programming solution

## Function Signature

- **Input:**
  - `s` (text): The input string to match
  - `p` (text): The pattern containing `?` and `*` wildcards
- **Output:** (bool) `true` if the pattern matches the entire string, `false` otherwise

## Test Cases

| s | p | Expected Output | Description |
|---|---|-----------------|-------------|
| `"aa"` | `"a"` | `false` | Basic mismatch |
| `"aa"` | `"*"` | `true` | Star matches any sequence |
| `"cb"` | `"?a"` | `false` | Question mark doesn't match |
| `"adceb"` | `"*a*b"` | `true` | Star matches complex patterns |
| `"acdcb"` | `"a*c?b"` | `false` | Complex mismatch |
| `""` | `""` | `true` | Edge case: empty strings |
| `""` | `"*"` | `true` | Star matches empty string |
| `"abc"` | `"abc"` | `true` | Exact match, no wildcards |
| `"abcdef"` | `"a*f"` | `true` | Star matches middle sequence |
| `"abcd"` | `"??"` | `false` | Not enough question marks |

## Algorithm

This solution uses **dynamic programming** with a 1D array for space optimization:

- `dp[j]` represents whether `s[0..i-1]` matches `p[0..j-1]`
- For each character in `s`, we update the dp array based on:
  - `*` can match empty sequence (look at `dp[j+1]`) or consume current char (look at `new_dp[j]`)
  - `?` matches any single char if previous chars matched
  - Regular chars must match exactly if previous chars matched

Time Complexity: O(m × n) where m = len(s), n = len(p)  
Space Complexity: O(n) using the optimized 1D approach
