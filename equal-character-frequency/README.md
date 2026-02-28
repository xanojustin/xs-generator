# Equal Character Frequency

## Problem
Given a string `s`, return `true` if all characters in the string have the same frequency of occurrence. Return `false` otherwise.

A string has equal character frequency if every character that appears in the string appears the same number of times.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/equal_character_frequency.xs`):** Contains the solution logic

## Function Signature
- **Input:** `s` (text) - The input string to check
- **Output:** (bool) - `true` if all characters appear with equal frequency, `false` otherwise

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `"abacbc"` | `true` | a=2, b=2, c=2 - all equal |
| `"aaabb"` | `false` | a=3, b=2 - not equal |
| `""` | `true` | Empty string (edge case) |
| `"a"` | `true` | Single character |
| `"abcdefghijklmnopqrstuvwxyz"` | `true` | Each letter appears once |
| `"abcabcabc"` | `true` | a=3, b=3, c=3 - all equal |
| `"aabbccddd"` | `false` | a=2, b=2, c=2, d=3 - not equal |

## Approach
1. Handle edge case: empty string returns `true`
2. Build a frequency map by iterating through each character
3. Extract all frequency values from the map
4. Check if all frequencies are equal to the first frequency value
5. Return the result
