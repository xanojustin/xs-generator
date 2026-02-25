# Shortest Word Distance

## Problem

Given an array of strings `words` and two strings `word1` and `word2`, return the **shortest distance** between these two words in the list. The distance is the absolute difference between their indices.

The words may appear multiple times in the array, and `word1` may be equal to `word2`.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/shortest_word_distance.xs`):** Contains the solution logic

## Function Signature

- **Input:**
  - `words` (text[]): An array of strings
  - `word1` (text): The first target word
  - `word2` (text): The second target word

- **Output:**
  - Returns an `int` representing the shortest distance between `word1` and `word2` in the array

## Test Cases

| words | word1 | word2 | Expected Output |
|-------|-------|-------|-----------------|
| `["practice", "makes", "perfect", "coding", "makes"]` | `"coding"` | `"practice"` | `3` |
| `["practice", "makes", "perfect", "coding", "makes"]` | `"makes"` | `"coding"` | `1` |
| `[]` | `"a"` | `"b"` | `0` |
| `["a", "b"]` | `"a"` | `"b"` | `1` |
| `["a", "b", "c", "d", "e", "a", "b"]` | `"a"` | `"b"` | `1` |

### Explanation of Test Cases

1. **Basic case:** "coding" is at index 3, "practice" is at index 0. Distance = 3.
2. **Multiple occurrences:** "makes" appears at indices 1 and 4. The closest to "coding" (index 3) is at index 4. Distance = 1.
3. **Empty array:** Returns the array length (0) when no words are found.
4. **Adjacent words:** Simple case with words next to each other. Distance = 1.
5. **Multiple occurrences with closer match:** The second "a" at index 5 and "b" at index 6 are closest. Distance = 1.

## Algorithm

The solution uses a single-pass approach:

1. Track the most recent indices of `word1` and `word2` as we iterate
2. When both words have been found at least once, calculate the distance
3. Update the minimum distance whenever a smaller one is found
4. Return the minimum distance after processing all words

**Time Complexity:** O(n) where n is the length of the array
**Space Complexity:** O(1) - only using a few variables
