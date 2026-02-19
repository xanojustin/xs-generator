# Palindrome Check

## Problem
Determine whether a given string is a **palindrome** — a word, phrase, number, or other sequence of characters that reads the same forward and backward (ignoring spaces, punctuation, and capitalization).

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/check_palindrome.xs`):** Contains the solution logic

## Function Signature
- **Input:** 
  - `text` (text, required): The string to check for palindrome properties
- **Output:** An object containing:
  - `input`: The original input text
  - `cleaned`: The normalized text (lowercase, no non-alphanumeric characters)
  - `is_palindrome` (bool): `true` if the text is a palindrome, `false` otherwise
  - `length` (int): The length of the cleaned text

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `"A man a plan a canal Panama"` | `is_palindrome: true` (classic palindrome phrase) |
| `"racecar"` | `is_palindrome: true` (single word palindrome) |
| `"hello"` | `is_palindrome: false` (not a palindrome) |
| `""` | `is_palindrome: true` (empty string edge case) |
| `"a"` | `is_palindrome: true` (single character edge case) |
| `"Was it a car or a cat I saw?"` | `is_palindrome: true` (punctuation-heavy palindrome) |
| `"12321"` | `is_palindrome: true` (numeric palindrome) |
| `"12345"` | `is_palindrome: false` (non-palindrome numbers) |

## Key Features
- Case-insensitive comparison ("Racecar" = "racecaR")
- Ignores spaces and punctuation
- Handles edge cases (empty strings, single characters)
- Works with alphanumeric characters only
