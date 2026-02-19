# Longest Common Prefix

## Problem

Write a function that finds the longest common prefix string amongst an array of strings.

If there is no common prefix, return an empty string `""`.

This is a classic string manipulation problem that tests your ability to work with arrays, string operations, and control flow.

## Function Signature

- **Input:** `strings` (text[]) - An array of strings to find the common prefix from
- **Output:** `text` - The longest common prefix string (empty string if no common prefix exists)

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `["flower", "flow", "flight"]` | `"fl"` |
| `["dog", "racecar", "car"]` | `""` |
| `["interspecies", "interstellar", "interstate"]` | `"inters"` |
| `["single"]` | `"single"` |
| `[]` | `""` |
| `["", "empty", "prefix"]` | `""` |
| `["abc"]` | `"abc"` |
| `["prefix", "prefix", "prefix"]` | `"prefix"` |

### Edge Cases Explained

1. **Empty array `[]`**: Returns empty string since there are no strings to compare
2. **Single element `["abc"]`**: Returns the string itself as it's the only prefix possible
3. **No common prefix `["dog", "racecar", "car"]`**: Returns empty string "" 
4. **Empty string in array `["", "empty", "prefix"]`**: Returns empty string since empty string has no prefix
5. **All identical `["prefix", "prefix", "prefix"]`**: Returns the full string as common prefix
6. **Long common prefix `["interspecies", "interstellar", "interstate"]`**: Tests with longer prefix matching

## Algorithm Approach

The solution uses a horizontal scanning approach:
1. Start with the first string as the initial prefix candidate
2. Compare this prefix with each subsequent string
3. Shorten the prefix character by character until it matches the beginning of the current string
4. If the prefix becomes empty, return immediately (no common prefix)
5. Return the final prefix after all comparisons

Time Complexity: O(S) where S is the sum of all characters in all strings
Space Complexity: O(1) - only using a few variables for tracking
