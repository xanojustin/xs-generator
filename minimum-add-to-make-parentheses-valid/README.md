# Minimum Add to Make Parentheses Valid

## Problem

Given a string `s` of `'('` and `')'` parentheses, we need to add the minimum number of parentheses (either `'('` or `')'`, in any positions) so that the resulting parentheses string is valid.

A parentheses string is valid if:
- It is the empty string, or
- It can be written as `AB` (A concatenated with B), where A and B are valid strings, or
- It can be written as `(A)`, where A is a valid string.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/min_add_to_make_valid.xs`):** Contains the solution logic

## Function Signature

- **Input:** `s` (text) - A string containing only `'('` and `')'` characters
- **Output:** (int) - The minimum number of parentheses to add to make the string valid

## Algorithm

The solution uses a simple counter-based approach:

1. Track unmatched open parentheses count (`open_count`)
2. Track additions needed for unmatched closing parentheses (`additions_needed`)
3. For each character in the string:
   - If `'('` → increment `open_count`
   - If `')'` and `open_count > 0` → decrement `open_count` (matched a pair)
   - If `')'` and `open_count == 0` → increment `additions_needed` (need to add `'('` before this)
4. Return `additions_needed + open_count` (unmatched closes needing opens + unmatched opens needing closes)

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `"())"` | `1` | Need to add one `'('` at the beginning: `"(())"` |
| `"((("` | `3` | Need to add three `')'` at the end: `"((()))"` |
| `"()"` | `0` | Already valid |
| `"))(("` | `4` | Need to add two `'('` at start and two `')'` at end: `"(())(())"` |
| `""` | `0` | Empty string is valid |
| `"()()"` | `0` | Already valid |
| `")("` | `2` | Need to add `'('` at start and `')'` at end: `"()()"` |

## Complexity Analysis

- **Time Complexity:** O(n) where n is the length of the string - we iterate once
- **Space Complexity:** O(n) for splitting the string into characters
