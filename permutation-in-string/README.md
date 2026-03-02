# Permutation in String

## Problem

Given two strings `s1` and `s2`, return `true` if `s2` contains a permutation of `s1`.

In other words, return `true` if one of `s1`'s permutations is a substring of `s2`.

**Example 1:**
- Input: s1 = "ab", s2 = "eidbaooo"
- Output: true
- Explanation: s2 contains one permutation of s1 ("ba").

**Example 2:**
- Input: s1 = "ab", s2 = "eidboaoo"
- Output: false
- Explanation: s2 does not contain any permutation of s1.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/check_permutation_in_string.xs`):** Contains the solution logic using sliding window with character frequency counting

## Function Signature

- **Input:**
  - `s1` (text): The pattern string to find a permutation of
  - `s2` (text): The string to search within
- **Output:** (bool) `true` if s2 contains any permutation of s1, `false` otherwise

## Algorithm

This solution uses the **sliding window** technique with character frequency counting:

1. **Early Exit:** If `s1` is longer than `s2`, immediately return `false`
2. **Build Frequency Map:** Count occurrences of each character in `s1`
3. **Initialize Window:** Create frequency map for the first `len(s1)` characters of `s2`
4. **Compare:** Check if the initial window matches `s1`'s frequency map
5. **Slide Window:** Move the window one character at a time through `s2`:
   - Remove the leftmost character from the window count
   - Add the new rightmost character to the window count
   - Compare frequency maps
6. **Return Result:** Return `true` if any window matches, `false` otherwise

**Time Complexity:** O(n) where n is the length of s2
**Space Complexity:** O(1) since we store at most 26 characters (lowercase English letters)

## Test Cases

| s1 | s2 | Expected Output | Description |
|----|----|-----------------|-------------|
| "ab" | "eidbaooo" | true | Basic case - permutation "ba" found |
| "ab" | "eidboaoo" | false | Basic case - no permutation found |
| "a" | "a" | true | Edge case - single character match |
| "abc" | "" | false | Edge case - empty s2 |
| "hello" | "ooolleoooleh" | true | Boundary case - longer strings with match |
| "adc" | "dcda" | true | Boundary case - exact window match at end |
| "ab" | "a" | false | Edge case - s1 longer than s2 |
