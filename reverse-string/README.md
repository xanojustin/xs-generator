# Reverse String

## Problem

Write a function that reverses a string. The input string is given as an array of characters `str`.

This is a classic coding interview question that tests basic string manipulation skills.

## Function Signature

- **Input:** `str` (text) - The string to reverse
- **Output:** `text` - The reversed string

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `"hello"` | `"olleh"` |
| `"world"` | `"dlrow"` |
| `""` | `""` |
| `"a"` | `"a"` |
| `"racecar"` | `"racecar"` |
| `"OpenAI"` | `"IAnepO"` |
| `"12345"` | `"54321"` |

### Edge Cases Explained

1. **Empty string `""`**: Should return empty string - tests boundary condition
2. **Single character `"a"`**: Should return the same character - tests minimum valid input
3. **Palindrome `"racecar"`**: Reversed string equals original - tests that algorithm works both ways
4. **Mixed case `"OpenAI"`**: Should preserve case positions - tests character-level reversal
5. **Numbers as string `"12345"`**: Should work with numeric characters too
