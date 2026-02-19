# Count Vowels

## Problem
Write a function that counts the number of vowels (a, e, i, o, u) in a given string. The function should be case-insensitive (treat uppercase and lowercase vowels the same).

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test input "Hello World"
- **Function (`function/count-vowels.xs`):** Contains the solution logic that iterates through each character and counts vowels

## Function Signature
- **Input:** 
  - `text` (text, required): The input string to count vowels in
  - Applied `lower` filter to make the comparison case-insensitive
- **Output:** 
  - `text` (text): The processed (lowercased) input string
  - `vowel_count` (int): The total number of vowels found

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `"Hello World"` | `{ "text": "hello world", "vowel_count": 3 }` |
| `"AeIoU"` | `{ "text": "aeiou", "vowel_count": 5 }` |
| `""` (empty string) | `{ "text": "", "vowel_count": 0 }` |
| `"Rhythm Myths"` | `{ "text": "rhythm myths", "vowel_count": 0 }` |
| `"The quick brown fox jumps over the lazy dog"` | `{ "text": "the quick brown fox jumps over the lazy dog", "vowel_count": 11 }` |

## Implementation Notes
- Uses a `while` loop to iterate through each character in the string
- Uses `substr` filter to extract individual characters
- Uses lowercase comparison to handle case-insensitivity
- Returns both the processed text and the vowel count for verification
