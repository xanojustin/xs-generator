# Longest Repeating Character Replacement

## Problem
Given a string `s` and an integer `k`, find the length of the longest substring containing the same letter after performing at most `k` character replacements.

You can replace any character in the string with any other uppercase English letter. The goal is to find the longest substring where all characters are the same, using at most `k` replacements to achieve this.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/longest_repeating_character_replacement.xs`):** Contains the solution logic using the sliding window technique

## Function Signature
- **Input:**
  - `s` (text): The input string containing uppercase English letters
  - `k` (int): The maximum number of character replacements allowed
- **Output:** (int) The length of the longest substring with all same characters after at most k replacements

## Algorithm
This solution uses the **sliding window** technique:
1. Maintain a window with `left` and `right` pointers
2. Expand the window by moving `right` pointer
3. Track character frequencies within the window
4. If window size minus max frequency > k, shrink window from left
5. The maximum valid window size is the answer

## Test Cases

| Input | k | Expected Output |
|-------|---|-----------------|
| "ABAB" | 2 | 4 |
| "AABABBA" | 1 | 4 |
| "" | 0 | 0 |
| "AAAA" | 0 | 4 |
| "ABBB" | 2 | 4 |

### Test Case Explanations
1. **"ABAB", k=2:** Replace both 'A's with 'B's or both 'B's with 'A's to get "BBBB" or "AAAA" → length 4
2. **"AABABBA", k=1:** Replace 'B' at index 3 with 'A' to get "AABAA" or replace middle 'A' to get "AABBBBA" → longest is 4
3. **"" (empty string):** Edge case, returns 0
4. **"AAAA", k=0:** No replacements needed, already all same → length 4
5. **"ABBB", k=2:** Replace 'A' with 'B' to get "BBBB" → length 4
