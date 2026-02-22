# KMP String Search

## Problem
Implement the Knuth-Morris-Pratt (KMP) algorithm for efficient string pattern matching. Given a text string and a pattern string, find all starting positions where the pattern occurs in the text.

The KMP algorithm improves upon naive string searching by avoiding unnecessary character comparisons. When a mismatch occurs, it uses information about the pattern's structure (precomputed in a "failure function" or "LPS array") to skip ahead intelligently rather than restarting from the next character.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/kmp_search.xs`):** Contains the KMP algorithm implementation

## Function Signature
- **Input:** 
  - `text` (text): The string to search within
  - `pattern` (text): The substring pattern to search for
- **Output:** 
  - Returns an array of integers (`int[]`) containing all starting indices (0-based) where the pattern is found in the text. Returns an empty array if no matches are found.

## Algorithm Overview

### 1. LPS Array (Longest Proper Prefix which is also Suffix)
For the pattern "ABABC":
- LPS[0] = 0 (single char has no proper prefix)
- LPS[1] = 0 ("AB" - no proper prefix that is also suffix)
- LPS[2] = 1 ("ABA" - "A" is both prefix and suffix)
- LPS[3] = 2 ("ABAB" - "AB" is both prefix and suffix)
- LPS[4] = 0 ("ABABC" - no match)

### 2. Pattern Matching
Using the LPS array, when a mismatch occurs at position `j` in the pattern, instead of resetting `j` to 0, we set `j = LPS[j-1]` and continue comparing.

## Test Cases

| Input Text | Pattern | Expected Output |
|------------|---------|-----------------|
| "ABABDABACDABABCABAB" | "ABABCABAB" | [10] |
| "AAAAABAAABA" | "AAAA" | [0, 1] |
| "hello world" | "world" | [6] |
| "abcdef" | "xyz" | [] |
| "" | "abc" | [] |
| "abc" | "" | [] |
| "mississippi" | "issip" | [4] |
| "aaaaaaaa" | "aaa" | [0, 1, 2, 3, 4, 5] |

### Case Descriptions
- **Basic match:** Pattern found once in the middle of text
- **Multiple overlaps:** Pattern "AAAA" appears overlapping at positions 0 and 1
- **Simple word match:** Pattern at end of text
- **No match:** Pattern not found, returns empty array
- **Empty text:** Edge case - empty text cannot contain any pattern
- **Empty pattern:** Edge case - empty pattern technically matches at every position
- **Single match:** Pattern appears once
- **Many overlapping matches:** All possible positions with heavy overlap
