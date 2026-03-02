# Minimum Remove to Make Valid Parentheses

## Problem

Given a string `s` of `'('`, `')'` and lowercase English characters, remove the minimum number of parentheses (`'('` or `')'`, in any positions) so that the resulting parentheses string is valid and return any valid result.

Formally, a parentheses string is valid if and only if:
- It is the empty string, contains only lowercase characters, or
- It can be written as `AB` (A concatenated with B), where A and B are valid strings, or
- It can be written as `(A)`, where A is a valid string.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test input `"lee(t(c)o)de)"`
- **Function (`function/minimum_remove_to_make_valid_parentheses.xs`):** Contains the solution logic using a stack-based approach

## Function Signature

- **Input:** 
  - `s` (text): A string containing parentheses and lowercase English letters
- **Output:** 
  - (text): A valid parentheses string with minimum removals

## Algorithm

1. Convert the string to a character array
2. Use a stack to track indices of opening parentheses `'('`
3. Iterate through the string:
   - When encountering `'('`, push its index onto the stack
   - When encountering `')'`:
     - If stack is not empty, pop (match found)
     - If stack is empty, mark this `')'` for removal (unmatched)
4. After iteration, any remaining indices in the stack are unmatched `'('` - mark them for removal
5. Build the result string by including only non-removed characters

## Test Cases

| Input | Expected Output | Notes |
|-------|-----------------|-------|
| `"lee(t(c)o)de)"` | `"lee(t(c)o)de"` or `"lee(t(c)ode)"` | Basic case - remove one `)` |
| `"a)b(c)d"` | `"ab(c)d"` | Remove leading `)` |
| `"(("` | `""` | Edge case - only unmatched opening |
| `"))"` | `""` | Edge case - only unmatched closing |
| `"(a(b(c)d)"` | `"a(b(c)d)"` or `"(ab(c)d)"` | Remove one `(` |
| `""` | `""` | Edge case - empty string |

## Complexity Analysis

- **Time Complexity:** O(n) where n is the length of the string - we iterate through the string a constant number of times
- **Space Complexity:** O(n) for the stack and the character array
