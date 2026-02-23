# Shortest Palindrome

## Problem
Given a string `s`, find the shortest palindrome by adding characters to the front of it.

A palindrome is a string that reads the same forward and backward. The goal is to find the minimum number of characters to prepend to make the string a palindrome.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/shortest_palindrome.xs`):** Contains the solution logic

## Function Signature
- **Input:** 
  - `s` (text): The input string to convert to a palindrome
- **Output:** 
  - (text): The shortest palindrome formed by prepending characters to the input

## Algorithm
1. Find the longest palindromic prefix of the input string
2. Take the remaining suffix (non-palindromic part)
3. Reverse the suffix and prepend it to the original string

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `"aacecaaa"` | `"aaacecaaa"` | The palindromic prefix is `"aacecaa"`, prepend `"aa"` reversed |
| `"abcd"` | `"dcbabcd"` | No palindromic prefix (just `"a"`), prepend `"dcb"` |
| `""` | `""` | Empty string edge case |
| `"a"` | `"a"` | Single character is already a palindrome |
| `"aa"` | `"aa"` | Already a palindrome |
| `"abcba"` | `"abcba"` | Already a palindrome |
| `"racecar"` | `"racecar"` | Already a palindrome |
| `"aacecaaa"` | `"aaacecaaa"` | Classic test case |

## Complexity
- **Time:** O(n²) where n is the length of the string (comparing substrings)
- **Space:** O(n) for storing the reversed string and intermediate results

## Notes
The algorithm works by checking each possible prefix to find the longest one that forms a palindrome when compared with the corresponding suffix of the reversed string. This ensures we add the minimum number of characters to the front.
