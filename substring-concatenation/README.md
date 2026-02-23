# Substring with Concatenation of All Words

## Problem

Given a string `s` and an array of strings `words`, where all strings in `words` have the same length, find all starting indices of substrings in `s` that are a concatenation of all the strings in `words` in any order.

A concatenation of all words means the substring contains each word in `words` exactly the same number of times as it appears in `words`, with no extra characters between words. The words can appear in any order within the substring.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/substring_concatenation.xs`):** Contains the solution logic

## Function Signature

- **Input:**
  - `s` (text): The string to search within
  - `words` (text[]): An array of words (all of the same length) to find concatenations of
  
- **Output:** 
  - `int[]`: An array of starting indices where valid concatenations begin

## Approach

The solution uses a sliding window technique combined with hash maps:

1. **Build a word count map:** Count occurrences of each word in the `words` array
2. **Slide a window:** Iterate through the string with a window size equal to `total_length` (word_length × number_of_words)
3. **Check each window:** For each window position, extract words of the required length and verify they match the expected counts
4. **Track seen words:** Use a hash map to count words seen in the current window
5. **Validate:** If all words match exactly, record the starting index

Time Complexity: O(n × m) where n is the length of string `s` and m is the number of words
Space Complexity: O(m) for storing word counts

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `s="barfoothefoobarman"`, `words=["foo","bar"]` | `[0, 9]` |
| `s="wordgoodgoodgoodbestword"`, `words=["word","good","best","word"]` | `[]` |
| `s=""`, `words=["foo","bar"]` | `[]` |
| `s="foobar"`, `words=[]` | `[]` |
| `s="lingmindrabooowindowssanclementoopohfava"`, `words=["oo","fava","va","win"]` | `[14]` |

### Test Case Explanations

1. **Basic case:** "barfoo" at index 0 contains "bar" and "foo", "foobar" at index 9 contains "foo" and "bar"
2. **No valid concatenation:** "word" appears twice in words but only once in the string at any position
3. **Empty string:** Edge case - empty string cannot contain any concatenation
4. **Empty words array:** Edge case - no words to concatenate
5. **Single match:** Only one valid starting position contains all words in any order
