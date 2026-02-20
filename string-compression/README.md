# String Compression

## Problem
Implement a string compression function that uses counts of repeated characters. For example, the string `"aaabbc"` should be compressed to `"a3b2c1"`.

The compression works by iterating through the string and counting consecutive occurrences of each character, then building a new string with each character followed by its count.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/string-compression.xs`):** Contains the solution logic

## Function Signature
- **Input:** `str` (text) - The input string to compress
- **Output:** Compressed string (text) where each character is followed by its consecutive count

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `"aaabbc"` | `"a3b2c1"` |
| `"abcd"` | `"a1b1c1d1"` |
| `""` | `""` |
| `"aabcccccaaa"` | `"a2b1c5a3"` |
| `"x"` | `"x1"` |
| `"wwwwaaadexxxxx"` | `"w4a3d1e1x5"` |

### Edge Cases Covered
- **Empty string:** Returns empty string immediately
- **Single character:** Returns character with count 1
- **All unique characters:** Each character appears with count 1
- **All same characters:** Single character group with full count
