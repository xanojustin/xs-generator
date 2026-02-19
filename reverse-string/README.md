# Reverse String

## Problem

Write a function that reverses a given string. For example:
- Input: `"Hello, World!"` → Output: `"!dlroW ,olleH"`
- Input: `"abc"` → Output: `"cba"`

The function should handle edge cases such as empty strings and null inputs gracefully.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/reverse_string.xs`):** Contains the solution logic

## Function Signature

- **Input:** 
  - `str` (optional text): The string to reverse
- **Output:** 
  - `text`: The reversed string, or empty string if input is null/empty

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `"Hello, World!"` | `"!dlroW ,olleH"` |
| `"abc"` | `"cba"` |
| `""` (empty string) | `""` |
| `null` | `""` |
| `"a"` (single character) | `"a"` |
| `"12345"` | `"54321"` |

## How It Works

The solution uses XanoScript's array filters to reverse the string:

1. **Split** the string into an array of characters using `|split:""`
2. **Reverse** the array using `|reverse`
3. **Join** the array back into a string using `|join:""`

For empty or null inputs, the function returns early with an empty string.
