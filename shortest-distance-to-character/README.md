# Shortest Distance to Character

## Problem
Given a string `s` and a character `c` that occurs in `s`, return an array of integers representing the shortest distance from each character in `s` to the character `c` in the string.

The distance between two indices `i` and `j` is `abs(i - j)`.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/shortest_distance_to_character.xs`):** Contains the solution logic

## Function Signature
- **Input:**
  - `s` (text): The input string
  - `c` (text): The target character to find (single character)
- **Output:** 
  - (int[]): Array where each element represents the shortest distance from that position to the nearest occurrence of character `c`

## Algorithm
The solution uses a two-pass approach:
1. **Left-to-right pass:** For each position, calculate the distance to the nearest `c` on the left (or infinity if none seen yet)
2. **Right-to-left pass:** For each position, calculate the distance to the nearest `c` on the right and take the minimum of the two distances

This achieves O(n) time complexity where n is the length of the string.

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `s = "loveleetcode"`, `c = "e"` | `[3,2,1,0,1,0,0,1,2,2,1,0]` |
| `s = "aaab"`, `c = "b"` | `[3,2,1,0]` |
| `s = "ab"`, `c = "a"` | `[0,1]` |
| `s = "a"`, `c = "a"` | `[0]` |
| `s = "bab"`, `c = "b"` | `[0,1,0]` |

### Test Case Explanations:
- **Example 1:** "loveleetcode" with target 'e' - shows multiple occurrences and varying distances
- **Example 2:** "aaab" with target 'b' - target at the end, distances increase left-to-right
- **Example 3:** "ab" with target 'a' - simple two-character case
- **Edge Case:** "a" with target 'a' - single character, same as target
- **Boundary:** "bab" with target 'b' - target at both ends, middle is distance 1 from both
