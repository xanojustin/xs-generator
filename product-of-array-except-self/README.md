# Product of Array Except Self

## Problem

Given an integer array `nums`, return an array `answer` such that `answer[i]` is equal to the product of all the elements of `nums` except `nums[i]`.

The product of any prefix or suffix of `nums` is guaranteed to fit in a 32-bit integer.

**Constraint:** You must write an algorithm that runs in O(n) time and without using the division operation.

## Function Signature

- **Input:** `int[] nums` - An array of integers (minimum 2 elements)
- **Output:** `int[]` - An array where each element is the product of all elements in the input except the one at the same index

## Approach

The solution uses a two-pass algorithm to achieve O(n) time complexity:

1. **Left-to-right pass:** For each position `i`, calculate the product of all elements to the left of `i` and store it in `result[i]`
2. **Right-to-left pass:** For each position `i`, multiply `result[i]` by the product of all elements to the right of `i`

This approach uses O(1) extra space (excluding the output array) and O(n) time.

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[1, 2, 3, 4]` | `[24, 12, 8, 6]` | 2×3×4=24, 1×3×4=12, 1×2×4=8, 1×2×3=6 |
| `[2, 3, 4, 5]` | `[60, 40, 30, 24]` | 3×4×5=60, 2×4×5=40, 2×3×5=30, 2×3×4=24 |
| `[-1, 1, 0, -3, 3]` | `[0, 0, 9, 0, 0]` | Products involving the zero result in 0 except position 2 |
| `[1, 1]` | `[1, 1]` | Edge case: minimum length array |
| `[5, 2]` | `[2, 5]` | Simple two-element case |
| `[1, 0]` | `[0, 1]` | Edge case: one zero in array |

## Complexity Analysis

- **Time Complexity:** O(n) - Two passes through the array
- **Space Complexity:** O(1) auxiliary space (output array doesn't count towards space complexity)

## Example Walkthrough

Input: `[1, 2, 3, 4]`

**After left pass:**
- `result[0] = 1` (no elements to the left)
- `result[1] = 1` (product of elements left of index 1: 1)
- `result[2] = 2` (product of elements left of index 2: 1×2)
- `result[3] = 6` (product of elements left of index 3: 1×2×3)
- Result: `[1, 1, 2, 6]`

**After right pass:**
- `result[3] = 6 × 1 = 6` (no elements to the right)
- `result[2] = 2 × 4 = 8` (product of elements right of index 2: 4)
- `result[1] = 1 × 12 = 12` (product of elements right of index 1: 3×4)
- `result[0] = 1 × 24 = 24` (product of elements right of index 0: 2×3×4)
- Final result: `[24, 12, 8, 6]`
