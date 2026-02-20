# Longest Common Prefix

## Problem
Write a function to find the longest common prefix string amongst an array of strings.

If there is no common prefix, return an empty string `""`.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/longest_common_prefix.xs`):** Contains the solution logic

## Function Signature
- **Input:** `strings` (text[]) - An array of strings to analyze
- **Output:** `text` - The longest common prefix string, or empty string if none exists

## Algorithm
1. Handle the edge case: if the array is empty, return `""`
2. Start with the first string as the initial prefix candidate
3. Iterate through remaining strings, shortening the prefix until it matches the beginning of each string
4. Return the final prefix (or empty string if no common prefix was found)

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `["flower", "flow", "flight"]` | `"fl"` |
| `["dog", "racecar", "car"]` | `""` (no common prefix) |
| `[]` | `""` (empty array) |
| `["single"]` | `"single"` (single element) |
| `["aaa", "aa", "a"]` | `"a"` (prefix shorter than shortest string) |
| `["test", "test", "test"]` | `"test"` (all identical) |

## Complexity
- **Time Complexity:** O(S) where S is the sum of all characters in all strings
- **Space Complexity:** O(1) - only using a constant amount of extra space
