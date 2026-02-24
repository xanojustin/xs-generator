# First Unique Character

## Problem
Given a string `s`, find the first non-repeating character in it and return its index. If it doesn't exist, return `-1`.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/first_unique_char.xs`):** Contains the solution logic

## Function Signature
- **Input:** 
  - `s` (text) - The input string to search
- **Output:** 
  - (int) - The index of the first non-repeating character, or `-1` if no such character exists

## Approach
The solution uses a two-pass approach with hash maps:
1. **First pass:** Build a frequency count of each character and record the first index where each character appears
2. **Second pass:** Find all characters with count == 1 and return the one with the smallest first index

**Time Complexity:** O(n) where n is the length of the string
**Space Complexity:** O(k) where k is the number of unique characters

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `"leetcode"` | `0` | 'l' appears at index 0 and doesn't repeat |
| `"loveleetcode"` | `2` | 'v' is the first non-repeating character at index 2 |
| `"aabb"` | `-1` | No non-repeating characters |
| `"a"` | `0` | Single character is always the answer |
| `"aabbc"` | `4` | 'c' at index 4 is the only non-repeating character |

### Edge Cases
- **Empty string:** Returns input error (precondition check)
- **All repeating:** Returns `-1`
- **All unique:** Returns `0` (first character)
- **Single character:** Returns `0`
