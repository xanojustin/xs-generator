# Sum of Square Numbers

## Problem
Given a non-negative integer `c`, determine whether there exist two integers `a` and `b` such that:

```
a² + b² = c
```

In other words, can `c` be expressed as the sum of two perfect squares?

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/sum_of_square_numbers.xs`):** Contains the solution logic using a two-pointer technique

## Function Signature
- **Input:** 
  - `c` (int): A non-negative integer to check
- **Output:** 
  - (bool): `true` if c can be expressed as a² + b² for some integers a and b, `false` otherwise

## Algorithm
The solution uses an efficient **two-pointer technique** with O(√c) time complexity:

1. Initialize pointer `a = 0` (starts from smallest possible value)
2. Initialize pointer `b = ⌊√c⌋` (starts from largest possible value)
3. While `a ≤ b`:
   - If `a² + b² == c`: return `true`
   - If `a² + b² < c`: increment `a` (need larger sum)
   - If `a² + b² > c`: decrement `b` (need smaller sum)
4. If loop ends without finding a match, return `false`

## Test Cases

| Input (c) | Expected Output | Explanation |
|-----------|-----------------|-------------|
| 5 | `true` | 5 = 1² + 2² = 1 + 4 |
| 3 | `false` | Cannot be expressed as sum of two squares |
| 0 | `true` | 0 = 0² + 0² |
| 1 | `true` | 1 = 0² + 1² = 0 + 1 |
| 2 | `true` | 2 = 1² + 1² = 1 + 1 |
| 4 | `true` | 4 = 0² + 2² = 0 + 4 |
| 25 | `true` | 25 = 0² + 5² = 3² + 4² |
| -1 | `false` | Negative numbers cannot be sum of squares |
| 2147483647 | `false` | Large prime number, no representation |

## Examples

### Example 1
- **Input:** `c = 5`
- **Output:** `true`
- **Explanation:** 1 × 1 + 2 × 2 = 5

### Example 2
- **Input:** `c = 3`
- **Output:** `false`
- **Explanation:** There are no integers a and b such that a² + b² = 3

### Example 3
- **Input:** `c = 0`
- **Output:** `true`
- **Explanation:** 0 × 0 + 0 × 0 = 0
