# Group Anagrams

## Problem
Given an array of strings, group the anagrams together. An anagram is a word or phrase formed by rearranging the letters of a different word or phrase, typically using all the original letters exactly once.

For example, "eat", "tea", and "ate" are anagrams of each other because they all contain exactly one 'a', one 'e', and one 't'.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/group_anagrams.xs`):** Contains the solution logic

## Function Signature
- **Input:** 
  - `strings` (text[]): Array of strings to group into anagrams
- **Output:** 
  - Returns an array of arrays, where each inner array contains strings that are anagrams of each other

## Algorithm
The solution uses a signature-based approach:
1. For each word, create a signature by sorting its characters alphabetically
2. Words with the same signature are anagrams
3. Group words by their signature
4. Return the groups as an array of arrays

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `["eat", "tea", "tan", "ate", "nat", "bat"]` | `[["eat","tea","ate"],["tan","nat"],["bat"]]` (order may vary) |
| `[""]` | `[[""]]` |
| `["a"]` | `[["a"]]` |
| `["abc", "bca", "cab", "xyz", "zyx"]` | `[["abc","bca","cab"],["xyz","zyx"]]` (order may vary) |
| `[]` | `[]` |

### Edge Cases
- **Empty input:** Returns empty array
- **Single character:** Each character forms its own group
- **Empty strings:** Empty strings group together
- **No anagrams:** Each word gets its own group
