# Reorganize String

## Problem
Given a string `s`, rearrange the characters so that no two adjacent characters are the same.

If it is possible to rearrange the string such that no two adjacent characters are identical, return any valid rearranged string. If it is not possible, return an empty string `""`.

### Example
- Input: `s = "aab"`
- Output: `"aba"` (any valid rearrangement works)

- Input: `s = "aaab"`
- Output: `""` (impossible to rearrange)

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/reorganize_string.xs`):** Contains the solution logic using a greedy algorithm

## Function Signature
- **Input:** 
  - `s` (text): The input string to reorganize
- **Output:** 
  - (text): A valid rearranged string where no two adjacent characters are the same, or an empty string if impossible

## Algorithm
This solution uses a **greedy algorithm** approach:

1. **Count Frequencies:** Count how many times each character appears in the string
2. **Check Feasibility:** If the most frequent character appears more than `(length + 1) / 2` times, it's impossible to rearrange
3. **Sort by Frequency:** Sort characters by their frequency in descending order
4. **Place Characters:** 
   - First, place the most frequent characters at even indices (0, 2, 4, ...)
   - When we reach the end, continue at odd indices (1, 3, 5, ...)
   - This ensures no two identical characters are adjacent

## Test Cases

| Input | Expected Output | Notes |
|-------|-----------------|-------|
| `"aab"` | `"aba"` | Basic case - simple rearrangement |
| `"aaab"` | `""` | Edge case - impossible to rearrange (3 a's, only 1 other char) |
| `"vvvlo"` | `"vlvov"` | Boundary case - multiple same characters |
| `"a"` | `"a"` | Edge case - single character |
| `""` | `""` | Edge case - empty string |
| `"aaabbc"` | `"ababac"` or similar | Interesting case - multiple characters with varying frequencies |

## Complexity Analysis
- **Time Complexity:** O(n²) where n is the length of the string (due to bubble sort for simplicity)
- **Space Complexity:** O(n) for storing frequency counts and result

## Notes
This is a classic greedy algorithm problem that tests understanding of:
- Character frequency counting
- Feasibility checking based on constraints
- Greedy placement strategy
