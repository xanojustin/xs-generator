# Single Number II

## Problem

Given an integer array `nums` where every element appears **three times** except for one, which appears **exactly once**. Find the single element and return it.

You must implement a solution with a linear runtime complexity and use only constant extra space.

**Example 1:**
- Input: `nums = [2, 2, 3, 2]`
- Output: `3`

**Example 2:**
- Input: `nums = [0, 1, 0, 1, 0, 1, 99]`
- Output: `99`

**Example 3:**
- Input: `nums = [1, 1, 1, 2, 2, 2, 3, 4, 4, 4]`
- Output: `3`

## Structure

- **Run Job (`run.xs`):** Entry point that calls the solution function with test input
  - Uses `main = { name: "function_name", input: { ... } }` syntax
  - No `stack` block or `description` property in run.job
- **Function (`function/single_number_ii.xs`):** Contains the bit manipulation solution logic
  - Uses `input { }`, `stack { }`, and `response` blocks

## Function Signature

- **Input:**
  - `numbers` (int[]): Array of integers where every element appears exactly 3 times except one element that appears once
- **Output:**
  - Returns (int): The single number that appears only once

## Approach

This solution uses **bit manipulation**:

1. For each bit position (0-31 for 32-bit integers), count how many numbers have that bit set
2. If the count of set bits at a position is **not divisible by 3**, then the single number has that bit set
3. Reconstruct the result by setting bits where the count % 3 != 0

This works because:
- Numbers that appear 3 times contribute either 0 or 3 to each bit count
- The single number contributes 0 or 1 to each bit count
- So bit_count % 3 reveals which bits belong to the single number

## Test Cases

| Input | Expected Output | Description |
|-------|-----------------|-------------|
| `[2, 2, 3, 2]` | `3` | Basic case - single number in middle |
| `[5, 1, 1, 1]` | `5` | Single number at beginning |
| `[-1, -1, -1, 42]` | `42` | With negative numbers |
| `[0, 0, 0, 7]` | `7` | Edge case - minimum size with zero |
| `[1,1,1,2,2,2,3,4,4,4]` | `3` | Multiple different triplets |

## Constraints

- `1 <= nums.length <= 3 * 10^4`
- `-2^31 <= nums[i] <= 2^31 - 1`
- Each element in the array appears exactly **three times** except for one element which appears **once**

## Complexity Analysis

- **Time Complexity:** O(32 × n) = O(n), where n is the length of the array. We iterate through 32 bits for each of the n numbers.
- **Space Complexity:** O(1), using only a constant amount of extra space for counters.

## XanoScript Notes

- `run.job` uses a different syntax than `function` - it has `main = { name: "...", input: { ... } }` instead of `stack` and `response`
- Input parameters in functions must always use `$input.fieldname` - no shorthand exists for inputs
- Stack variables can use shorthand (`$varname` is the same as `$var.varname`)
- The `while` loop requires `each { }` block inside it for the loop body
