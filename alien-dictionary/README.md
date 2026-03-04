# Alien Dictionary

## Problem
Given a list of words sorted lexicographically in an alien language, determine the order of characters in that language.

There is a new alien language that uses the English alphabet. However, the order among the letters is unknown to you.

You are given a list of strings `words` from the alien language's dictionary, where the strings in `words` are sorted lexicographically by the rules of this new language.

Return a string of the unique letters in the new alien language sorted in lexicographically increasing order by the new language's rules. If there is no solution, return an empty string. If there are multiple solutions, return any of them.

A string `a` is lexicographically smaller than a string `b` if either:
- At the first position where they differ, the character in `a` comes before the character in `b` in the alien language
- The first `min(a.length, b.length)` characters are the same, but `a.length < b.length`

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/alien_dictionary.xs`):** Contains the solution logic using topological sort (Kahn's algorithm)

## Function Signature
- **Input:**
  - `words` (text[]): An array of strings sorted lexicographically according to the alien language rules
- **Output:** 
  - (text): A string containing the unique characters in lexicographic order, or empty string if no valid order exists

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `["wrt", "wrf", "er", "ett", "rftt"]` | `"wertf"` |
| `["z", "x"]` | `"zx"` |
| `["z", "x", "z"]` | `""` (invalid - cycle detected) |
| `[]` | `""` (empty input) |
| `["abc"]` | `"abc"` (single word - return unique chars in order) |
| `["a", "b", "c"]` | `"abc"` (already sorted) |

### Explanation of Test Cases

1. **Basic case:** `["wrt", "wrf", "er", "ett", "rftt"]`
   - From "wrt" vs "wrf": `t` comes before `f`
   - From "wrt" vs "er": `w` comes before `e`
   - From "er" vs "ett": `r` comes before `t`
   - From "ett" vs "rftt": `e` comes before `r`
   - Chain: w → e → r → t → f, result: "wertf"

2. **Simple two-letter case:** `["z", "x"]`
   - `z` comes before `x`, result: "zx"

3. **Invalid/cycle case:** `["z", "x", "z"]`
   - From "z" vs "x": `z` before `x`
   - From "x" vs "z": `x` before `z`
   - This creates a cycle, so return empty string

4. **Edge case - empty input:** `[]`
   - Return empty string

5. **Edge case - single word:** `["abc"]`
   - Return unique characters in order of first appearance: "abc"

6. **Already sorted:** `["a", "b", "c"]`
   - Result: "abc"
