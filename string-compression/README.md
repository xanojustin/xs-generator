# String Compression

## Problem

Implement a method to perform basic string compression using the counts of repeated characters. For example, the string "aabcccccaaa" would become "a2b1c5a3". If the compressed string would not become smaller than the original string, return the original string.

The compression works by counting consecutive repeated characters and outputting the character followed by its count.

## Function Signature

- **Input:** `input_string` (text) - The string to compress
- **Output:** `text` - The compressed string (or original if compression doesn't reduce size)

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `"aabcccccaaa"` | `"a2b1c5a3"` |
| `"abcdef"` | `"abcdef"` |
| `"aabbcc"` | `"aabbcc"` |
| `""` | `""` |
| `"a"` | `"a1"` |
| `"aa"` | `"aa"` |
| `"aaa"` | `"a3"` |
| `"aabbbbcccc"` | `"a2b4c4"` |

### Edge Cases Explained

1. **Empty string `""`**: Returns empty string - no characters to compress
2. **Single character `"a"`**: Returns `"a1"` - single character with count 1
3. **No compression benefit `"abcdef"`**: Returns original string since "a1b1c1d1e1f1" (12 chars) > "abcdef" (6 chars)
4. **Tie case `"aa"`**: Returns original string since "a2" (2 chars) == "aa" (2 chars)
5. **Compression benefit `"aaa"`**: Returns "a3" (2 chars) < "aaa" (3 chars)
