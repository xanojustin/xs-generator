# Add to Array-Form of Integer

## Problem

The array-form of an integer `num` is an array representing its digits in left to right order.

For example, for `num = 1321`, the array form is `[1,3,2,1]`.

Given the array-form integer `num` and an integer `k`, return the array-form of the sum `num + k`.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/add_to_array_form.xs`):** Contains the solution logic

## Function Signature

- **Input:**
  - `num` (int[]): Array representing the digits of the number in left-to-right order
  - `k` (int): Integer to add to the number represented by `num`
- **Output:** (int[]): Array representing the sum of num + k

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| num = [1,2,0,0], k = 34 | [1,2,3,4] |
| num = [2,7,4], k = 181 | [4,5,5] |
| num = [2,1,5], k = 806 | [1,0,2,1] |
| num = [9,9,9], k = 1 | [1,0,0,0] |
| num = [0], k = 0 | [0] |
| num = [], k = 5 | [5] |

## Explanation

### Example 1:
- Input: `num = [1,2,0,0]`, `k = 34`
- The number represented is 1200
- 1200 + 34 = 1234
- Output: `[1,2,3,4]`

### Example 2:
- Input: `num = [2,7,4]`, `k = 181`
- The number represented is 274
- 274 + 181 = 455
- Output: `[4,5,5]`

### Example 3 (Edge Case - Carry Propagation):
- Input: `num = [9,9,9]`, `k = 1`
- The number represented is 999
- 999 + 1 = 1000
- Output: `[1,0,0,0]`
- Shows carry propagation through all digits and adding a new most significant digit
