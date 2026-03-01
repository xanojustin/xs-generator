# Counting Elements

## Problem

Given an integer array `nums`, count how many elements `x` exist such that `x + 1` is also in `nums`.

If there are duplicates in `nums`, count them separately.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/count_elements.xs`):** Contains the solution logic

## Function Signature

- **Input:** 
  - `nums` (int[]): An array of integers
- **Output:** 
  - Returns an integer representing the count of elements x where x+1 also exists in the array

## Approach

The solution uses a hash set for O(1) lookup:

1. First, we build a set of all elements in the array
2. Then, we iterate through each element and check if `element + 1` exists in the set
3. We count all such occurrences

This gives us O(n) time complexity where n is the length of the array.

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[1, 2, 3]` | `2` | 1+1=2 exists, 2+1=3 exists. Both 1 and 2 are counted. |
| `[1, 1, 3, 3, 5, 5, 7, 7]` | `0` | No x+1 exists for any element. |
| `[1, 2, 2, 3, 3, 4]` | `4` | 1+1=2 exists, 2+1=3 exists (twice), 3+1=4 exists (twice). Total = 4. |
| `[]` | `0` | Empty array returns 0. |
| `[5]` | `0` | Single element with no x+1 match. |
| `[0, -1, -2]` | `2` | Negative numbers work too: -2+1=-1 exists, -1+1=0 exists. |

## Example Walkthrough

For input `[1, 2, 3]`:
1. Build set: `{1: true, 2: true, 3: true}`
2. Check each element:
   - 1: 1+1=2 exists in set → count = 1
   - 2: 2+1=3 exists in set → count = 2
   - 3: 3+1=4 does NOT exist → count stays 2
3. Return 2
