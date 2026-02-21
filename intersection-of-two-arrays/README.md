# Intersection of Two Arrays

## Problem
Given two integer arrays `array1` and `array2`, return an array of their intersection. Each element in the result must be unique and you may return the result in any order.

The intersection of two arrays is the set of elements which are present in both arrays. Duplicates in the input arrays should only appear once in the result.

## Structure
- **Run Job (`run.xs`):** Entry point that calls the test function
- **Function (`function/intersection.xs`):** Contains the solution logic for finding intersection
- **Function (`function/test_intersection.xs`):** Test runner that exercises intersection with multiple test cases

## Function Signature
- **Input:** 
  - `array1: int[]` - First array of integers
  - `array2: int[]` - Second array of integers
- **Output:** 
  - `int[]` - Array containing unique elements present in both input arrays (order not guaranteed)

## Test Cases

| array1 | array2 | Expected Output |
|--------|--------|-----------------|
| [1, 2, 2, 1] | [2, 2] | [2] |
| [4, 9, 5] | [9, 4, 9, 8, 4] | [4, 9] or [9, 4] |
| [1, 2, 3] | [4, 5, 6] | [] |
| [] | [1, 2, 3] | [] |
| [7] | [7] | [7] |
| [1, 1, 1, 1] | [1, 1, 1] | [1] |

## Approach
The solution iterates through the first array and checks if each element:
1. Exists in the second array (using the `contains` filter)
2. Has not already been added to the result (ensuring uniqueness)

This approach prioritizes readability over optimal performance. For very large arrays, using a hash set would be more efficient.

## Complexity
- **Time Complexity:** O(n × m) where n is the length of array1 and m is the length of array2
- **Space Complexity:** O(k) where k is the number of unique elements in the intersection
