# Ransom Note

## Problem

Given two strings `ransomNote` and `magazine`, return `true` if `ransomNote` can be constructed by using the letters from `magazine` and `false` otherwise.

Each letter in `magazine` can only be used once in `ransomNote`.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/ransom_note.xs`):** Contains the solution logic

## Function Signature

- **Input:**
  - `ransom_note` (text): The ransom note string to construct
  - `magazine` (text): The magazine string to use as source
- **Output:**
  - (bool): `true` if ransom note can be constructed, `false` otherwise

## Algorithm

1. Handle edge case: empty ransom note returns `true`
2. Count letter frequencies in the magazine using an object as a hash map
3. Iterate through each character in the ransom note:
   - If the character is not available or count is 0, return `false`
   - Otherwise, decrement the count for that character
4. Return `true` if all characters can be matched

## Test Cases

| Ransom Note | Magazine | Expected Output |
|-------------|----------|-----------------|
| `"aa"` | `"aab"` | `true` |
| `"aa"` | `"ab"` | `false` |
| `""` | `"any magazine"` | `true` (empty note) |
| `"abc"` | `"abc"` | `true` (exact match) |
| `"aaa"` | `"aa"` | `false` (not enough letters) |
| `"aabbcc"` | `"abcabc"` | `true` |
| `"xyz"` | `"abc"` | `false` (no matching letters) |

## Time & Space Complexity

- **Time Complexity:** O(m + n) where m = len(magazine), n = len(ransomNote)
- **Space Complexity:** O(k) where k = unique characters in magazine (at most 26 for lowercase letters)

## XanoScript Techniques Used

- Object as hash map for character counting
- `split:""` filter to iterate over string characters
- `get` filter with default values for safe key access
- `set` filter to update object properties
- Early return pattern for edge cases
