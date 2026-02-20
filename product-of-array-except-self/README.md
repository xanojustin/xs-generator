# Product of Array Except Self

## Problem

Given an integer array `numbers`, return an array `output` such that `output[i]` is equal to the product of all the elements of `numbers` except `numbers[i]`.

**Constraints:**
- You must solve this problem without using division
- The solution should run in O(n) time complexity
- Each element in the output is the product of all other elements

## Structure

- **Run Job (`run.xs`):** Calls the test harness function
- **Function (`function/product-of-array-except-self.xs`):** Contains the solution logic using a two-pass approach
- **Test Function (`function/product-of-array-except-self-test.xs`):** Test harness that runs multiple test cases

## Function Signature

- **Input:** 
  - `numbers` (int[]): An array of integers
  
- **Output:** 
  - `int[]`: An array where each element is the product of all input elements except the one at that index

## Algorithm Explanation

The solution uses a two-pass approach to achieve O(n) time complexity without division:

1. **Left Pass:** For each index `i`, calculate the product of all elements to the left of `i`
2. **Right Pass:** For each index `i`, multiply by the product of all elements to the right of `i`

This gives us the product of all elements except `numbers[i]` without using division.

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[1, 2, 3, 4]` | `[24, 12, 8, 6]` |
| `[1, 0, 3, 4]` | `[0, 12, 0, 0]` |
| `[5]` | `[1]` |
| `[2, 3]` | `[3, 2]` |
| `[]` | `[]` |
| `[-1, 1, 0, -3, 3]` | `[0, 0, 9, 0, 0]` |

### Test Case Explanations

1. **Basic case:** `[1, 2, 3, 4]` → `[24, 12, 8, 6]`
   - Index 0: 2 × 3 × 4 = 24
   - Index 1: 1 × 3 × 4 = 12
   - Index 2: 1 × 2 × 4 = 8
   - Index 3: 1 × 2 × 3 = 6

2. **With zero:** `[1, 0, 3, 4]` → `[0, 12, 0, 0]`
   - Any index with a zero in the other positions results in 0
   - Index 1 (the zero position) gets the product of all non-zero elements

3. **Single element:** `[5]` → `[1]`
   - With only one element, there are no other elements to multiply

4. **Two elements:** `[2, 3]` → `[3, 2]`
   - Each position gets the value of the other position

5. **Empty array:** `[]` → `[]`
   - Edge case: returns empty array

6. **Negative numbers with zero:** `[-1, 1, 0, -3, 3]` → `[0, 0, 9, 0, 0]`
   - Tests handling of negative numbers combined with zero