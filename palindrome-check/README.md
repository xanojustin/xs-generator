# Palindrome Check

## Problem
Determine whether a given string is a palindrome. A palindrome is a word, phrase, number, or other sequence of characters that reads the same forward and backward (ignoring spaces, punctuation, and capitalization).

Examples of palindromes:
- "radar"
- "A man a plan a canal Panama"
- "Was it a car or a cat I saw"
- "racecar"

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/palindrome_check.xs`):** Contains the solution logic

## Function Signature
- **Input:** 
  - `input_string` (text): The string to check for palindrome properties
- **Output:** 
  - (bool): `true` if the string is a palindrome, `false` otherwise

## Algorithm
1. Normalize the input string by:
   - Converting to lowercase
   - Removing all non-alphanumeric characters (spaces, punctuation, etc.)
2. Reverse the normalized string
3. Compare the normalized string with its reverse
4. Return `true` if they match, `false` otherwise

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `"radar"` | `true` |
| `"hello"` | `false` |
| `"A man a plan a canal Panama"` | `true` |
| `""` | `true` (empty string edge case) |
| `"a"` | `true` (single character) |
| `"Was it a car or a cat I saw"` | `true` |
| `"12321"` | `true` (numeric palindrome) |
| `"12345"` | `false` |
