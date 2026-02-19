# Palindrome Check

## Problem

Determine if a given string is a palindrome. A palindrome is a string that reads the same forwards and backwards, ignoring case, spaces, and non-alphanumeric characters.

For example:
- "racecar" is a palindrome
- "A man a plan a canal Panama" is a palindrome (ignoring spaces and case)
- "hello" is not a palindrome

This exercise tests string manipulation skills including normalization, filtering, and comparison.

## Function Signature

- **Input:** `text` (text) - The string to check (max 1000 characters)
- **Output:** `bool` - `true` if the string is a palindrome, `false` otherwise

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `"racecar"` | `true` |
| `"hello"` | `false` |
| `"A man a plan a canal Panama"` | `true` |
| `"Was it a car or a cat I saw"` | `true` |
| `""` | `true` (empty string is a palindrome) |
| `"a"` | `true` (single character is a palindrome) |
| `"12321"` | `true` (numbers work too) |
| `"12345"` | `false` |
| `"No 'x' in Nixon"` | `true` |

### Edge Cases Explained

1. **Empty string `""`**: An empty string reads the same forwards and backwards, so it should return `true`
2. **Single character `"a"`**: A single character is always a palindrome
3. **Mixed case with punctuation**: The function should normalize by converting to lowercase and removing non-alphanumeric characters
4. **Numbers only**: Palindrome checking works with digits as well
