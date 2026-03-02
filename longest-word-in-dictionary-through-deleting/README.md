# Longest Word in Dictionary Through Deleting

## Problem

Given a string `s` and a dictionary `d` of strings, return the longest string in `d` that can be formed by deleting some characters from `s`. 

If there are multiple possible results, return the longest word with the smallest lexicographical order. If there is no possible result, return the empty string.

A word can be formed by deleting characters from `s` if all its characters appear in `s` in the same relative order (not necessarily contiguous).

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/longest_word_in_dictionary_through_deleting.xs`):** Contains the solution logic using two-pointer technique

## Function Signature

- **Input:**
  - `s` (text): The source string from which characters can be deleted
  - `d` (text[]): An array of dictionary words to check against
- **Output:** (text) The longest word that can be formed by deleting characters from `s`, or empty string if none exist

## Algorithm

1. Sort the dictionary by length descending, then lexicographically ascending for ties
2. For each word, use two-pointer technique to check if it can be formed from `s`
3. Return the first match found (due to sorting, this will be the correct answer)

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `s="abpcplea"`, `d=["ale","apple","monkey","plea"]` | `"apple"` | "apple" can be formed from "abpcplea" and is the longest valid word |
| `s="abpcplea"`, `d=["a","b","c"]` | `"a"` | All single chars are valid; "a" is lexicographically smallest |
| `s="bab"`, `d=["ba","ab","a","b"]` | `"ab"` | Both "ba" and "ab" can be formed; same length, "ab" is lexicographically smaller |
| `s="xyz"`, `d=["abc","def"]` | `""` | No words can be formed from "xyz" |
| `s=""`, `d=["a","b"]` | `""` | Empty source string can't form any word |

## Complexity

- **Time:** O(n × m × log(n)) where n is dictionary size, m is average word length (due to sorting)
- **Space:** O(n) for the sorted dictionary