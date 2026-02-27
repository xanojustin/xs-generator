# Single Number III

## Problem

Given an integer array `nums`, in which exactly two elements appear only once and all the other elements appear exactly twice. Find the two elements that appear only once. You can return the answer in any order.

You must write an algorithm that runs in linear runtime complexity and uses only constant extra space.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/single_number_iii.xs`):** Contains the solution logic using bit manipulation

## Function Signature

- **Input:** 
  - `nums` (int[]): An array of integers where exactly two elements appear once and all others appear twice
  
- **Output:** 
  - Returns an int[] containing the two numbers that appear only once

## Algorithm Explanation

The solution uses bitwise XOR properties:
1. XOR all numbers together - pairs cancel out (x ^ x = 0), leaving `a ^ b` where a and b are the two single numbers
2. Find any set bit in this result (we use the rightmost set bit via `x & (-x)`)
3. Partition all numbers into two groups based on whether they have this bit set
4. XOR each group separately - each group will contain one of the single numbers plus pairs that cancel out

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[1, 2, 1, 3, 2, 5]` | `[3, 5]` (order may vary) |
| `[-1, 0]` | `[-1, 0]` |
| `[0, 1]` | `[0, 1]` |

### Test Case Details

1. **Basic case:** `[1, 2, 1, 3, 2, 5]` → `[3, 5]`
   - 1 appears twice, 2 appears twice, 3 and 5 appear once

2. **Edge case with negative numbers:** `[-1, 0]` 
   - Both numbers appear once (minimum valid input)

3. **Edge case with zeros:** `[0, 1]`
   - Zero and another number, both appearing once

## XanoScript Techniques Used

- `math.bitwise.xor` for XOR operations
- `math.bitwise.and` for AND operations  
- `|bitwise_not` filter for bitwise NOT
- `|add` filter for arithmetic
- `foreach` loops with `each as` for iteration
- `var` and `var.update` for variable management
- `precondition` for input validation