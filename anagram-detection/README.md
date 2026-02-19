# Anagram Detection

## Problem
Determine if two strings are anagrams of each other.

Two strings are anagrams if they contain the exact same characters in the same frequency, just in a different order. For example:
- "listen" and "silent" are anagrams
- "hello" and "world" are not anagrams

The comparison should be case-insensitive and ignore leading/trailing whitespace.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/anagram-detection.xs`):** Contains the solution logic

## Function Signature
- **Input:**
  - `str1` (text, required): First string to compare
  - `str2` (text, required): Second string to compare
  - Both inputs are filtered with `trim|lower` to normalize whitespace and case
- **Output:**
  - Returns `bool`: `true` if the strings are anagrams, `false` otherwise

## Algorithm
1. **Quick reject:** If string lengths differ, return `false` immediately
2. **Empty check:** Two empty strings are anagrams, return `true`
3. **Character comparison:** 
   - Split each string into arrays of characters
   - Sort both arrays alphabetically
   - Compare the sorted arrays (JSON-encoded for equality check)

## Test Cases

| Input (str1, str2) | Expected Output | Notes |
|-------------------|-----------------|-------|
| ("listen", "silent") | `true` | Classic anagram pair |
| ("hello", "world") | `false` | Different characters |
| ("", "") | `true` | Empty strings are anagrams |
| ("a", "a") | `true` | Single character, same |
| ("a", "b") | `false` | Single character, different |
| ("Dormitory", "Dirty room") | `true` | Case-insensitive, space removed by trim |
| ("anagram", "nagaram") | `true` | Same letters rearranged |
| ("rat", "car") | `false` | Different letters |
