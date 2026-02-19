# Palindrome Check

## Problem

Write a function that checks if a given string is a **palindrome** — a word, phrase, number, or other sequence of characters that reads the same forward and backward (ignoring case).

### Examples:
- `"racecar"` → `true` (reads the same both ways)
- `"hello"` → `false` (not a palindrome)
- `"A man a plan a canal Panama"` → `true` (when spaces are normalized)
- `""` (empty string) → `true` (empty is considered a palindrome)

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/palindrome_check.xs`):** Contains the solution logic

## Function Signature

- **Input:**
  - `str` (optional text): The string to check for palindrome property
- **Output:**
  - `bool`: `true` if the string is a palindrome, `false` otherwise
  - Empty or null input returns `true` (edge case handling)

## Algorithm

The solution uses XanoScript's string filters to check for palindromes:

1. **Normalize** the string by converting to lowercase using `|to_lower`
2. **Split** the string into an array of characters using `|split:""`
3. **Reverse** the array using `|reverse`
4. **Join** the array back into a string using `|join:""`
5. **Compare** the normalized string with its reversed version
6. **Return** `true` if they match, `false` otherwise

## Test Cases

| Input | Expected Output | Notes |
|-------|-----------------|-------|
| `"racecar"` | `true` | Classic palindrome |
| `"madam"` | `true` | Another palindrome |
| `"hello"` | `false` | Not a palindrome |
| `"a"` | `true` | Single character is a palindrome |
| `""` (empty string) | `true` | Edge case: empty is palindrome |
| `null` | `true` | Edge case: null treated as palindrome |
| `"Racecar"` | `true` | Case-insensitive check |
| `"Aba"` | `true` | Mixed case palindrome |
| `"12321"` | `true` | Numeric palindrome |
| `"12345"` | `false` | Not a palindrome |

## How It Works

The function leverages XanoScript's powerful filter chaining:

```xs
$cleaned|split:""|reverse|join:""
```

This single expression:
1. Takes the lowercase string
2. Splits it into individual characters (`["r","a","c","e","c","a","r"]`)
3. Reverses the array (`["r","a","c","e","c","a","r"]`)
4. Joins back into a string (`"racecar"`)

Then a simple equality check determines if it's a palindrome.
