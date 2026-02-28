# Palindrome Partitioning

## Problem

Given a string `s`, partition `s` such that every substring of the partition is a palindrome. Return all possible palindrome partitioning of `s`.

A **palindrome** is a string that reads the same backward as forward.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/palindrome_partition.xs`):** Contains the solution logic using backtracking

## Function Signature

- **Input:** 
  - `s` (text): The input string to partition
- **Output:** 
  - Array of arrays (text[][]): All possible palindrome partitionings where each inner array represents one valid partition

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `"aab"` | `[["a","a","b"],["aa","b"]]` |
| `"a"` | `[["a"]]` |
| `"racecar"` | `[["r","a","c","e","c","a","r"],["r","a","cec","a","r"],["r","aceca","r"],["racecar"]]` |
| `"abc"` | `[["a","b","c"]]` |
| `""` | `[[]]` (empty string returns single empty partition) |

### Test Case Explanations

1. **Basic Case (`"aab"`):** Two valid partitions - either split into individual characters `["a","a","b"]` or group the first two a's `["aa","b"]`
2. **Single Character (`"a"`):** Only one way to partition - the character itself
3. **Multiple Palindromes (`"racecar"`):** Multiple valid palindrome combinations including single characters and multi-character palindromes like "cec", "aceca", and the full string
4. **No Multi-Char Palindromes (`"abc"`):** Only single-character partitions are valid
5. **Edge Case (empty string):** Returns a single empty partition

## Algorithm

The solution uses **backtracking** to explore all possible partitions:

1. Start from index 0 of the string
2. For each position, try all possible substrings starting at that index
3. Check if the substring is a palindrome
4. If it is, add it to the current partition and recursively process the remaining string
5. When we reach the end of the string, add the current partition to results
6. Backtrack by removing the last added substring and try the next possibility

### Palindrome Check

For each substring, we check if it's a palindrome by comparing characters from both ends moving toward the center.

## Complexity Analysis

- **Time Complexity:** O(N × 2^N) where N is the length of the string. In the worst case, we could have 2^N possible partitions, and checking each substring for palindrome takes O(N).
- **Space Complexity:** O(N × 2^N) to store all the partitions in the result.
