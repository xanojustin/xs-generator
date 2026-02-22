# Add Strings

## Problem
Given two non-negative integers represented as strings, return their sum as a string.

This problem demonstrates how to handle arbitrarily large numbers that exceed standard integer limits. Instead of converting the entire string to an integer (which could overflow), we use the elementary school addition algorithm - adding digit by digit from right to left with carry propagation.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/add_strings.xs`):** Contains the solution logic

## Function Signature
- **Input:** 
  - `num1` (text): First non-negative integer as a string
  - `num2` (text): Second non-negative integer as a string
- **Output:** 
  - (text): The sum of num1 and num2 as a string

## Test Cases

| Input num1 | Input num2 | Expected Output |
|------------|------------|-----------------|
| "123" | "456" | "579" |
| "11" | "123" | "134" |
| "0" | "0" | "0" |
| "999" | "1" | "1000" |
| "1" | "999" | "1000" |
| "" | "" | "0" |
| "99999999999999999999" | "1" | "100000000000000000000" |

### Test Case Explanations

1. **Basic case ("123" + "456")**: Simple addition with same-length numbers
2. **Unequal lengths ("11" + "123")**: Numbers with different digit counts
3. **Both zero ("0" + "0")**: Edge case with all zeros
4. **Carry propagation ("999" + "1")**: Tests multiple carry operations
5. **Reversed carry ("1" + "999")**: Carry propagation when first number is shorter
6. **Empty strings ("" + "")**: Edge case with empty inputs
7. **Very large numbers**: Demonstrates the value of string addition for big integers
