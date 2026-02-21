# Generate Parentheses

## Problem
Given `n` pairs of parentheses, write a function to generate all combinations of well-formed parentheses.

A well-formed (valid) parentheses string is one where:
- Every opening parenthesis `(` has a corresponding closing parenthesis `)`
- Closing parentheses are never placed before their matching opening parenthesis
- At any point in the string, the number of closing parentheses does not exceed the number of opening parentheses

This is a classic **backtracking** problem that demonstrates recursive thinking and constraint-based generation.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/generate_parentheses.xs`):** Contains the backtracking solution logic

## Function Signature
- **Input:** `n` (int) — Number of pairs of parentheses
- **Output:** `text[]` — Array of all valid parentheses combinations

## Test Cases

| Input (n) | Expected Output |
|-----------|-----------------|
| 1 | `["()"]` |
| 2 | `["(())", "()()"]` |
| 3 | `["((()))", "(()())", "(())()", "()(())", "()()()"]` |
| 0 | `[]` |

### Explanation of Test Cases

**n = 1:** Only one valid combination with a single pair of parentheses.

**n = 2:** Two valid combinations:
- `(())` — nested parentheses
- `()()` — sequential parentheses

**n = 3:** Five valid combinations:
- `((()))` — fully nested
- `(()())` — nested with one pair inside
- `(())()` — two nested pairs followed by one
- `()(())` — one pair followed by nested pair
- `()()()` — all sequential

**n = 0:** Edge case — no parentheses means empty result.

## Algorithm

The solution uses an iterative approach (simulating recursion with a manual stack) based on these rules:
1. Start with an empty string and zero open/close counts
2. At each step, we can add `(` if we haven't used all `n` opening parentheses
3. We can add `)` if we have more opening than closing parentheses used
4. When both counts reach `n`, we have a valid combination
5. Continue until all possibilities are exhausted

This ensures we only generate well-formed combinations by maintaining the invariant that `close_count ≤ open_count` at every step.
