# Beautiful Arrangement

## Problem

Suppose you have `n` integers labeled 1 through n. A permutation of those n integers (perm) is considered a **beautiful arrangement** if for every `i` (1 <= i <= n), either of the following is true:

- `perm[i]` is divisible by `i`
- `i` is divisible by `perm[i]`

Given an integer `n`, return the number of the beautiful arrangements that you can construct.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs (n=1, n=2, n=3)
- **Function (`function/count-beautiful-arrangements.xs`):** Contains the backtracking solution logic

## Function Signature

- **Input:** 
  - `n` (int): The number of integers (1 to n) to arrange
- **Output:** 
  - (int): The count of beautiful arrangements possible

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| n = 1 | 1 | Only [1] is valid |
| n = 2 | 2 | [1,2] and [2,1] are both valid |
| n = 3 | 3 | [1,2,3], [2,1,3], [3,2,1] are valid |

### Detailed Explanations:

**n = 1:**
- Only arrangement: [1]
- Position 1: 1 is divisible by 1 ✓
- Result: 1 arrangement

**n = 2:**
- [1,2]: pos1: 1%1=0 ✓, pos2: 2%2=0 ✓
- [2,1]: pos1: 2%1=0 ✓, pos2: 2%1=0 ✓ (since 2 is divisible by 1)
- Result: 2 arrangements

**n = 3:**
- [1,2,3]: 1%1=0, 2%2=0, 3%3=0 ✓
- [2,1,3]: 2%1=0, 2%2=0, 3%3=0 ✓
- [3,2,1]: 3%1=0, 2%2=0, 3%3=0 ✓ (3 is divisible by position 3)
- Result: 3 arrangements
