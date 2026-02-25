# Height Checker

## Problem
A school is trying to take an annual photo of all the students. The students are asked to stand in a single file line in non-decreasing order by height.

Given an array `heights` representing the current order that the students are standing in, return the number of students that are not standing in the correct positions.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/height_checker.xs`):** Contains the solution logic

## Function Signature
- **Input:** `int[] heights` - An array of integers representing student heights in their current standing order
- **Output:** `int` - The count of students not in their correct position when the array is sorted in non-decreasing order

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[1, 1, 4, 2, 1, 3]` | `3` | Sorted: `[1, 1, 1, 2, 3, 4]`; mismatches at indices 2, 4, 5 |
| `[5, 1, 2, 3, 4]` | `5` | All students need to move (sorted: `[1, 2, 3, 4, 5]`) |
| `[1, 2, 3, 4, 5]` | `0` | Already in correct order |
| `[1, 1, 1, 1]` | `0` | All same height, already correct |
| `[1]` | `0` | Single element, trivially correct |
| `[]` | `0` | Empty array, no students to check |

## Algorithm
1. Create a sorted copy of the input array
2. Iterate through both arrays simultaneously
3. Count positions where the original and sorted arrays differ
4. Return the count
