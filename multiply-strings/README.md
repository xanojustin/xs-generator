# Multiply Strings

## Problem

Given two non-negative integers `num1` and `num2` represented as strings, return the product of `num1` and `num2`, also represented as a string.

**Note:** You must not use any built-in BigInteger library or convert the inputs to integers directly. This simulates handling arbitrarily large numbers that exceed standard integer limits.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/multiply_strings.xs`):** Contains the solution logic implementing grade-school multiplication algorithm

## Function Signature

- **Input:**
  - `num1` (text): First non-negative integer as a string
  - `num2` (text): Second non-negative integer as a string
- **Output:** (text): The product of num1 and num2 as a string

## Algorithm

The solution uses the grade-school multiplication approach:
1. Handle the edge case where either number is "0"
2. Initialize a result array with zeros (size = len(num1) + len(num2))
3. Multiply each digit of num1 with each digit of num2
4. Add the product to the appropriate position in the result array with carry handling
5. Convert the result array to a string, skipping leading zeros

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| num1="2", num2="3" | "6" |
| num1="123", num2="456" | "56088" |
| num1="0", num2="12345" | "0" |
| num1="999", num2="999" | "998001" |
| num1="123456789", num2="987654321" | "121932631112635269" |

### Test Case Descriptions

1. **Single digits:** Simple multiplication of two single-digit numbers
2. **Basic case:** Standard 3-digit multiplication (123 × 456 = 56088)
3. **Edge case - zero:** Any number multiplied by zero equals zero
4. **Boundary case:** Numbers with repeated digits testing carry propagation
5. **Large numbers:** Big multiplication testing the algorithm's handling of many digits

## Complexity Analysis

- **Time Complexity:** O(m × n) where m and n are the lengths of num1 and num2
- **Space Complexity:** O(m + n) for the result array
