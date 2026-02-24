# Remove Vowels from a String

## Problem

Write a function that takes a string as input and returns a new string with all vowels removed.

Vowels are: **a, e, i, o, u** (both uppercase and lowercase).

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/remove_vowels.xs`):** Contains the solution logic

## Function Signature

- **Input:** `input_string` (text) — The string from which to remove vowels
- **Output:** (text) — The input string with all vowels removed

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `"Hello World"` | `"Hll Wrld"` |
| `"AEIOUaeiou"` | `""` (empty string) |
| `"xyz"` | `"xyz"` |
| `""` | `""` (empty string) |
| `"Rhythm"` | `"Rhythm"` |
| `"Python Programming"` | `"Pythn Prgrmmng"` |

## Approach

The solution:
1. Splits the input string into an array of individual characters
2. Iterates through each character
3. Checks if the character is a vowel (both uppercase and lowercase)
4. Builds a new array containing only non-vowel characters
5. Joins the result array back into a string
