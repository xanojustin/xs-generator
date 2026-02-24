# Pangram Check

## Problem
A pangram is a sentence that contains every letter of the English alphabet at least once. The most famous pangram is "The quick brown fox jumps over the lazy dog."

Write a function that checks if a given sentence is a pangram.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/isPangram.xs`):** Contains the solution logic

## Function Signature
- **Input:** 
  - `text` (text): The sentence to check for pangram status
- **Output:** 
  - (boolean): `true` if the sentence is a pangram (contains all 26 letters), `false` otherwise

## Algorithm
1. Convert the input text to lowercase for case-insensitive comparison
2. Remove all non-alphabetic characters using regex
3. Split the remaining letters into an array of characters
4. Use the `unique` filter to remove duplicate letters
5. Count the unique letters
6. Return `true` if count equals 26 (all letters present), `false` otherwise

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `"The quick brown fox jumps over the lazy dog"` | `true` (classic pangram) |
| `"Pack my box with five dozen liquor jugs"` | `true` (another perfect pangram) |
| `"Hello World"` | `false` (only contains 7 unique letters: h, e, l, o, w, r, d) |
| `""` | `false` (empty string has no letters) |
| `"abcdefghijklmnopqrstuvwxyz"` | `true` (all letters, no spaces) |
| `"ABCDEFGHIJKLMNOPQRSTUVWXYZ"` | `true` (uppercase works too) |

## XanoScript Features Used
- `to_lower` filter for case normalization
- `regex_replace` filter for character filtering
- `split` filter to convert string to character array
- `unique` filter to remove duplicate characters
- `count` filter to count array elements
