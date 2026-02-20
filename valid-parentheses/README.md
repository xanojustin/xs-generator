# Valid Parentheses

## Problem
Given a string `s` containing just the characters `'('`, `')'`, `'{'`, `'}'`, `'['` and `']'`, determine if the input string is valid.

An input string is valid if:
1. Open brackets must be closed by the same type of brackets.
2. Open brackets must be closed in the correct order.
3. Every close bracket has a corresponding open bracket of the same type.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/valid_parentheses.xs`):** Contains the solution logic using a stack

## Function Signature
- **Input:** `s` (text) - A string containing only bracket characters: `()`, `{}`, `[]`
- **Output:** (bool) - `true` if the string is valid, `false` otherwise

## Test Cases

| Input | Expected Output | Description |
|-------|-----------------|-------------|
| `"()"` | `true` | Simple matching pair |
| `"()[]{}"` | `true` | Multiple matching pairs |
| `"(]"` | `false` | Mismatched brackets |
| `"([)]"` | `false` | Wrong order (not nested properly) |
| `"{[]}"` | `true` | Properly nested brackets |
| `""` | `true` | Empty string (valid by definition) |
| `"(("` | `false` | Unclosed opening brackets |
| `"))"` | `false` | Unmatched closing brackets |

## Algorithm Explanation

The solution uses a **stack** data structure:

1. Iterate through each character in the string
2. If the character is an opening bracket (`(`, `{`, `[`), push it onto the stack
3. If the character is a closing bracket (`)`, `}`, `]`):
   - If the stack is empty, return `false` (no matching opening bracket)
   - Pop the top of the stack and check if it matches the expected opening bracket
   - If it doesn't match, return `false`
4. After processing all characters, the string is valid only if the stack is empty

**Time Complexity:** O(n) where n is the length of the string  
**Space Complexity:** O(n) for the stack in the worst case

## Example Walkthrough

Input: `"{[]}"`

1. `{` → push to stack → stack: `["{"]`
2. `[` → push to stack → stack: `["{", "["]`
3. `]` → closing bracket, pop `[`, matches! → stack: `["{"]`
4. `}` → closing bracket, pop `{`, matches! → stack: `[]`
5. Stack is empty → return `true` ✓
