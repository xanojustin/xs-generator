# Balanced Brackets

## Problem
Given a string containing only brackets `()`, `{}`, and `[]`, determine if the brackets are balanced.

A string is considered balanced if:
- Every opening bracket has a corresponding closing bracket of the same type
- Opening brackets are closed in the correct order (properly nested)
- Every closing bracket matches the most recent unmatched opening bracket

### Examples
- `(){}[]` → `true` (simple pairs)
- `([{}])` → `true` (nested brackets)
- `(]` → `false` (mismatched types)
- `([)]` → `false` (incorrect order - not properly nested)
- `{[()]}` → `true` (complex nesting)
- `(((` → `false` (unclosed opening brackets)
- `)))` → `false` (closing without opening)

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/balanced_brackets.xs`):** Contains the solution logic using a stack-based algorithm

## Algorithm
The solution uses a **stack data structure**:
1. Iterate through each character in the string
2. If it's an opening bracket (`(`, `{`, `[`), push it onto the stack
3. If it's a closing bracket (`)`, `}`, `]`):
   - If the stack is empty, return `false` (no matching opening bracket)
   - Pop the top of the stack and check if it matches the closing bracket
   - If they don't match, return `false`
4. After processing all characters, return `true` if the stack is empty, `false` otherwise

## Function Signature
- **Input:** 
  - `brackets` (text): A string containing only bracket characters `()`, `{}`, `[]`
- **Output:** 
  - (bool): `true` if the brackets are balanced, `false` otherwise

## Test Cases

| Input | Expected Output | Description |
|-------|-----------------|-------------|
| `"(){}[]"` | `true` | Simple balanced pairs |
| `"([{}])"` | `true` | Nested brackets |
| `"{[()]}"` | `true` | Complex nesting |
| `"(]"` | `false` | Mismatched bracket types |
| `"([)]"` | `false` | Incorrect nesting order |
| `"((("` | `false` | Unclosed opening brackets |
| `")))"` | `false` | Closing without opening |
| `""` | `true` | Empty string (edge case) |
| `"()"` | `true` | Single pair (minimal valid) |
| `"{[("` | `false` | Multiple unclosed brackets |
