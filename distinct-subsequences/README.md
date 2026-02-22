# Distinct Subsequences

## Problem

Given two strings `s` and `t`, return the number of distinct subsequences of `s` which equals `t`.

A subsequence of a string is a new string formed from the original string by deleting some (can be none) of the characters without disturbing the relative positions of the remaining characters.

For example, `"ACE"` is a subsequence of `"ABCDE"` while `"AEC"` is not.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/distinct_subsequences.xs`):** Contains the dynamic programming solution logic

## Function Signature

- **Input:**
  - `s` (text): The source string to search within
  - `t` (text): The target string to find as a subsequence
- **Output:**
  - (int): The number of distinct ways `t` appears as a subsequence of `s`

## Algorithm

This solution uses **dynamic programming with space optimization**:

1. **DP State:** `dp[j]` represents the number of ways to form the first `j` characters of `t` from the processed characters of `s`

2. **Recurrence:**
   - If `s[i] == t[j-1]`: `dp[j] = dp[j] + dp[j-1]` (either skip current s char or use it)
   - If `s[i] != t[j-1]`: `dp[j]` remains unchanged (must skip current s char)

3. **Space Optimization:** Instead of a 2D array, we use a 1D array and iterate backwards through `t` to avoid overwriting values we still need

4. **Base Case:** `dp[0] = 1` (one way to form empty string: delete all characters)

## Test Cases

| s | t | Expected Output | Explanation |
|---|---|-----------------|-------------|
| `"rabbbit"` | `"rabbit"` | `3` | Delete one of the three 'b's |
| `"abc"` | `"abc"` | `1` | Exact match, only one way |
| `"abc"` | `"def"` | `0` | No matching characters |
| `""` | `""` | `1` | Empty string is subsequence of empty string |
| `"aaaaa"` | `"aa"` | `10` | C(5,2) = 10 ways to choose 2 a's from 5 |

## Complexity Analysis

- **Time Complexity:** O(n × m) where n = len(s), m = len(t)
- **Space Complexity:** O(m) for the 1D DP array
