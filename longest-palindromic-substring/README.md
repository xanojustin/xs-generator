# Longest Palindromic Substring

## Problem
Given a string `s`, return the longest palindromic substring in `s`.

A palindrome is a string that reads the same forwards and backwards.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test input
- **Function (`function/longest_palindromic_substring.xs`):** Contains the solution logic

## Function Signature
- **Input:**
  - `s` (text): The input string to search for palindromes
- **Output:**
  - (text): The longest palindromic substring found in `s`

## Algorithm
This solution uses the "expand around center" approach:
1. For each character in the string, treat it as the center of a potential palindrome
2. Expand outward while the characters on both sides match
3. Also check for even-length palindromes (center between two characters)
4. Track the longest palindrome found

**Time Complexity:** O(n²) where n is the length of the string  
**Space Complexity:** O(1) - only using a few variables

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `"babad"` | `"bab"` or `"aba"` | Both are valid longest palindromes of length 3 |
| `"cbbd"` | `"bb"` | The longest palindrome is the two consecutive 'b's |
| `"a"` | `"a"` | Single character is always a palindrome |
| `""` | `""` | Empty string returns empty string |
| `"racecar"` | `"racecar"` | The entire string is a palindrome |
| `"bananas"` | `"anana"` | The middle 5 characters form a palindrome |

## Example Walkthrough

For input `"babad"`:
- Position 0 ('b'): expands to "b" (length 1)
- Position 1 ('a'): expands to "bab" (length 3)
- Position 2 ('b'): expands to "aba" (length 3)
- Position 3 ('a'): expands to "a" (length 1)
- Position 4 ('d'): expands to "d" (length 1)

Longest found: "bab" or "aba" (both length 3)
