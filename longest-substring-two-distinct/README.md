# Longest Substring with At Most Two Distinct Characters

## Problem

Given a string `s`, find the **length** of the **longest substring** that contains at most **2 distinct characters**.

A substring is a contiguous sequence of characters within a string. The solution should efficiently find the maximum length using the sliding window technique.

### Examples

- **Example 1:** Input: `"eceba"` → Output: `3`
  - Explanation: The substring is `"ece"` with length 3 (contains 'e' and 'c')
  
- **Example 2:** Input: `"ccaabbb"` → Output: `5`
  - Explanation: The substring is `"aabbb"` with length 5 (contains 'a' and 'b')

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/longest_substring_two_distinct.xs`):** Contains the sliding window solution logic

## Function Signature

- **Input:**
  - `s` (text): The input string to analyze
  
- **Output:**
  - (int): The length of the longest substring containing at most 2 distinct characters

## Algorithm

This solution uses the **Sliding Window** technique:

1. Maintain two pointers (`left` and `right`) representing the current window
2. Expand the window by moving the `right` pointer
3. Track character frequencies using an object/map
4. When the window contains more than 2 distinct characters, shrink from the `left`
5. Keep track of the maximum window size seen

**Time Complexity:** O(n) - each character is visited at most twice (once by right, once by left)  
**Space Complexity:** O(1) - at most 3 distinct characters stored in the map

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `"eceba"` | `3` | Substring `"ece"` (e, c) |
| `"ccaabbb"` | `5` | Substring `"aabbb"` (a, b) |
| `""` | `0` | Empty string edge case |
| `"a"` | `1` | Single character |
| `"aaaaa"` | `5` | All same character |
| `"ab"` | `2` | Exactly 2 distinct characters |
| `"abc"` | `2` | First 2 characters form longest valid substring |

## XanoScript Features Used

- **String manipulation:** `strlen`, `split` filters
- **Object operations:** `get`, `set` filters for the character count map
- **Array indexing:** Accessing characters by position
- **Conditional blocks:** `if/elseif/else` for decision making
- **While loops:** For sliding window expansion and contraction
- **Type conversions:** `to_text`, `to_int` for object key/value handling
