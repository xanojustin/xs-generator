# Backspace String Compare

## Problem
Given two strings `s` and `t`, return `true` if they are equal when both are typed into empty text editors. `'#'` means a backspace character.

Note that after backspacing an empty text, the text will continue empty.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/backspace_compare.xs`):** Contains the solution logic

## Function Signature
- **Input:**
  - `s` (text): First string containing characters and '#' backspace characters
  - `t` (text): Second string containing characters and '#' backspace characters
- **Output:**
  - (bool): `true` if both strings are equal after processing backspaces, `false` otherwise

## Test Cases

| s | t | Expected Output | Explanation |
|---|---|-----------------|-------------|
| `"ab#c"` | `"ad#c"` | `true` | Both become `"ac"` |
| `"ab##"` | `"c#d#"` | `true` | Both become `""` (empty) |
| `"a##c"` | `"#a#c"` | `true` | Both become `"c"` |
| `"a#c"` | `"b"` | `false` | `"c"` != `"b"` |
| `""` | `""` | `true` | Both are empty |
| `"abc"` | `"abc"` | `true` | No backspaces, strings are equal |
| `"########"` | `""` | `true` | All backspaces result in empty string |

## Approach
The solution uses a **stack-based approach** for each string:
1. Iterate through each character in the string
2. If the character is a regular character (not '#'), push it onto the stack
3. If the character is '#', pop the last character from the stack (if not empty)
4. After processing both strings, compare the resulting stacks element by element

## Complexity
- **Time Complexity:** O(n + m) where n and m are the lengths of the two strings
- **Space Complexity:** O(n + m) for storing the processed strings
