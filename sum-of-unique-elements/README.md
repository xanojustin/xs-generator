# Sum of Unique Elements

## Problem

You are given an integer array `nums`. The unique elements of an array are the elements that appear exactly once in the array.

Return the sum of all the unique elements of `nums`.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/sum_of_unique_elements.xs`):** Contains the solution logic

## Function Signature

- **Input:** 
  - `nums` (int[]): An array of integers
- **Output:** 
  - (int): The sum of all elements that appear exactly once in the array

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[1, 2, 3, 2]` | `4` | 1 and 3 appear once, 2 appears twice. Sum = 1 + 3 = 4 |
| `[1, 1, 1, 1, 1]` | `0` | No unique elements, all appear multiple times |
| `[1, 2, 3, 4, 5]` | `15` | All elements appear once. Sum = 1 + 2 + 3 + 4 + 5 = 15 |
| `[]` | `0` | Empty array returns 0 |
| `[42]` | `42` | Single element is unique |
| `[1, 2, 2, 3, 3, 3]` | `1` | Only 1 appears once |

## Algorithm

1. Build a frequency map (object) where keys are the numbers and values are their occurrence counts
2. Iterate through the original array and sum only those elements whose count is exactly 1
3. Return the sum

## Complexity

- **Time Complexity:** O(n) where n is the length of the array
- **Space Complexity:** O(k) where k is the number of unique values in the array
