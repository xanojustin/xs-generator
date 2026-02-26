# Reverse String II

## Problem
Given a string `s` and an integer `k`, reverse the first `k` characters for every `2k` characters counting from the start of the string.

If there are fewer than `k` characters left, reverse all of them.
If there are less than `2k` but greater than or equal to `k` characters, reverse the first `k` characters and leave the rest as original.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/reverse_string_ii.xs`):** Contains the solution logic

## Function Signature
- **Input:**
  - `s` (text): The input string to process
  - `k` (int): The number of characters to reverse in each chunk (must be >= 1)
- **Output:** (text) The processed string with reversed chunks

## Test Cases

| Input (s, k) | Expected Output |
|--------------|-----------------|
| `("abcdefg", 2)` | `"bacdfeg"` |
| `("abcd", 2)` | `"bacd"` |
| `("a", 1)` | `"a"` |
| `("abcdefgh", 3)` | `"cbadefhg"` |
| `("", 2)` | `""` |

### Explanation of Test Cases

1. **Basic case:** `"abcdefg"` with `k=2`
   - Chunk 1: reverse `"ab"` → `"ba"`, keep `"cd"` → `"bacd"`
   - Chunk 2: reverse `"ef"` → `"fe"`, keep `"g"` → `"feg"`
   - Result: `"bacdfeg"`

2. **Exact 2k length:** `"abcd"` with `k=2`
   - Reverse `"ab"` → `"ba"`, no remaining characters after `"cd"` to keep as-is
   - Result: `"bacd"`

3. **Single character:** `"a"` with `k=1`
   - Just reverse the single character
   - Result: `"a"`

4. **Larger k:** `"abcdefgh"` with `k=3`
   - Reverse `"abc"` → `"cba"`, keep `"def"` → `"cbadef"`
   - Reverse `"gh"` (only 2 left, < k, so reverse all) → `"hg"`
   - Result: `"cbadefhg"`

5. **Empty string:** `""` with `k=2`
   - Nothing to reverse
   - Result: `""`
