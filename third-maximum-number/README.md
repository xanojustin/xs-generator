# Third Maximum Number

## Problem

Given an integer array `nums`, return the **third distinct maximum** number in this array. If the third maximum does not exist, return the **maximum** number.

### Examples
- **Example 1:** Input `[3, 2, 1]` → Output `1` (distinct: 3, 2, 1; third max is 1)
- **Example 2:** Input `[1, 2]` → Output `2` (only 2 distinct numbers, return max)
- **Example 3:** Input `[2, 2, 3, 1]` → Output `1` (distinct: 3, 2, 1; third max is 1)

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/third_maximum_number.xs`):** Contains the solution logic

## Function Signature

- **Input:** 
  - `nums` (int[]): An array of integers
- **Output:** 
  - Returns an `int` - the third distinct maximum number, or the maximum if fewer than 3 distinct values exist

## Algorithm

1. Extract distinct values from the input array (remove duplicates)
2. Sort distinct values in descending order using bubble sort
3. If there are 3 or more distinct values, return the 3rd one (index 2)
4. Otherwise, return the first (maximum) value

## Test Cases

| Input | Expected Output | Notes |
|-------|-----------------|-------|
| `[3, 2, 1]` | `1` | Basic case - 3 distinct values |
| `[1, 2]` | `2` | Edge case - only 2 distinct values, return max |
| `[2, 2, 3, 1]` | `1` | Duplicates in input, distinct are [3, 2, 1] |
| `[5, 5, 5]` | `5` | All same values, only 1 distinct |
| `[-1, -2, -3]` | `-3` | Negative numbers work correctly |

## Key Implementation Notes

- Uses `foreach` loops for iteration and duplicate detection
- Implements bubble sort manually since the built-in `sort` filter syntax was unclear
- Uses `var.update` for array element swapping during sorting
- Input validation ensures non-empty array
