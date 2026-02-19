# Count Vowels

## Problem
Write a function that counts the number of vowels (a, e, i, o, u) in a given string. The function should be case-insensitive, meaning both uppercase and lowercase vowels should be counted.

## Function Signature
- **Input:** `text str` - The string to count vowels in
- **Output:** `int` - The count of vowels (a, e, i, o, u) in the string, case-insensitive

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `"hello"` | `2` (e, o) |
| `"HELLO"` | `2` (E, O) |
| `"The quick brown fox"` | `5` (e, u, i, o, o) |
| `""` | `0` (empty string) |
| `"xyz"` | `0` (no vowels) |
| `"AEIOUaeiou"` | `10` (all vowels, mixed case) |
| `"Programming is fun!"` | `5` (o, a, i, i, u) |

## Notes
- Only the letters a, e, i, o, u (case-insensitive) are considered vowels
- All other characters (consonants, numbers, symbols, spaces) are ignored
- An empty string should return 0
