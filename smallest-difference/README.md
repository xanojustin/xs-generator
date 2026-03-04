# Smallest Difference

## Problem
Given two arrays of integers, find the pair of numbers (one from each array) with the smallest absolute difference and return them as an array `[num1, num2]`.

For example, if `array1 = [-1, 5, 10, 20, 28, 3]` and `array2 = [26, 134, 135, 15, 17]`, the smallest difference is between `28` (from array1) and `26` (from array2), so the result is `[28, 26]`.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/smallest_difference.xs`):** Contains the solution logic using a two-pointer technique on sorted arrays

## Function Signature
- **Input:** 
  - `array1` (int[]): First array of integers
  - `array2` (int[]): Second array of integers
- **Output:** 
  - Returns an int[] containing the pair `[num1, num2]` with the smallest absolute difference
  - Returns an empty array `[]` if either input array is empty

## Algorithm
The solution uses an efficient two-pointer approach:
1. Sort both input arrays
2. Use two pointers (one for each array) starting at index 0
3. Calculate the absolute difference between the current elements
4. Track the pair with the smallest difference seen so far
5. Move the pointer pointing to the smaller value (since sorting guarantees the difference can only get smaller by advancing the smaller value)
6. If an exact match is found (difference = 0), return immediately as this is optimal

**Time Complexity:** O(n log n + m log m) where n and m are the lengths of the arrays (due to sorting)  
**Space Complexity:** O(n + m) for the sorted copies of the arrays

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `array1: [-1, 5, 10, 20, 28, 3]`<br>`array2: [26, 134, 135, 15, 17]` | `[28, 26]` |
| `array1: [10, 20, 30]`<br>`array2: [15, 25, 35]` | `[20, 15]` or `[20, 25]` (both have diff of 5) |
| `array1: []`<br>`array2: [1, 2, 3]` | `[]` (edge case: empty array) |
| `array1: [5]`<br>`array2: [5]` | `[5, 5]` (boundary case: exact match) |
| `array1: [-5, -1, 0]`<br>`array2: [2, 4, 6]` | `[0, 2]` (interesting case: negative numbers) |
