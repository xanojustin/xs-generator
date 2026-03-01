# Isogram Check

## Problem
An isogram is a word or phrase without a repeating letter. Write a function that checks if a given word or phrase is an isogram.

Examples:
- "lumberjacks" → true (no repeating letters)
- "subdermatoglyphic" → true (longest English isogram)
- "hello" → false ('l' appears twice)
- "Alphabet" → false ('a' appears twice, case-insensitive)

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/is_isogram.xs`):** Contains the solution logic

## Function Signature
- **Input:** 
  - `text` (text): The word or phrase to check
- **Output:** 
  - (bool): `true` if the text is an isogram (no repeating letters), `false` otherwise

## Algorithm
1. Convert the input text to lowercase for case-insensitive comparison
2. Remove all non-alphabetic characters using regex
3. Split the remaining letters into an array of characters
4. Use the `unique` filter to get unique characters
5. Compare the count of all letters vs unique letters
6. Return `true` if counts are equal (no duplicates), `false` otherwise

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `"subdermatoglyphic"` | `true` (longest English isogram) |
| `"lumberjacks"` | `true` (common isogram) |
| `"hello"` | `false` ('l' appears twice) |
| `"Alphabet"` | `false` ('a' appears twice, case-insensitive) |
| `""` | `true` (empty string has no duplicates) |
| `"a"` | `true` (single letter is an isogram) |
| `"aa"` | `false` (duplicate letter) |
| `"thumbscrew-japingly"` | `true` (isogram with hyphen) |

## XanoScript Features Used
- `to_lower` filter for case normalization
- `regex_replace` filter for character filtering
- `split` filter to convert string to character array
- `unique` filter to remove duplicate characters
- `count` filter to count array elements
