# Running Sum of 1D Array

## Problem
Given an array of integers `nums`, return the **running sum** (also known as prefix sum) of the array.

The running sum at index `i` is the sum of all elements from index `0` to index `i` (inclusive).

### Example
- Input: `[1, 2, 3, 4]`
- Output: `[1, 3, 6, 10]`
- Explanation: 
  - Index 0: 1 = 1
  - Index 1: 1 + 2 = 3
  - Index 2: 1 + 2 + 3 = 6
  - Index 3: 1 + 2 + 3 + 4 = 10

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/running_sum.xs`):** Contains the solution logic

## Function Signature
- **Input:** `nums` - An array of integers (`int[]`)
- **Output:** An array of integers where each element at index `i` is the sum of elements `nums[0]` through `nums[i]`

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[1, 2, 3, 4]` | `[1, 3, 6, 10]` |
| `[1, 1, 1, 1, 1]` | `[1, 2, 3, 4, 5]` |
| `[]` | `[]` |
| `[5]` | `[5]` |
| `[-1, 2, -3, 4]` | `[-1, 1, -2, 2]` |

### Test Case Descriptions
1. **Basic case:** Standard array with positive integers
2. **Uniform values:** All elements are the same
3. **Edge case (empty):** Empty array returns empty array
4. **Edge case (single element):** Single element array returns itself
5. **Mixed signs:** Array with both positive and negative integers
