# Isomorphic Strings

## Problem

Given two strings `s` and `t`, determine if they are **isomorphic**.

Two strings are isomorphic if the characters in `s` can be replaced to get `t`. All occurrences of a character must be replaced with another character while preserving the order of characters. No two characters may map to the same character, but a character may map to itself.

### Examples

- **Example 1:** `s = "egg"`, `t = "add"` → **true**
  - Mapping: e→a, g→d

- **Example 2:** `s = "foo"`, `t = "bar"` → **false**
  - 'o' would need to map to both 'a' and 'r'

- **Example 3:** `s = "paper"`, `t = "title"` → **true**
  - Mapping: p→t, a→i, p→t, e→l, r→e

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/isomorphic_strings.xs`):** Contains the solution logic using bidirectional character mapping

## Function Signature

- **Input:**
  - `s` (text): First string to compare
  - `t` (text): Second string to compare

- **Output:**
  - (bool): `true` if the strings are isomorphic, `false` otherwise

## Algorithm

1. **Length Check:** If strings have different lengths, they cannot be isomorphic
2. **Bidirectional Mapping:** Maintain two hash maps:
   - `s_to_t`: Maps characters from `s` to `t`
   - `t_to_s`: Maps characters from `t` to `s` (prevents two chars mapping to same char)
3. **Validation:** For each character pair:
   - If `s_char` already has a mapping, it must match `t_char`
   - If `t_char` already has a mapping, it must match `s_char`
   - Otherwise, create bidirectional mapping

## Test Cases

| s | t | Expected Output | Explanation |
|---|---|-----------------|-------------|
| `"egg"` | `"add"` | `true` | e→a, g→d (valid mapping) |
| `"foo"` | `"bar"` | `false` | o cannot map to both a and r |
| `"paper"` | `"title"` | `true` | p↔t, a↔i, e↔l, r↔e |
| `"ab"` | `"aa"` | `false` | a,b both map to a (invalid) |
| `""` | `""` | `true` | Empty strings are isomorphic |
| `"a"` | `"a"` | `true` | Single same character |
| `"ab"` | `"cd"` | `true` | One-to-one mapping |
| `"aba"` | `"baa"` | `false` | a→b but then a→a |

## Complexity Analysis

- **Time Complexity:** O(n) where n is the length of the strings
- **Space Complexity:** O(k) where k is the size of the character set
