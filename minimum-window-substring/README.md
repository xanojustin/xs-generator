# Minimum Window Substring

## Problem
Given two strings `s` and `t`, return the minimum window substring of `s` such that every character in `t` (including duplicates) is included in the window.

If there is no such substring, return an empty string `""`.

The testcases will be generated such that the answer is unique.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/minimum_window_substring.xs`):** Contains the solution logic using sliding window technique

## Function Signature
- **Input:** 
  - `s` (text): Source string to search within
  - `t` (text): Target string containing characters to find
- **Output:** 
  - (text): The minimum window substring containing all characters from t, or empty string if not found

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `s: "ADOBECODEBANC", t: "ABC"` | `"BANC"` |
| `s: "a", t: "a"` | `"a"` |
| `s: "a", t: "aa"` | `""` (edge case: t longer than s) |
| `s: "OUZODYXAZV", t: "XYZ"` | `"YXAZ"` |

## Algorithm
This solution uses the **sliding window** technique:

1. **Build frequency map** for characters in t (how many of each char we need)
2. **Expand window** by moving right pointer, adding characters to window frequency map
3. **Track formed count** - when we have enough of a required character, increment formed
4. **Contract window** by moving left pointer when we have all required characters
5. **Update minimum** whenever we find a smaller valid window
6. **Return result** - extract substring from the best start index with minimum length

**Time Complexity:** O(|s| + |t|) - each character visited at most twice (once by right, once by left)  
**Space Complexity:** O(|s| + |t|) - for the frequency maps
