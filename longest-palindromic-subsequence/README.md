# Longest Palindromic Subsequence

## Problem

Given a string `s`, find the length of the **longest palindromic subsequence**.

A **subsequence** is a sequence that can be derived from another sequence by deleting some or no elements without changing the order of the remaining elements.

A **palindrome** is a string that reads the same backward as forward.

### Example
- Input: `"bbbab"`
- Output: `4`
- Explanation: One possible longest palindromic subsequence is `"bbbb"`.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/solve.xs`):** Contains the dynamic programming solution

## Function Signature

- **Input:** 
  - `text` (text): The input string to analyze
- **Output:** 
  - Returns `int`: The length of the longest palindromic subsequence

## Algorithm

This solution uses **dynamic programming** with a 2D table where `dp[i][j]` represents the length of the longest palindromic subsequence in the substring `text[i..j]`.

### Base Cases:
- Single characters are palindromes of length 1: `dp[i][i] = 1`

### Recurrence Relation:
- If `text[i] == text[j]`: `dp[i][j] = dp[i+1][j-1] + 2`
- If `text[i] != text[j]`: `dp[i][j] = max(dp[i+1][j], dp[i][j-1])`

### Time Complexity: O(n²)
### Space Complexity: O(n²)

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `"bbbab"` | `4` | Longest subsequence: `"bbbb"` |
| `"cbbd"` | `2` | Longest subsequence: `"bb"` |
| `"a"` | `1` | Single character is a palindrome |
| `""` | `0` | Empty string has no subsequence |
| `"abcde"` | `1` | No repeating characters, any single char |
| `"racecar"` | `7` | Entire string is a palindrome |
| `"aaa"` | `3` | Entire string is a palindrome |

## XanoScript Features Used

- **Dynamic programming** with 2D arrays
- **Nested loops** using `for` and `each`
- **Conditional logic** with `if/elseif/else`
- **String manipulation** with `substr` filter
- **Array operations** with `get`, `set`, `append`
- **Early returns** for edge cases
