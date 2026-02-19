# First Unique Character

## Problem

Find the first non-repeating character in a given string.

Given a string, return the first character that appears exactly once in the string. If no such character exists (all characters repeat or the string is empty), return `null`.

This is a common string processing problem that tests:
- Character iteration and manipulation
- Frequency counting using a map/object
- Multiple passes through data

## Function Signature

- **Input:** `str` (text) - The input string to search
- **Output:** `text|null` - The first non-repeating character, or `null` if all characters repeat or string is empty

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `"leetcode"` | `"l"` |
| `"loveleetcode"` | `"v"` |
| `"aabb"` | `null` |
| `""` | `null` |
| `"a"` | `"a"` |
| `"aabbc"` | `"c"` |
| `"abcabc"` | `null` |
| `"stress"` | `"t"` |
| `"aabbccddeef"` | `"f"` |

### Edge Cases Explained

1. **Empty string `""`**: Returns `null` - no characters to process
2. **Single character `"a"`**: Returns `"a"` - a single character is by definition unique
3. **All duplicates `"aabb"`**: Returns `null` - every character appears more than once
4. **Last character unique `"aabbc"`**: Returns `"c"` - tests that we scan left-to-right and find the first unique
5. **Alternating repeats `"abcabc"`**: Returns `null` - every character appears twice
6. **First unique in middle `"stress"`**: Returns `"t"` - 's' appears twice, 't' is first unique at position 2
