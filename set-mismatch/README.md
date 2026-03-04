# Set Mismatch

## Problem
You have a set of integers from 1 to n. Due to a data error, one of the numbers in the set got duplicated to another number in the set, which results in repetition of one number and loss of another number.

Given an integer array `nums` representing the data status of this set after the error, find and return:
- The number that occurs twice (the duplicate)
- The number that is missing from the range 1 to n

Return these as an array: `[duplicate, missing]`

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/find_set_mismatch.xs`):** Contains the solution logic

## Function Signature
- **Input:** 
  - `nums` (int[]): Array of integers where one number is duplicated and another is missing from the range 1 to n
- **Output:** 
  - `[duplicate, missing]` (int[]): An array containing the duplicated number and the missing number

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[1, 2, 2, 4]` | `[2, 3]` |
| `[1, 1]` | `[1, 2]` |
| `[2, 2]` | `[2, 1]` |
| `[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10]` | `[10, 11]` |
