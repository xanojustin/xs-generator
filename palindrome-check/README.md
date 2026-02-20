# Palindrome Check

## Problem
Determine if a given string is a palindrome. A palindrome is a word, phrase, number, or other sequence of characters that reads the same forward and backward (ignoring spaces, punctuation, and capitalization).

Examples of palindromes:
- "racecar"
- "A man a plan a canal Panama"
- "Was it a car or a cat I saw"
- "No lemon, no melon"

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/is_palindrome.xs`):** Contains the solution logic

## Function Signature
- **Input:** 
  - `text` (text, required): The string to check for palindrome properties
- **Output:** 
  - Returns `true` if the string is a palindrome, `false` otherwise (boolean)

## Algorithm
1. Convert the input string to lowercase for case-insensitive comparison
2. Remove all non-alphanumeric characters using regex
3. Split the cleaned string into an array of characters
4. Reverse the array
5. Join the reversed array back into a string
6. Compare the cleaned string with its reversed version
7. Return `true` if they match, `false` otherwise

## Test Cases

| Input | Expected Output | Notes |
|-------|-----------------|-------|
| `"racecar"` | `true` | Classic palindrome |
| `"A man a plan a canal Panama"` | `true` | Palindrome with spaces |
| `"hello"` | `false` | Not a palindrome |
| `""` | `true` | Empty string edge case |
| `"a"` | `true` | Single character edge case |
| `"Was it a car or a cat I saw"` | `true` | Complex palindrome with mixed case |
| `"No lemon, no melon"` | `true` | Palindrome with punctuation |
| `"12321"` | `true` | Numeric palindrome |
| `"12345"` | `false` | Non-palindrome numbers |