# Word Break

## Problem
Given a string `s` and a dictionary of strings `wordDict`, return `true` if `s` can be segmented into a space-separated sequence of one or more dictionary words.

**Note:** The same word in the dictionary may be reused multiple times in the segmentation.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/word_break.xs`):** Contains the solution logic using dynamic programming

## Function Signature
- **Input:**
  - `s` (text): The string to segment
  - `wordDict` (text[]): Array of dictionary words
- **Output:** (bool) `true` if the string can be segmented, `false` otherwise

## Algorithm
This solution uses dynamic programming:
1. Create a DP array `dp` where `dp[i]` represents whether `s[0..i-1]` can be segmented
2. Initialize `dp[0] = true` (empty string can always be segmented)
3. For each position `i` from 1 to n:
   - For each position `j` from 0 to i-1:
     - If `dp[j]` is true and `s[j..i-1]` is in the dictionary, set `dp[i] = true`
4. Return `dp[n]` where n is the length of the string

## Test Cases
| Input | Expected Output |
|-------|-----------------|
| `s = "leetcode"`, `wordDict = ["leet", "code"]` | `true` ("leet" + "code") |
| `s = "applepenapple"`, `wordDict = ["apple", "pen"]` | `true` ("apple" + "pen" + "apple") |
| `s = ""`, `wordDict = ["any"]` | `true` (empty string) |
| `s = "catsandog"`, `wordDict = ["cats", "dog", "sand", "and", "cat"]` | `false` (cannot fully segment) |
| `s = "aaaaaaa"`, `wordDict = ["aaa", "aaaa"]` | `true` (multiple ways to segment) |
