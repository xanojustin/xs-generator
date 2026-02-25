# Valid Palindrome II

## Problem
Given a string `s`, determine if it can be a palindrome by deleting at most one character from it.

A palindrome is a string that reads the same forward and backward. You are allowed to remove at most one character to make it a palindrome.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/valid_palindrome_ii.xs`):** Contains the solution logic

## Function Signature
- **Input:** 
  - `s` (text): The input string to check
- **Output:** 
  - (bool): `true` if the string can be a palindrome by deleting at most one character, `false` otherwise

## Algorithm
The solution uses a two-pointer approach:
1. Initialize two pointers at the start (`left = 0`) and end (`right = len - 1`) of the string
2. While `left < right`:
   - If characters match, move both pointers inward
   - If characters don't match:
     - Try skipping the left character and check if the remaining substring is a palindrome
     - Try skipping the right character and check if the remaining substring is a palindrome
     - Return `true` if either option works, `false` otherwise
3. If we reach the middle without more than one mismatch, return `true`

**Time Complexity:** O(n) where n is the length of the string
**Space Complexity:** O(1) - only using a constant amount of extra space

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `"aba"` | `true` | Already a palindrome, no deletion needed |
| `"abca"` | `true` | Delete 'c' to get "aba" which is a palindrome |
| `"abc"` | `false` | Would need to delete at least 2 characters |
| `"a"` | `true` | Single character is always a palindrome |
| `""` | `true` | Empty string is a palindrome |
| `"deeee"` | `true` | Delete first 'd' to get "eeee" |
| `"cbbcc"` | `true` | Delete middle 'b' to get "cbcc"... wait, actually delete nothing - already valid? No, delete last 'c' to get "cbbc" |
| `"aguokepatgbnvbqmgmlcupuufxoo"` | `true` | Delete 'x' to make it palindrome |

## Edge Cases Handled
- Empty string (returns `true`)
- Single character string (returns `true`)
- Already a palindrome (returns `true`)
- Requires exactly one deletion (returns `true`)
- Requires more than one deletion (returns `false`)
