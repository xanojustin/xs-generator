# Remove All Adjacent Duplicates In String

## Problem

You are given a string `s` consisting of lowercase English letters. A **duplicate removal** consists of choosing two **adjacent** and **equal** letters and removing them.

We repeatedly make duplicate removals on `s` until we no longer can. Return the final string after all such duplicate removals have been made. It is guaranteed the answer is unique.

### Example Walkthrough

For input `"abbaca"`:
1. Find "bb" and remove it → `"aaca"`
2. Find "aa" and remove it → `"cca"`
3. Find "cc" and remove it → `"ca"`
4. No more adjacent duplicates remain → return `"ca"`

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs and logs results
- **Function (`function/remove_adjacent_duplicates.xs`):** Contains the stack-based solution logic

## Function Signature

- **Input:** `text s` - A string of lowercase English letters (1 ≤ |s| ≤ 10⁵)
- **Output:** `text` - The final string after all duplicate removals

## Approach

This problem is elegantly solved using a **stack** data structure:
- Iterate through each character in the string
- For each character, check if it matches the top of the stack
  - If it matches, pop the stack (removing the adjacent duplicate pair)
  - If it doesn't match, push the character onto the stack
- The stack contains the final result (joined as a string)

**Time Complexity:** O(n) - single pass through the string
**Space Complexity:** O(n) - for the stack

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `"abbaca"` | `"ca"` | "bb" removed → "aaca", "aa" removed → "cca", "cc" removed → "ca" |
| `"azxxzy"` | `"ay"` | "xx" removed → "azzy", "zz" removed → "ay" |
| `""` | `""` | Edge case: empty string |
| `"a"` | `"a"` | Edge case: single character, no duplicates possible |
| `"aaaa"` | `""` | Boundary case: all characters pair up and cancel out |
| `"abba"` | `""` | Interesting case: nested pairs that resolve to empty |
| `"abc"` | `"abc"` | No adjacent duplicates to remove |

## XanoScript Concepts Demonstrated

- String iteration using `foreach` with `|split:""`
- Stack operations using arrays and filters (`|last`, `|slice`)
- String concatenation using `|join:""`
- Conditional logic within loops
- Array manipulation with `var` and `var.update`
