# Buddy Strings

## Problem

Given two strings `s` and `goal`, determine if you can swap exactly one pair of characters in `s` so that the result equals `goal`.

Two strings are "buddy strings" if you can make them equal by swapping exactly one pair of characters in one of the strings.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/buddy_strings.xs`):** Contains the solution logic

## Function Signature

- **Input:**
  - `s` (text): First string
  - `goal` (text): Second string to compare against
- **Output:** (bool) `true` if the strings are buddy strings, `false` otherwise

## Test Cases

| s | goal | Expected Output | Explanation |
|---------------|---------------|-----------------|-------------|
| "ab" | "ba" | true | Swap 'a' and 'b' in s to get goal |
| "ab" | "ab" | false | Strings are equal but no duplicate characters to swap |
| "aa" | "aa" | true | Strings are equal and has duplicate 'a' characters |
| "aaaaaaabc" | "aaaaaaacb" | true | Swap 'b' and 'c' at positions 7 and 8 |
| "" | "aa" | false | Different lengths |
| "ab" | "ca" | false | More than 2 differences |

## Rules

1. If the strings have different lengths, they cannot be buddy strings.
2. If the strings are already equal, they are buddy strings only if there is at least one duplicate character (so we can swap identical characters).
3. If the strings differ at exactly 2 positions, check if swapping the characters at those positions in `s` would make it equal to `goal`.
4. If the strings differ at any other number of positions, they are not buddy strings.
