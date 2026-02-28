# Subtract Product and Sum of Digits

## Problem

Given an integer `n`, return the difference between the **product of its digits** and the **sum of its digits**.

### Example
- Input: `n = 234`
- Product of digits: `2 * 3 * 4 = 24`
- Sum of digits: `2 + 3 + 4 = 9`
- Result: `24 - 9 = 15`

## Structure

- **Run Job (`run.xs`):** Entry point that calls the test function
- **Function (`function/subtract_product_sum.xs`):** Contains the solution logic
- **Test Function (`function/test_subtract_product_sum.xs`):** Runs multiple test cases

## Function Signature

### `subtract_product_sum`

- **Input:** 
  - `n` (int) - The input integer
- **Output:** 
  - `int` - The difference between the product of digits and sum of digits

### `test_subtract_product_sum`

- **Input:** None
- **Output:** 
  - `object` - Object containing all test case results

## Test Cases

| Input | Expected Output | Description |
|-------|-----------------|-------------|
| 234 | 15 | Basic 3-digit number |
| 5 | 0 | Single digit (edge case) |
| 101 | -2 | Contains zero (product becomes 0) |
| 9999 | 6525 | Large number with all 9s |
| 42 | 2 | Two-digit number |

### Explanation of Test Cases

1. **n = 234**: Product = 2×3×4 = 24, Sum = 2+3+4 = 9, Result = 24-9 = **15**
2. **n = 5**: Product = 5, Sum = 5, Result = 5-5 = **0** (single digit edge case)
3. **n = 101**: Product = 1×0×1 = 0, Sum = 1+0+1 = 2, Result = 0-2 = **-2** (zero handling)
4. **n = 9999**: Product = 9⁴ = 6561, Sum = 36, Result = 6561-36 = **6525** (boundary test)
5. **n = 42**: Product = 4×2 = 8, Sum = 4+2 = 6, Result = 8-6 = **2** (two-digit number)

## Algorithm

The solution uses the following approach:
1. Convert the integer to a string to iterate over each digit
2. Split the string into individual characters (digits)
3. Iterate through each digit character:
   - Convert it back to an integer
   - Multiply it into the running product
   - Add it to the running sum
4. Return the difference: product - sum
