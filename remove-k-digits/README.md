# Remove K Digits

## Problem

Given a string `num` representing a non-negative integer, and an integer `k`, return the smallest possible integer after removing `k` digits from `num`.

### Example Walkthrough

For input `num = "1432219"`, `k = 3`:
1. We want to keep digits in increasing order to minimize the result
2. Process each digit:
   - '1' → stack: ["1"]
   - '4' → 4 > 1, push → stack: ["1", "4"]
   - '3' → 3 < 4, pop 4 (k=2), push 3 → stack: ["1", "3"]
   - '2' → 2 < 3, pop 3 (k=1), push 2 → stack: ["1", "2"]
   - '2' → 2 == 2, push → stack: ["1", "2", "2"]
   - '1' → 1 < 2, pop 2 (k=0), can't pop more → stack: ["1", "2", "1"]
   - '9' → push → stack: ["1", "2", "1", "9"]
3. Result: "1219"

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/remove_k_digits.xs`):** Contains the monotonic stack-based solution logic

## Function Signature

- **Input:**
  - `text num` - A string representing a non-negative integer (1 ≤ |num| ≤ 10⁵)
  - `int k` - The number of digits to remove (0 ≤ k ≤ |num|)
- **Output:** `text` - The smallest possible integer after removing k digits (as a string)

## Approach

This problem uses a **greedy algorithm with a monotonic stack**:
- We want the smallest number, so we prefer smaller digits on the left (most significant positions)
- When we see a digit smaller than the top of the stack, we remove the larger digit(s) if we still have removals left
- This ensures we're always making locally optimal choices that lead to a globally optimal result

**Time Complexity:** O(n) - single pass through the digits
**Space Complexity:** O(n) - for the stack

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `num="1432219"`, `k=3` | `"1219"` | Remove 4, 3, and one 2 to get "1219" |
| `num="10200"`, `k=1` | `"200"` | Remove the leading '1' to get smallest number |
| `num="10"`, `k=2` | `"0"` | Edge case: remove all digits, return "0" |
| `num="9"`, `k=1` | `"0"` | Edge case: single digit, remove it, return "0" |
| `num="112"`, `k=1` | `"11"` | Remove the trailing '2' to get "11" |
| `num="10001"`, `k=4` | `"0"` | Boundary case: after removing, only zeros remain |
| `num="123456"`, `k=3` | `"123"` | All increasing, remove last 3 digits |
| `num="654321"`, `k=2` | `"4321"` | All decreasing, remove first 2 digits |

## XanoScript Concepts Demonstrated

- String iteration using `foreach` with `|split:""`
- Monotonic stack operations (maintaining increasing/decreasing order)
- While loops for conditional popping
- String manipulation with `|ltrim` for removing leading zeros
- Array slice operations with negative indices
- Conditional early returns using `return` construct
