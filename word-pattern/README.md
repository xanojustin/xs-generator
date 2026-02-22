# Word Pattern

## Problem
Given a `pattern` and a string `s`, determine if `s` follows the same pattern.

A full match means there is a **bijection** between a letter in `pattern` and a non-empty word in `s`. Specifically:
- Each character in `pattern` maps to exactly one word in `s`
- Each word in `s` maps to exactly one character in `pattern`
- The mapping must be consistent throughout

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/word_pattern.xs`):** Contains the solution logic

## Function Signature
- **Input:**
  - `pattern` (text): A string of characters representing the pattern (e.g., "abba")
  - `s` (text): A string of space-separated words (e.g., "dog cat cat dog")
- **Output:** (boolean) `true` if the string follows the pattern, `false` otherwise

## Test Cases

| Pattern | String | Expected Output |
|---------|--------|-----------------|
| "abba" | "dog cat cat dog" | true |
| "abba" | "dog cat cat fish" | false |
| "aaaa" | "dog cat cat dog" | false |
| "abba" | "dog dog dog dog" | false |
| "a" | "hello" | true |
| "abc" | "hello world" | false |
| "" | "" | true |
| "xyz" | "x y z" | true |

### Explanation of Key Cases
1. **Basic match:** "abba" → "dog cat cat dog" is true because 'a'↔"dog" and 'b'↔"cat" consistently
2. **Mismatched word:** "abba" → "dog cat cat fish" is false because 'a' would need to map to both "dog" and "fish"
3. **Mismatched pattern:** "aaaa" → "dog cat cat dog" is false because 'a' would need to map to different words
4. **Bijection violation:** "abba" → "dog dog dog dog" is false because both 'a' and 'b' would map to "dog"
