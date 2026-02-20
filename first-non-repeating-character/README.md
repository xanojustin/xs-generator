# First Non-Repeating Character

## Problem

Given a string `s`, find the **first non-repeating character** in it and return its index. If no such character exists, return `-1`.

The function should efficiently scan through the string to identify characters that appear exactly once, and return the position of the first one encountered.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/first_non_repeating_character.xs`):** Contains the solution logic using nested loops to count character frequencies

## Function Signature

- **Input:** `s` (text) — The input string to search
- **Output:** (int) — The index of the first non-repeating character, or `-1` if all characters repeat

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `"leetcode"` | `0` | 'l' is the first character and appears only once |
| `"loveleetcode"` | `2` | 'v' at index 2 is the first non-repeating character |
| `"aabb"` | `-1` | No character appears exactly once |
| `""` (empty string) | `-1` | Edge case: empty input returns -1 |
| `"z"` | `0` | Single character is non-repeating by definition |
| `"aabbc"` | `4` | 'c' at index 4 is the only non-repeating character |
