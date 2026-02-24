# Rotate String

## Problem
Given two strings `s1` and `s2`, determine if `s2` is a rotation of `s1`.

A string rotation means taking any number of characters from the beginning of the string and moving them to the end. For example:
- "abcde" rotated by 2 positions becomes "cdeab"
- "hello" rotated by 1 position becomes "ohell"

**Key Insight:** If `s2` is a rotation of `s1`, then `s2` must be a substring of `s1 + s1`.

Example: "abcde" + "abcde" = "abcdeabcde", which contains "cdeab" as a substring.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/rotate_string.xs`):** Contains the solution logic

## Function Signature
- **Input:**
  - `s1` (text): The original string
  - `s2` (text): The string to check if it's a rotation of s1
- **Output:** (bool) `true` if s2 is a rotation of s1, `false` otherwise

## Test Cases

| s1 | s2 | Expected Output | Explanation |
|----|----|-----------------|-------------|
| "abcde" | "cdeab" | true | Classic rotation by 2 positions |
| "hello" | "lohel" | true | Rotation by 3 positions |
| "abc" | "acb" | false | Not a valid rotation |
| "" | "" | true | Empty strings are rotations of each other |
| "a" | "a" | true | Single character, same string |
| "abc" | "abcd" | false | Different lengths cannot be rotations |
| "rotation" | "tationro" | true | Valid rotation |
| "waterbottle" | "erbottlewat" | true | Common interview example |