# Valid Triangle Number

## Problem

Given an array of integers, return the number of triplets that can form valid triangles.

A valid triangle must satisfy the **triangle inequality theorem**: the sum of any two sides must be greater than the third side. For three sides a, b, c where a ≤ b ≤ c, we only need to check: `a + b > c`.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/valid_triangle_number.xs`):** Contains the solution logic using two-pointer technique

## Function Signature

- **Input:** 
  - `sides` (int[]): An array of integers representing potential triangle side lengths
- **Output:** 
  - `int`: The count of valid triangles that can be formed

## Algorithm

The solution uses a **two-pointer technique** after sorting:

1. **Sort** the array in ascending order
2. **Fix** the largest side `c` (iterate from end to beginning)
3. **Use two pointers** (`left` at start, `right` just before `c`) to find pairs where `a + b > c`
4. **Count** valid triplets efficiently:
   - If `sides[left] + sides[right] > sides[c]`: All pairs between `left` and `right` are valid, add `(right - left)` to count
   - Otherwise: Sum is too small, increment `left` to get a larger sum

**Time Complexity:** O(n²) - Sorting is O(n log n), then two-pointer scan is O(n²)  
**Space Complexity:** O(1) - Only using a few variables

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[2, 2, 3, 4]` | `3` | Triplets: (2,3,4), (2,3,4), (2,2,3) |
| `[4, 2, 3, 4]` | `4` | Triplets: (2,3,4)x2, (3,4,4), (2,4,4) |
| `[1, 1, 1]` | `1` | One equilateral triangle |
| `[1, 2, 3]` | `0` | 1+2 = 3, not > 3, so no valid triangle |
| `[5, 5, 5, 5]` | `4` | C(4,3) = 4 combinations of 3 from 4 |
| `[1]` | `0` | Edge case: not enough sides |
| `[1, 2]` | `0` | Edge case: not enough sides |
| `[]` | `0` | Edge case: empty array |

## Example Walkthrough

Input: `[2, 2, 3, 4]`

Sorted: `[2, 2, 3, 4]`

1. Fix `c = 4` (index 3): Need `a + b > 4`
   - left=0 (2), right=2 (3): 2+3=5 > 4 ✓ → 2 valid pairs: (2,3,4), (2,3,4) → count=2
   - right becomes 1, 2+2=4 ≯ 4, left becomes 1, left=right, done

2. Fix `c = 3` (index 2): Need `a + b > 3`
   - left=0 (2), right=1 (2): 2+2=4 > 3 ✓ → 1 valid pair: (2,2,3) → count=3
   - right becomes 0, left=right, done

3. Fix `c = 2` (index 1): Need at least 2 elements before, only have 1, skip

**Total: 3 valid triangles**
