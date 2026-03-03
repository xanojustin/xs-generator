# Word Frequency Counter

## Problem
Given a text string, count the frequency of each word and return statistics including total words, unique words, and the frequency of each word (sorted by frequency descending).

A word is defined as a sequence of characters separated by whitespace. The comparison is case-insensitive (all words are converted to lowercase).

## Structure
- **Run Job (`run.xs`):** Calls the word-frequency function with test text
- **Function (`function/word-frequency.xs`):** Contains the word counting logic

## Function Signature
- **Input:** 
  - `text` (text): The input text to analyze
- **Output:** 
  - `total_words` (int): Total number of words in the text
  - `unique_words` (int): Number of unique words
  - `frequencies` (array): Array of objects with `key` (word) and `value` (count)

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `"hello world hello"` | total_words: 3, unique_words: 2, frequencies: [{key: "hello", value: 2}, {key: "world", value: 1}] |
| `"The quick brown fox jumps over the lazy dog the quick brown fox"` | total_words: 11, unique_words: 8, "the" appears 3 times, "quick"/"brown"/"fox" appear 2 times |
| `""` (empty string) | total_words: 0, unique_words: 0, frequencies: [] |
| `"a a a a a"` | total_words: 5, unique_words: 1, "a" appears 5 times |
| `"ONE one One oNe ONE"` | total_words: 5, unique_words: 1, "one" appears 5 times (case insensitive) |
