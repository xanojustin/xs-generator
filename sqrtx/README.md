# Square Root (sqrtx)

## Problem

Given a non-negative integer `x`, compute and return the square root of `x`.

Since the return type is an integer, the decimal digits are truncated, and only the integer part of the result is returned.

**Note:** You must not use any built-in exponent function or operator (e.g., `pow(x, 0.5)` or `x ** 0.5`).

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test input `x = 8`
- **Function (`function/sqrtx.xs`):** Contains the binary search implementation to find the integer square root

## Function Signature

- **Input:** `x` (int) — A non-negative integer (0 ≤ x ≤ 2³¹ - 1)
- **Output:** int — The integer part of the square root (floor value)

## Algorithm

This implementation uses **binary search** to efficiently find the square root:

1. Handle edge cases: if x < 2, return x (since √0 = 0 and √1 = 1)
2. Initialize search range: left = 1, right = x / 2
3. While left ≤ right:
   - Calculate mid = (left + right) / 2
   - If mid² == x, we found the exact square root
   - If mid² < x, mid might be the answer; store it and search right half
   - If mid² > x, search left half
4. Return the stored result

**Time Complexity:** O(log x)  
**Space Complexity:** O(1)

## Test Cases

| Input (x) | Expected Output | Explanation |
|-----------|-----------------|-------------|
| 4 | 2 | √4 = 2 (perfect square) |
| 8 | 2 | √8 ≈ 2.828..., truncated to 2 |
| 0 | 0 | Edge case: √0 = 0 |
| 1 | 1 | Edge case: √1 = 1 |
| 2147395600 | 46340 | Large number: √2147395600 = 46340 (boundary test) |
| 15 | 3 | √15 ≈ 3.87..., truncated to 3 |

## Example Walkthrough

For `x = 8`:
1. x >= 2, so we proceed with binary search
2. Initial range: left=1, right=4
3. Iteration 1: mid=2, 2²=4 < 8 → result=2, left=3
4. Iteration 2: mid=3, 3²=9 > 8 → right=2
5. Loop ends (left=3 > right=2)
6. Return result = 2