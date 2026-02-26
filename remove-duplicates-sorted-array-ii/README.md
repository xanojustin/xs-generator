# Remove Duplicates from Sorted Array II

## Problem

Given a sorted array of integers, remove the duplicates **in-place** such that each unique element appears at most **twice**. Return the new length of the array and the modified array.

The input array is passed by reference (the array is modified in place). After calling your function, the first `k` elements of the array should hold the final result, where `k` is the new length returned.

It does not matter what you leave beyond the returned length.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test input `[1, 1, 1, 2, 2, 3]`
- **Function (`function/remove_duplicates_sorted_array_ii.xs`):** Contains the two-pointer solution logic

## Function Signature

- **Input:**
  - `nums` (int[]) - A sorted array of integers
- **Output:**
  - `length` (int) - The new length of the array after removing excess duplicates
  - `array` (int[]) - The modified array containing only the first `length` elements

## Algorithm

The solution uses a **two-pointer technique**:

1. If the array has 2 or fewer elements, return it as-is (all elements are allowed)
2. Initialize pointer `i = 2` (we always keep the first 2 elements)
3. Iterate through the array starting from index 2:
   - If `nums[idx] != nums[i-2]`, it means this element appears fewer than 2 times so far
   - Place it at position `i` and increment `i`
4. Return `i` as the new length

**Time Complexity:** O(n) where n is the length of the array  
**Space Complexity:** O(1) - modifies array in-place

## Test Cases

| Input | Expected Output | Notes |
|-------|-----------------|-------|
| `[1, 1, 1, 2, 2, 3]` | `length: 5`, `array: [1, 1, 2, 2, 3]` | Basic case - third 1 is removed |
| `[0, 0, 1, 1, 1, 1, 2, 3, 3]` | `length: 7`, `array: [0, 0, 1, 1, 2, 3, 3]` | Multiple duplicates - extra 1s removed |
| `[1, 2, 3]` | `length: 3`, `array: [1, 2, 3]` | No duplicates - unchanged |
| `[]` | `length: 0`, `array: []` | Edge case - empty array |
| `[1]` | `length: 1`, `array: [1]` | Edge case - single element |
| `[1, 1]` | `length: 2`, `array: [1, 1]` | Edge case - two identical elements (allowed) |
| `[1, 1, 1]` | `length: 2`, `array: [1, 1]` | Edge case - three identical elements (remove one) |
