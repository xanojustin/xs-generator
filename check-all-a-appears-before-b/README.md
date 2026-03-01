# Check If All A's Appears Before All B's

## Problem
Given a string `s` consisting of only the characters `'a'` and `'b'`, return `true` if **every** `'a'` appears before **every** `'b'` in the string. Otherwise, return `false`.

In other words, the string is valid if:
- There are no `'b'` characters that appear before any `'a'` character
- The string may contain only `'a'`s, only `'b'`s, or be empty (all valid cases)

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/check_all_a_before_b.xs`):** Contains the solution logic

## Function Signature
- **Input:** `s` (text) - A string consisting of only characters `'a'` and `'b'`
- **Output:** (bool) - `true` if all `'a'`s appear before all `'b'`s, `false` otherwise

## Approach
The solution uses a single pass through the string with a flag to track if we've seen a `'b'`:
1. Iterate through each character in the string
2. If we see a `'b'`, set a flag indicating we've found a `'b'`
3. If we see an `'a'` after having seen a `'b'`, return `false`
4. If we finish iterating without finding an `'a'` after a `'b'`, return `true`

**Time Complexity:** O(n) where n is the length of the string  
**Space Complexity:** O(1) - only using a boolean flag and index counter

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `"aaabbb"` | `true` | All 'a's come before all 'b's |
| `"abab"` | `false` | 'b' at index 1 appears before 'a' at index 2 |
| `"aaa"` | `true` | No 'b's present, so condition is satisfied |
| `"bbb"` | `true` | No 'a's present, so condition is satisfied |
| `""` | `true` | Empty string is valid |
| `"ba"` | `false` | 'b' appears before 'a' |
| `"aabba"` | `false` | 'a' at index 4 appears after 'b's |
