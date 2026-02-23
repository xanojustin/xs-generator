# Decode String

## Problem
Given an encoded string, return its decoded string.

The encoding rule is: `k[encoded_string]`, where the `encoded_string` inside the square brackets is being repeated exactly `k` times. Note that `k` is guaranteed to be a positive integer.

You may assume that the input string is always valid; no extra white spaces, square brackets are well-formed, etc. Furthermore, you may assume that the original data does not contain any digits and that digits are only for those repeat numbers, `k`. For example, there won't be input like `3a` or `2[4]`.

Examples:
- Input: "3[a]2[bc]", Output: "aaabcbc"
- Input: "3[a2[c]]", Output: "accaccacc"
- Input: "2[abc]3[cd]ef", Output: "abcabccdcdcdef"

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/decode_string.xs`):** Contains the solution logic using a stack-based approach

## Function Signature
- **Input:** 
  - `encoded` (text): The encoded string following the pattern `k[encoded_string]`
- **Output:** 
  - `response` (text): The fully decoded string

## Approach
This solution uses a stack-based approach:
1. When encountering a digit, build the complete number (handling multi-digit numbers like `12` or `100`)
2. When encountering `[`, push the current string and repeat count onto the stack, then reset
3. When encountering `]`, pop the repeat count and previous string, then build the repeated substring
4. Regular characters are accumulated in the current string

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `"3[a]2[bc]"` | `"aaabcbc"` |
| `"3[a2[c]]"` | `"accaccacc"` |
| `"2[abc]3[cd]ef"` | `"abcabccdcdcdef"` |
| `"abc3[cd]xyz"` | `"abccdcdcdxyz"` |
| `"10[a]"` | `"aaaaaaaaaa"` (10 a's) |
| `""` | `""` (empty input) |

### Edge Cases
- **Empty string:** Returns empty string
- **No encoding:** Returns the string as-is
- **Nested brackets:** Handles multiple levels of nesting correctly
- **Multi-digit numbers:** Correctly parses numbers like `10`, `100`, etc.
