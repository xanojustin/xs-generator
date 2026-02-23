# Longest Valid Parentheses

## Problem
Given a string containing just the characters `'('` and `')'`, find the length of the longest valid (well-formed) parentheses substring.

A valid parentheses substring is one where every opening parenthesis `'('` has a matching closing parenthesis `')'` and they are properly nested.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/longest_valid_parentheses.xs`):** Contains the solution logic using a stack-based approach

## Function Signature
- **Input:** `text s` - A string containing only `'('` and `')'` characters
- **Output:** `int` - The length of the longest valid parentheses substring

## Algorithm Explanation
The solution uses a stack to track indices:
1. Initialize stack with `-1` as a base index for calculating lengths
2. For each character in the string:
   - If `'('`: push its index onto the stack
   - If `')'`: pop from stack
     - If stack becomes empty: push current index as new base
     - Otherwise: calculate length as `current_index - stack_top` and update max
3. Return the maximum length found

**Time Complexity:** O(n) where n is the length of the string
**Space Complexity:** O(n) for the stack

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `"(()"` | 2 | The longest valid substring is `"()"` |
| `")()())"` | 4 | The longest valid substring is `"()()"` |
| `""` | 0 | Empty string has no valid parentheses |
| `"()()"` | 4 | The entire string is valid `"()()"` |
| `"((()))"` | 6 | The entire string is valid `"((()))"` |
| `")()())()()("` | 4 | The longest valid substring is `"()()"` at the end |
| `"(((((("` | 0 | No valid parentheses (only opening) |
| `"))))))"` | 0 | No valid parentheses (only closing) |
