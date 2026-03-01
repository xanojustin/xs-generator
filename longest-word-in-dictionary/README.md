# Longest Word in Dictionary

## Problem
Given an array of strings `words` representing an English dictionary, find the longest word that can be built one character at a time by other words in the dictionary.

A word can be built if all its prefixes (removing one character at a time from the end) are also in the dictionary. For example, "word" can be built if "w", "wo", and "wor" are all in the dictionary.

If there is more than one possible answer, return the lexicographically smallest one (the one that comes first alphabetically). If there is no answer, return the empty string.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/longest_word.xs`):** Contains the solution logic

## Function Signature
- **Input:** 
  - `words` (text[]): Array of strings representing the dictionary words
- **Output:** 
  - (text): The longest word that can be built one character at a time. If multiple words have the same maximum length, returns the lexicographically smallest one.

## Algorithm
1. Build a lookup set (object) from all words for O(1) existence checks
2. Find the maximum word length in the dictionary
3. Process words from longest length to shortest:
   - Collect all words of the current length
   - Sort them lexicographically (so we check smallest first)
   - For each word, verify all its prefixes exist in the dictionary
   - Return the first valid word found (longest length, lexicographically smallest)

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `["w", "wo", "wor", "word"]` | `"word"` | All prefixes of "word" exist in the dictionary |
| `["a", "banana", "app", "appl", "ap", "apply", "apple"]` | `"apple"` | Both "apple" and "apply" have length 5; "apple" is lexicographically smaller |
| `[]` | `""` | Empty dictionary returns empty string |
| `["a"]` | `"a"` | Single character word can always be built (no prefixes needed) |
| `["b", "br", "bre", "brea", "break", "brea"]` | `"break"` | "break" has all prefixes in the dictionary |
| `["m", "mo", "moc", "mock", "mocki", "mockin", "mocking"]` | `"mocking"` | Longest word with all prefixes present |

## Example Walkthrough

For input `["w", "wo", "wor", "word", "world", "worl"]`:

1. Build lookup set: `{w: true, wo: true, wor: true, word: true, world: true, worl: true}`
2. Maximum length is 5 (for "world")
3. Check length 5 words: ["world"] - "worl" exists? Yes. "wor"? Yes. "wo"? Yes. "w"? Yes. ✅ Found "world"
4. Check length 4 words: ["word", "worl"] - "word" is lexicographically smaller than "world"? No, need to compare:
   - Actually at length 5 we found "world", so we return it
   
Wait - let me reconsider. The algorithm finds the longest first. At length 5, "world" is the only word. All its prefixes exist, so we return "world".
