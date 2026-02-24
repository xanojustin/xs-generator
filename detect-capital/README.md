# Detect Capital

## Problem
We define the usage of capitals in a word to be correct when one of the following conditions is met:

1. All letters in this word are capitals (e.g., `"USA"`)
2. All letters in this word are not capitals (e.g., `"leetcode"`)
3. Only the first letter in this word is capital (e.g., `"Google"`)

Given a string `word`, return `true` if the capital usage is correct, otherwise return `false`.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/detect-capital.xs`):** Contains the solution logic

## Function Signature
- **Input:** 
  - `word` (text): The word to check for correct capital usage
- **Output:** 
  - (bool): `true` if capital usage is correct, `false` otherwise

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `"USA"` | `true` | All capitals - valid |
| `"leetcode"` | `true` | All lowercase - valid |
| `"Google"` | `true` | First capital only - valid |
| `"FlaG"` | `false` | Mixed capitals (not all upper, not all lower, not first-only) - invalid |
| `"gOOGLE"` | `false` | First lowercase, rest uppercase - invalid |
| `"A"` | `true` | Single uppercase - valid (matches all three rules) |
| `"m"` | `true` | Single lowercase - valid |
