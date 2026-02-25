# Valid Perfect Square

## Problem
Given a positive integer `num`, write a function that returns `true` if `num` is a perfect square, and `false` otherwise.

A **perfect square** is an integer that is the square of an integer. For example:
- 1 = 1² is a perfect square
- 4 = 2² is a perfect square  
- 9 = 3² is a perfect square
- 14 is NOT a perfect square (no integer squared equals 14)

**Constraints:**
- Do NOT use the built-in `sqrt()` function or any library math functions
- Must use binary search for O(log n) time complexity

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/valid_perfect_square.xs`):** Contains the binary search solution logic

## Function Signature
- **Input:** 
  - `num` (int): A positive integer to check
- **Output:** 
  - `is_perfect_square` (bool): `true` if num is a perfect square, `false` otherwise

## Algorithm

### Binary Search Approach
1. Handle edge cases:
   - Numbers < 0 are never perfect squares
   - 0 and 1 are perfect squares
2. For num > 1, search for an integer `x` such that `x² = num`
3. Search range: 1 to `num / 2` (since for num > 4, √num < num/2)
4. Calculate mid point and compare `mid²` with `num`
5. If `mid² == num`, we found a perfect square
6. If `mid² < num`, search the right half
7. If `mid² > num`, search the left half
8. If search completes without finding, return false

### Time Complexity: O(log n)
### Space Complexity: O(1)

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| 1 | true | 1 = 1² |
| 4 | true | 4 = 2² |
| 9 | true | 9 = 3² |
| 16 | true | 16 = 4² |
| 25 | true | 25 = 5² |
| 2 | false | No integer squared equals 2 |
| 3 | false | No integer squared equals 3 |
| 14 | false | No integer squared equals 14 |
| 26 | false | No integer squared equals 26 |
| 0 | true | 0 = 0² |
| -4 | false | Negative numbers can't be perfect squares |
| 2147395600 | true | Large perfect square (46340²) |

## Why Binary Search?

Using `sqrt()` would be too easy! The binary search approach demonstrates:
- Understanding of search algorithms
- Avoiding integer overflow (we compare `mid²` with num rather than computing sqrt)
- O(log n) efficiency without library functions
