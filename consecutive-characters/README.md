# Consecutive Characters

## Problem
Given a string `s`, return the **power** of the string. The power of the string is the maximum length of a non-empty substring that contains only one unique character.

### Examples
- Input: `"leetcode"` → Output: `2` (the two consecutive "e"s)
- Input: `"abbcccddddeeeeedcba"` → Output: `5` (the five consecutive "d"s)
- Input: `"triplepillooooow"` → Output: `5` (the five consecutive "o"s)
- Input: `"hooraaaaaaaaaaay"` → Output: `11` (the eleven consecutive "a"s)

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/consecutive-characters.xs`):** Contains the solution logic

## Function Signature
- **Input:** `s` (text) - The input string to analyze
- **Output:** (int) - The maximum length of consecutive repeating characters (power of the string)

## Approach
1. Handle the edge case of an empty string (return 0)
2. Initialize `max_power` and `current_power` to 1 (single character has power of 1)
3. Iterate through the string starting from the second character
4. If current character matches previous, increment `current_power` and update `max_power` if needed
5. If characters differ, reset `current_power` to 1
6. Return `max_power`

## Time & Space Complexity
- **Time Complexity:** O(n) where n is the length of the string
- **Space Complexity:** O(1) - only using a few tracking variables

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `"leetcode"` | `2` | Two consecutive 'e's |
| `"abbcccddddeeeeedcba"` | `5` | Five consecutive 'd's |
| `"triplepillooooow"` | `5` | Five consecutive 'o's |
| `"hooraaaaaaaaaaay"` | `11` | Eleven consecutive 'a's |
| `""` (empty) | `0` | Edge case: empty string |
| `"a"` (single char) | `1` | Edge case: single character |
| `"abcde"` | `1` | No consecutive repeats |
| `"aaaaaa"` | `6` | All characters same |
