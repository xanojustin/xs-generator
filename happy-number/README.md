# Happy Number

## Problem

A **happy number** is a number defined by the following process:

Starting with any positive integer, replace the number by the sum of the squares of its digits, and repeat the process until the number equals 1 (where it will stay), or it loops endlessly in a cycle which does not include 1.

Those numbers for which this process ends in 1 are **happy numbers**, while those that do not end in 1 are **unhappy numbers** (or sad numbers).

### Example: 19 is a happy number

1² + 9² = 82  
8² + 2² = 68  
6² + 8² = 100  
1² + 0² + 0² = 1 ✅

### Example: 2 is not a happy number

2² = 4  
4² = 16  
1² + 6² = 37  
3² + 7² = 58  
5² + 8² = 89  
8² + 9² = 145  
... enters a cycle that never reaches 1 ❌

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/is_happy_number.xs`):** Contains the solution logic

## Function Signature

- **Input:** `n` (int) — The positive integer to check
- **Output:** (bool) — `true` if the number is happy, `false` otherwise

## Algorithm

The solution uses a **cycle detection** approach with a set to track seen numbers:

1. If `n` ≤ 0, return `false` (only positive integers are valid)
2. Initialize an empty set to track seen numbers
3. While `current` ≠ 1 and `current` is not in the seen set:
   - Add `current` to the seen set
   - Calculate sum of squares of digits of `current`
   - Update `current` to this sum
4. Return `true` if `current` == 1, `false` otherwise (cycle detected)

**Time Complexity:** O(log n) — The number of digits grows logarithmically  
**Space Complexity:** O(log n) — To store the set of seen numbers

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| 19 | `true` | 19 → 82 → 68 → 100 → 1 (classic happy number) |
| 7 | `true` | 7 → 49 → 97 → 130 → 10 → 1 |
| 1 | `true` | Already 1, trivially happy |
| 2 | `false` | Enters cycle: 4 → 16 → 37 → 58 → 89 → 145 → 42 → 20 → 4 |
| 0 | `false` | Not a positive integer |
| -5 | `false` | Negative numbers are not valid |
| 100 | `true` | 1² + 0² + 0² = 1 |
| 999999 | `false` | Large unhappy number |

## Notes

- The cycle for unhappy numbers always includes 4 (this is a known mathematical property)
- All single-digit happy numbers: 1, 7
- This problem demonstrates cycle detection, a common pattern in algorithm problems
