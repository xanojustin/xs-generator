# Sort Array By Parity II

## Problem

Given an array of integers `nums` (half of the integers are even, and half are odd), sort the array so that:
- Whenever `nums[i]` is odd, `i` is odd
- Whenever `nums[i]` is even, `i` is even

Return any answer array that satisfies this condition.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/sort_by_parity_ii.xs`):** Contains the solution logic

## Function Signature

- **Input:** 
  - `nums` (int[]): Array of integers with equal number of even and odd elements
- **Output:** 
  - (int[]): Rearranged array where even indices contain even numbers and odd indices contain odd numbers

## Approach

1. Separate the even and odd numbers into two separate arrays
2. Build the result array by alternating between even and odd arrays:
   - At even indices (0, 2, 4, ...), place elements from the even array
   - At odd indices (1, 3, 5, ...), place elements from the odd array

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[4, 2, 5, 7]` | `[4, 5, 2, 7]` or any valid arrangement like `[2, 5, 4, 7]` |
| `[2, 3]` | `[2, 3]` |
| `[1, 2]` | `[2, 1]` |
| `[4, 1, 2, 3]` | `[4, 1, 2, 3]` or `[2, 1, 4, 3]` or `[4, 3, 2, 1]` or `[2, 3, 4, 1]` |

### Test Case Explanations:

1. **Basic case:** `[4, 2, 5, 7]` - Even numbers (4, 2) go to indices 0, 2; Odd numbers (5, 7) go to indices 1, 3
2. **Single pair:** `[2, 3]` - Already correctly arranged
3. **Needs swap:** `[1, 2]` - Needs to swap to `[2, 1]` so index 0 has even number
4. **Multiple valid answers:** `[4, 1, 2, 3]` - Multiple valid configurations possible

## Constraints

- 2 <= nums.length <= 2 * 10^4
- nums.length is even
- Half of the integers in nums are even
- 0 <= nums[i] <= 1000

## Example Walkthrough

Input: `[4, 2, 5, 7]`

Step 1 - Separate:
- Even numbers: `[4, 2]`
- Odd numbers: `[5, 7]`

Step 2 - Build result:
- Index 0 (even): place `4` from even array
- Index 1 (odd): place `5` from odd array  
- Index 2 (even): place `2` from even array
- Index 3 (odd): place `7` from odd array

Output: `[4, 5, 2, 7]`
