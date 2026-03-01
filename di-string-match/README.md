# DI String Match

## Problem

Given a string `s` consisting of characters `'D'` (decrease) and `'I'` (increase), construct a valid permutation of `[0, 1, 2, ..., n]` where `n` is the length of the string.

A valid permutation satisfies:
- If `s[i] == 'I'`, then `perm[i] < perm[i+1]` (increase)
- If `s[i] == 'D'`, then `perm[i] > perm[i+1]` (decrease)

Return any valid permutation (there may be multiple correct answers).

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test input `"IDID"`
- **Function (`function/di_string_match.xs`):** Contains the greedy algorithm solution

## Algorithm

The solution uses a greedy two-pointer approach:
1. Maintain two pointers: `low` starting at 0, `high` starting at n
2. For each 'I', place the current `low` value and increment `low`
3. For each 'D', place the current `high` value and decrement `high`
4. After processing all characters, append the remaining `low` value

This ensures that:
- 'I' always gets a smaller number that will increase
- 'D' always gets a larger number that will decrease

## Function Signature

- **Input:**
  - `pattern` (text): A string containing only 'I' and 'D' characters
- **Output:**
  - `int[]`: A valid permutation of `[0, 1, ..., n]` satisfying the DI pattern

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `"IDID"` | `[0, 4, 1, 3, 2]` | I: 0<4, D: 4>1, I: 1<3, D: 3>2 |
| `"III"` | `[0, 1, 2, 3]` | Strictly increasing sequence |
| `"DDI"` | `[3, 2, 0, 1]` | D: 3>2, D: 2>0, I: 0<1 |
| `"DDDD"` | `[4, 3, 2, 1, 0]` | Strictly decreasing sequence |
| `""` | `[0]` | Empty string - just return [0] |
| `"ID"` | `[0, 2, 1]` | Simple alternating pattern |

## Complexity

- **Time Complexity:** O(n) where n is the length of the pattern
- **Space Complexity:** O(n) for the result array
