# Word Break II

## Problem

Given a string `s` and a dictionary of strings `wordDict`, return all possible sentences that can be formed by breaking `s` into valid dictionary words separated by spaces.

For example, given `s = "catsanddog"` and `wordDict = ["cat","cats","and","sand","dog"]`, the valid sentences are:
- `"cats and dog"`
- `"cat sand dog"`

The same word in the dictionary may be reused multiple times in the segmentation. All the strings in `wordDict` are distinct.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with 5 test cases covering basic, multiple combinations, no valid break, single word match, and no dictionary match scenarios
- **Function (`function/word_break_ii.xs`):** Contains the backtracking solution logic using iterative DFS

## Function Signature

- **Input:**
  - `s` (text): The input string to break into words
  - `wordDict` (text[]): Array of valid dictionary words
- **Output:** (text[]): Array of all possible valid sentences where each sentence is a space-separated string of dictionary words

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `s="catsanddog"`, `wordDict=["cat","cats","and","sand","dog"]` | `["cats and dog", "cat sand dog"]` |
| `s="pineapplepenapple"`, `wordDict=["apple","pen","applepen","pine","pineapple"]` | `["pine apple pen apple", "pineapple pen apple", "pine applepen apple"]` |
| `s="catsandog"`, `wordDict=["cats","dog","sand","and","cat"]` | `[]` (no valid segmentation) |
| `s="leetcode"`, `wordDict=["leetcode"]` | `["leetcode"]` |
| `s="hello"`, `wordDict=["world","test"]` | `[]` (no matching words) |

## Approach

The solution uses an iterative depth-first search (DFS) approach with an explicit stack:
1. Start from position 0 with an empty sentence
2. At each position, try all words from the dictionary
3. If a word matches the substring starting at current position, push a new stack frame with updated position and sentence
4. When reaching the end of the string, add the accumulated sentence to results

This approach avoids the complexity of nested function definitions while still achieving the same backtracking behavior.
