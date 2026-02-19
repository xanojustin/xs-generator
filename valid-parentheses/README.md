# Valid Parentheses

## Problem
Given a string containing only the characters `'('`, `')'`, `'['`, `']'`, `'{'`, and `'}'`, determine if the input string is valid.

An input string is valid if:
1. Open brackets must be closed by the same type of brackets
2. Open brackets must be closed in the correct order
3. Every close bracket has a corresponding open bracket of the same type

## Function Signature
- **Input:** `brackets` (text) - A string containing only bracket characters `()[]{}`
- **Output:** (bool) - `true` if the bracket sequence is valid, `false` otherwise

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `"()"` | `true` |
| `"()[]{}"` | `true` |
| `"(]"` | `false` |
| `"([)]"` | `false` |
| `"{[]}"` | `true` |
| `""` | `true` |
| `"("` | `false` |
| `"){"` | `false` |
| `"((()))"` | `true` |
| `"[]{}{}([{}])"` | `true` |

### Test Case Descriptions
- **Basic cases:** Simple matching pairs like `"()"` and `"()[]{}"`
- **Nested cases:** Properly nested brackets like `"{[]}"` and `"((()))"`
- **Mismatched types:** Wrong bracket types like `"(]"`
- **Wrong order:** Closing before opening like `"([)]"`
- **Edge cases:** Empty string (valid), single opening bracket (invalid), closing bracket without opening (invalid)
- **Complex nested:** Deep nesting like `"[]{}{}([{}])"`
