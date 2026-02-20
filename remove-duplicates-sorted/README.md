# Remove Duplicates from Sorted Array

## Problem
Given a sorted array of integers, remove the duplicates **in-place** such that each unique element appears only once. The relative order of the elements should be kept the same. Return the number of unique elements.

Since it is impossible to change the length of the array in XanoScript, this implementation simulates the "in-place" behavior by tracking which elements would be kept and returns the count of unique elements.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/remove_duplicates.xs`):** Contains the solution logic

## Function Signature
- **Input:** 
  - `nums` (int[]): A sorted array of integers (may contain duplicates)
- **Output:** 
  - Returns `int` - The number of unique elements in the array

## Algorithm
This solution uses the **two-pointer technique**:
1. Use one pointer (`read_index`) to scan through the array
2. Use another pointer (`write_index`) to track where to place the next unique element
3. When a new unique element is found, place it at the `write_index` position
4. Return the `write_index` as the count of unique elements

**Time Complexity:** O(n) - single pass through the array
**Space Complexity:** O(n) - creates a copy of the input array (XanoScript limitation)

## Test Cases

| Input | Expected Output | Description |
|-------|-----------------|-------------|
| `[1, 1, 2]` | `2` | Basic case with one duplicate |
| `[0, 0, 1, 1, 1, 2, 2, 3, 3, 4]` | `5` | Multiple duplicates, multiple unique values |
| `[]` | `0` | Empty array edge case |
| `[1]` | `1` | Single element edge case |
| `[1, 2, 3, 4, 5]` | `5` | No duplicates (already unique) |
| `[1, 1, 1, 1, 1]` | `1` | All elements the same |
| `[-3, -3, -2, -1, -1, 0, 0, 1]` | `5` | Negative numbers included |

## Example Walkthrough

**Input:** `[1, 1, 2]`

| Step | read_index | current | previous | Match? | write_index | Action |
|------|------------|---------|----------|--------|-------------|--------|
| 1 | 1 | 1 | 1 | Yes | 1 | Skip (duplicate) |
| 2 | 2 | 2 | 1 | No | 2 | Keep, increment write_index |

**Result:** `2` (unique elements: `[1, 2]`)

## Notes
- This is LeetCode problem #26 (Easy)
- The classic in-place solution modifies the input array directly, but XanoScript's `$input` variables are immutable
- We create a copy of the array to simulate the behavior
