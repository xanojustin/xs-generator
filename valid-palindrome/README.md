# Valid Palindrome

## Problem

A phrase is a **palindrome** if, after converting all uppercase letters into lowercase letters and removing all non-alphanumeric characters, it reads the same forward and backward.

Given a string `text`, return `true` if it is a **palindrome**, or `false` otherwise.

### Examples
- `"A man, a plan, a canal: Panama"` → `true`
- `"race a car"` → `false`
- `" "` → `true` (empty string after cleaning is considered a palindrome)

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/valid_palindrome.xs`):** Contains the solution logic

## Function Signature

- **Input:** 
  - `text` (text): The string to check for palindrome property
- **Output:** 
  - Returns `bool`: `true` if the string is a valid palindrome, `false` otherwise

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `"A man, a plan, a canal: Panama"` | `true` | After cleaning: `"amanaplanacanalpanama"` which is a palindrome |
| `"race a car"` | `false` | After cleaning: `"raceacar"` which is NOT a palindrome |
| `" "` | `true` | Empty string after cleaning is a palindrome |
| `"a"` | `true` | Single character is always a palindrome |
| `"0P"` | `false` | After cleaning: `"0p"` which is NOT a palindrome |
| `"Was it a car or a cat I saw?"` | `true` | After cleaning: `"wasitacaroracatisaw"` which is a palindrome |

## Algorithm

1. Convert the input string to lowercase
2. Remove all non-alphanumeric characters (keep only a-z, 0-9)
3. Reverse the cleaned string
4. Compare the cleaned string with its reverse
5. Return `true` if they match, `false` otherwise
