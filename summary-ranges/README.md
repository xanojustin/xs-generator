# Summary Ranges

## Problem
Given a sorted unique integer array `nums`, return the smallest sorted list of ranges that cover all the numbers in the array exactly.

Each range `[a,b]` should be output as:
- `"a->b"` if `a != b` (a range spanning multiple numbers)
- `"a"` if `a == b` (a single number)

The ranges should be sorted, and each element of `nums` must be covered by exactly one range.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/summary_ranges.xs`):** Contains the solution logic

## Function Signature
- **Input:** 
  - `nums` (int[]): Sorted array of unique integers
- **Output:** 
  - `text[]`: Array of formatted range strings

## Approach
1. Initialize an empty result array and a pointer at the start
2. For each starting position, extend the range as far as possible while numbers are consecutive (current + 1 == next)
3. Format the range based on whether it's a single number or a span
4. Add the formatted string to the result and move to the next unprocessed number

## Time & Space Complexity
- **Time:** O(n) - single pass through the array
- **Space:** O(1) excluding output - only using a few variables

## Test Cases

| Input | Expected Output | Description |
|-------|-----------------|-------------|
| `[0, 1, 2, 4, 5, 7]` | `["0->2", "4->5", "7"]` | Basic case with mixed ranges |
| `[0, 2, 3, 4, 6, 8, 9]` | `["0", "2->4", "6", "8->9"]` | Multiple single elements and ranges |
| `[]` | `[]` | Empty array edge case |
| `[1]` | `["1"]` | Single element edge case |
| `[1, 2, 3, 4, 5]` | `["1->5"]` | All consecutive (single range) |
| `[1, 3, 5, 7]` | `["1", "3", "5", "7"]` | No consecutive numbers (all singles) |
