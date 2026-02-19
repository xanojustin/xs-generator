# Reverse String

## Problem
Write a function that reverses a string. The input string is given as an array of characters (or in XanoScript, as a text input).

**Constraints:**
- The input string will contain printable ASCII characters
- The solution must reverse the string in-place or return a new reversed string

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/reverse_string.xs`):** Contains the solution logic

## Function Signature
- **Input:** `text input_string` - The string to be reversed
- **Output:** `text` - The reversed string

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `"hello"` | `"olleh"` |
| `"world"` | `"dlrow"` |
| `""` (empty string) | `""` |
| `"a"` (single character) | `"a"` |
| `"racecar"` (palindrome) | `"racecar"` |
| `"12345"` | `"54321"` |

### Edge Cases
- **Empty string:** Should return empty string
- **Single character:** Should return the same character
- **Palindrome:** Should return the same string (symmetry check)
