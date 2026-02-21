# Longest Substring Without Repeating Characters

## Problem

Given a string `s`, find the length of the **longest substring** without repeating characters.

A substring is a contiguous sequence of characters within a string. For example, "abc" is a substring of "abcd".

This is a classic sliding window problem that demonstrates efficient string traversal.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/longest_substring.xs`):** Contains the sliding window solution logic

## Function Signature

- **Input:** 
  - `text` (text): The input string to analyze
- **Output:** 
  - Returns (int): The length of the longest substring without repeating characters

## Algorithm

The solution uses the **sliding window technique** with two pointers (`left` and `right`):

1. `right` expands the window by moving forward through the string
2. When a duplicate character is found within the current window, `left` moves to exclude the previous occurrence
3. Track character positions in a hash map for O(1) lookups
4. Keep track of the maximum window size seen

**Time Complexity:** O(n) - single pass through the string
**Space Complexity:** O(min(m, n)) - where m is the charset size and n is string length

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `"abcabcbb"` | 3 | "abc" is the longest substring without repeats |
| `"bbbbb"` | 1 | Only "b" can be used (all characters are same) |
| `"pwwkew"` | 3 | "wke" is the longest ("pwke" is a subsequence, not substring) |
| `""` | 0 | Empty string has no substrings |
| `" "` | 1 | Single space character |
| `"au"` | 2 | No repeats, entire string is the answer |
| `"dvdf"` | 3 | "vdf" is the longest substring |
| `"anviaj"` | 5 | "nviaj" is the longest substring |

## Edge Cases

- Empty string → returns 0
- String with all same characters → returns 1
- String with all unique characters → returns length of string
- String with spaces and special characters → handled correctly
