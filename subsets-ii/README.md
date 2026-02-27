# Subsets II

## Problem
Given an integer array `nums` that may contain duplicates, return all possible subsets (the power set).

The solution set must not contain duplicate subsets. Return the solution in any order.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/subsets_ii.xs`):** Contains the solution logic

## Function Signature
- **Input:** `nums` - An array of integers that may contain duplicate elements
- **Output:** Array of arrays containing all unique subsets of the input

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[1, 2, 2]` | `[[], [1], [2], [1, 2], [2, 2], [1, 2, 2]]` |
| `[0]` | `[[], [0]]` |
| `[]` | `[[]]` |
| `[1, 1, 1]` | `[[], [1], [1, 1], [1, 1, 1]]` |

### Basic/Happy Path Cases
- **Input:** `[1, 2, 2]`  
  **Expected:** `[[], [1], [2], [1, 2], [2, 2], [1, 2, 2]]`  
  Note: The duplicate `2` means we can't just use standard subsets algorithm — we need to handle duplicates carefully.

### Edge Cases
- **Input:** `[]`  
  **Expected:** `[[]]`  
  The empty set has exactly one subset: itself.

- **Input:** `[0]`  
  **Expected:** `[[], [0]]`  
  Single element case with no duplicates.

### Boundary/Interesting Cases
- **Input:** `[1, 1, 1]`  
  **Expected:** `[[], [1], [1, 1], [1, 1, 1]]`  
  All elements are the same — should only produce 4 unique subsets, not 8.

## Algorithm Explanation

The solution uses an iterative approach with duplicate handling:

1. **Sort the input** to group duplicate elements together
2. **Initialize result** with the empty subset `[[]]`
3. **Process each unique element group:**
   - Count how many times the current element appears consecutively
   - For each existing subset, create new subsets by adding 1 to count copies of the current element
   - This ensures we don't create duplicate subsets

### Time Complexity: O(n × 2^n)
- In the worst case (no duplicates), we generate 2^n subsets
- Each subset takes O(n) to copy

### Space Complexity: O(n × 2^n)
- We store all unique subsets in the result
