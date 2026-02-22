# Find All Anagrams in a String

## Problem

Given a string `s` and a non-empty string `p`, find all the start indices of `p`'s anagrams in `s`.

An anagram is a word or phrase formed by rearranging the letters of a different word or phrase, typically using all the original letters exactly once.

Return the indices in any order.

**Example:**
- Input: s = "cbaebabacd", p = "abc"
- Output: [0, 6]
- Explanation: 
  - The substring with start index 0 is "cba", which is an anagram of "abc"
  - The substring with start index 6 is "bac", which is an anagram of "abc"

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/find_all_anagrams.xs`):** Contains the solution logic using sliding window with frequency counters

## Function Signature

- **Input:**
  - `s` (text): The string to search within
  - `p` (text): The pattern to find anagrams of
- **Output:**
  - `int[]`: Array of starting indices where anagrams of p occur in s

## Algorithm

This solution uses the **sliding window** technique with **frequency counters**:

1. Build a frequency map for the pattern `p`
2. Initialize a frequency map for the first window of size `len(p)` in `s`
3. Compare the two frequency maps - if they match, record the starting index
4. Slide the window one character at a time:
   - Remove the leftmost character from the window frequency map
   - Add the new right character to the window frequency map
   - Compare frequency maps and record index if they match
5. Continue until the window reaches the end of string `s`

**Time Complexity:** O(n × 26) = O(n), where n is the length of s
**Space Complexity:** O(26) = O(1) for the frequency maps

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| s="cbaebabacd", p="abc" | [0, 6] | "cba" at index 0, "bac" at index 6 |
| s="abab", p="ab" | [0, 1, 2] | "ab" at index 0, "ba" at index 1, "ab" at index 2 |
| s="aaaa", p="aa" | [0, 1, 2] | All substrings of 2 a's |
| s="abc", p="abcd" | [] | Pattern longer than string |
| s="", p="a" | [] | Empty string |
| s="a", p="a" | [0] | Single character match |
