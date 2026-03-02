# Replace Words

## Problem

Given a dictionary of roots and a sentence, replace all words in the sentence with their shortest root from the dictionary. If a word has multiple roots that match, use the shortest one.

In English, a root word can have various suffixes added to it to form new words. For example, the root "cat" can become "cats", "cattle", "category", etc. The task is to find the shortest root that matches the beginning of each word and replace the word with that root.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/replace_words.xs`):** Contains the solution logic that processes the sentence

## Function Signature

- **Input:**
  - `dictionary` (text[]): List of root words to match against
  - `sentence` (text): The sentence to process, words separated by spaces
  
- **Output:** (text) The processed sentence with words replaced by their shortest matching root

## Test Cases

| Input Dictionary | Input Sentence | Expected Output |
|-----------------|----------------|-----------------|
| `["cat", "bat", "rat"]` | `"the cattle was rattled by the battery"` | `"the cat was rat by the bat"` |
| `["a", "b", "c"]` | `"aadsfasf absbs bbab cadsfafs"` | `"a a b c"` |
| `[]` | `"hello world"` | `"hello world"` (no roots to match) |
| `["cat"]` | `"cat"` | `"cat"` (exact match) |
| `["cat", "cattle"]` | `"cattles"` | `"cat"` (shortest root wins) |
| `["abc", "bc"]` | `"abc def"` | `"abc def"` (prefix must match from start) |

## Algorithm Explanation

1. Split the sentence into individual words
2. Sort the dictionary by word length (shortest first) so we prioritize shorter roots
3. For each word in the sentence:
   - Check each root in the sorted dictionary
   - If the word starts with the root, replace it with that root
   - Stop after finding the first (shortest) matching root
4. Join the processed words back into a sentence

## Complexity Analysis

- **Time Complexity:** O(n × m × k) where n is number of words, m is number of dictionary entries, and k is average word length
- **Space Complexity:** O(n × k) for storing the result words
