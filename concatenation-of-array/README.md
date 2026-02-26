# Concatenation of Array

## Problem
Given an integer array `nums` of length `n`, create and return an array of length `2n` where the first `n` elements are the original array, and the next `n` elements are also the original array. In other words, the result should be the concatenation of two `nums` arrays.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/concatenation_of_array.xs`):** Contains the solution logic

## Function Signature
- **Input:** 
  - `nums` (int[]) - An array of integers to be concatenated with itself
- **Output:** 
  - Returns `int[]` - A new array containing the original array followed by itself (length 2n)

## Test Cases
| Input | Expected Output |
|-------|-----------------|
| `[1, 2, 1]` | `[1, 2, 1, 1, 2, 1]` |
| `[1, 3, 2, 1]` | `[1, 3, 2, 1, 1, 3, 2, 1]` |
| `[]` (empty) | `[]` |
| `[5]` (single element) | `[5, 5]` |
