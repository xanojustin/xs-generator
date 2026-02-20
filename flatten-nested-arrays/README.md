# Flatten Nested Arrays

## Problem
Write a function that takes a nested array (an array that may contain other arrays at any depth) and returns a single flat array with all values in the same order they appeared in the original structure.

For example:
- Input: `[1, [2, 3], [[4, 5], 6], [7, [8, [9]]]]`
- Output: `[1, 2, 3, 4, 5, 6, 7, 8, 9]`

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/flatten_array.xs`):** Contains the solution logic

## Function Signature
- **Input:** `nested_array` (json) - An array that may contain nested arrays of arbitrary depth
- **Output:** (json[]) - A flat array containing all non-array elements in order

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[1, [2, 3], [[4, 5], 6], [7, [8, [9]]]]` | `[1, 2, 3, 4, 5, 6, 7, 8, 9]` |
| `[1, 2, 3]` | `[1, 2, 3]` |
| `[]` | `[]` |
| `[[[[[]]]]]` | `[]` |
| `["a", ["b", "c"], [["d"]]]` | `["a", "b", "c", "d"]` |
| `[1, [2, [3, [4, [5]]]]]` | `[1, 2, 3, 4, 5]` |

## Approach
The solution uses recursion:
1. Iterate through each element of the input array
2. If an element is itself an array, recursively flatten it and append results
3. If an element is not an array, append it directly to the result
4. Return the accumulated flat array

This handles arrays of arbitrary nesting depth.
