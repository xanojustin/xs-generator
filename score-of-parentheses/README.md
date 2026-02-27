# Score of Parentheses

## Problem

Given a balanced parentheses string `S`, compute the score of the string based on the following rules:

- `()` has score 1
- `AB` has score `A + B`, where A and B are balanced parentheses strings (concatenation)
- `(A)` has score `2 * A`, where A is a balanced parentheses string (nesting)

## Examples

- `()` = 1
- `(())` = 2
- `()()` = 2
- `(()(()))` = 6

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/score_of_parentheses.xs`):** Contains the solution logic using a stack-based approach

## Function Signature

- **Input:** 
  - `s` (text): A balanced parentheses string containing only `(` and `)`
- **Output:** 
  - (int): The score of the parentheses string

## Algorithm

The solution uses a stack-based approach:
1. Maintain a stack where each level represents the current score at that depth
2. When encountering `(`, push a new level (score 0) onto the stack
3. When encountering `)`:
   - If the current level score is 0, it means we saw `()`, so the score is 1
   - Otherwise, we saw `(A)`, so the score is `2 * A`
   - Pop the current level and add the score to the level below
4. Return the score at the bottom of the stack

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `"()"` | 1 | Simple pair |
| `"(())"` | 2 | Nested: 2 * 1 = 2 |
| `"()()"` | 2 | Concatenation: 1 + 1 = 2 |
| `"(()(()))"` | 6 | Complex: (2 * (1 + 2)) = 6 |
| `"((()))"` | 4 | Triple nested: 2 * (2 * 1) = 4 |
| `"()()()"` | 3 | Triple concatenation: 1 + 1 + 1 = 3 |

## Complexity

- **Time Complexity:** O(n), where n is the length of the string
- **Space Complexity:** O(n) for the stack in the worst case (deeply nested parentheses)
