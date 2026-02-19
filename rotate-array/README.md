# Rotate Array

## Problem

Given an integer array `nums` and an integer `k`, rotate the array to the right by `k` steps.

For example, with `nums = [1,2,3,4,5]` and `k = 2`:
- Rotate 1 step to the right: `[5,1,2,3,4]`
- Rotate 2 steps to the right: `[4,5,1,2,3]`

So the final result is `[4,5,1,2,3]`.

This is a classic array manipulation problem that tests understanding of array operations and modulo arithmetic.

## Function Signature

- **Input:** 
  - `nums` (int[]) - The array of integers to rotate
  - `k` (int) - The number of steps to rotate to the right
- **Output:** `int[]` - The rotated array

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `nums = [1,2,3,4,5], k = 2` | `[4,5,1,2,3]` |
| `nums = [1,2,3,4,5,6,7], k = 3` | `[5,6,7,1,2,3,4]` |
| `nums = [-1,-100,3,99], k = 2` | `[3,99,-1,-100]` |
| `nums = [1,2,3], k = 0` | `[1,2,3]` |
| `nums = [1], k = 0` | `[1]` |
| `nums = [1,2,3], k = 3` | `[1,2,3]` |
| `nums = [1,2,3], k = 4` | `[3,1,2]` |
| `nums = [], k = 3` | `[]` |

### Edge Cases Explained

1. **`k = 0`**: No rotation needed, return the original array
2. **Single element `[1]`**: Rotating a single element always returns the same element
3. **`k = array length`**: Full rotation returns the original array (360° rotation)
4. **`k > array length`**: Use modulo - rotating by 4 on a 3-element array is same as rotating by 1
5. **Empty array `[]`**: Should handle gracefully and return empty array
