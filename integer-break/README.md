# Integer Break

## Problem
Given an integer `n`, break it into the sum of **at least two** positive integers and maximize the product of those integers.

Return the maximum product you can get.

**Key Insight:** The optimal strategy involves breaking the number into as many 3s as possible. When a remainder of 1 remains, it's better to use 2×2 instead of 3×1.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test input (n = 10)
- **Function (`function/integer-break.xs`):** Contains the dynamic programming solution

## Function Signature
- **Input:** `n` (int) - Integer to break (n ≥ 2)
- **Output:** `int` - Maximum product obtainable by breaking n into at least two positive integers

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| 2 | 1 | 2 = 1 + 1, 1 × 1 = 1 |
| 3 | 2 | 3 = 1 + 2, 1 × 2 = 2 |
| 4 | 4 | 4 = 2 + 2, 2 × 2 = 4 |
| 10 | 36 | 10 = 3 + 3 + 4, 3 × 3 × 4 = 36 |
| 8 | 18 | 8 = 2 + 3 + 3, 2 × 3 × 3 = 18 |

## Algorithm
This solution uses dynamic programming:
1. `dp[i]` stores the maximum product obtainable from integer `i` (when we can choose NOT to break it)
2. For the original `n`, we must break it into at least two parts, so we try all possible breaks
3. Time Complexity: O(n²)
4. Space Complexity: O(n)
