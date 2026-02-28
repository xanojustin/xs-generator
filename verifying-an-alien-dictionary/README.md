# Verifying an Alien Dictionary

## Problem

In an alien language, surprisingly, they also use English lowercase letters, but possibly in a different order. The order of the alphabet is some permutation of lowercase letters.

Given a sequence of words written in the alien language, and the order of the alphabet, return `true` if and only if the given words are sorted lexicographically in this alien language.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/verify_alien_dictionary.xs`):** Contains the solution logic

## Function Signature

- **Input:**
  - `words` (text[]): An array of words written in the alien language
  - `order` (text): A string representing the alien alphabet order (26 unique lowercase letters)
  
- **Output:** 
  - `bool`: `true` if words are sorted according to alien order, `false` otherwise

## Algorithm

1. Build a character-to-index mapping from the alien order for O(1) lookups
2. Compare each pair of adjacent words
3. For each pair, compare characters one by one until a difference is found
4. If characters differ, check their positions in the alien order
5. If all characters match up to the length of the shorter word, the shorter word must come first

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `words: ["hello", "leetcode"]`<br>`order: "hlabcdefgijkmnopqrstuvwxyz"` | `true` | In alien order, 'h' (index 0) comes before 'l' (index 1), so "hello" < "leetcode" |
| `words: ["word", "world", "row"]`<br>`order: "worldabcefghijkmnpqstuvxyz"` | `false` | In alien order, 'd' comes after 'l', so "word" > "world" |
| `words: ["apple", "app"]`<br>`order: "abcdefghijklmnopqrstuvwxyz"` | `false` | "app" is a prefix of "apple" but is shorter, so it should come first |
| `words: []`<br>`order: "abcdefghijklmnopqrstuvwxyz"` | `true` | Empty array is considered sorted |
| `words: ["single"]`<br>`order: "abcdefghijklmnopqrstuvwxyz"` | `true` | Single word is always sorted |

## Complexity

- **Time Complexity:** O(C) where C is the total number of characters in all words
- **Space Complexity:** O(1) - the char_map has at most 26 entries (constant space)
