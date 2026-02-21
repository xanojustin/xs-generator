# Contains Duplicate

## Problem
Given an array of integers, determine if the array contains any duplicate elements. Return `true` if any value appears at least twice in the array, and `false` if every element is distinct.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/contains_duplicate.xs`):** Contains the solution logic using a hash set approach

## Function Signature
- **Input:** 
  - `nums` (int[]) — Array of integers to check for duplicates
- **Output:** 
  - `bool` — `true` if duplicates exist, `false` if all elements are unique

## Approach
The solution uses a hash set (object/map) to track seen numbers:
1. Iterate through each number in the array
2. For each number, check if it's already in the set
3. If yes, return `true` (duplicate found)
4. If no, add the number to the set and continue
5. If iteration completes without finding duplicates, return `false`

**Time Complexity:** O(n) — single pass through the array  
**Space Complexity:** O(n) — hash set stores up to n elements

## Test Cases

| Input | Expected Output | Description |
|-------|-----------------|-------------|
| `[1, 2, 3, 1]` | `true` | Basic case: duplicate at start and end |
| `[1, 2, 3, 4]` | `false` | All unique elements |
| `[]` | `false` | Edge case: empty array |
| `[1]` | `false` | Edge case: single element |
| `[1, 1, 1, 1]` | `true` | Boundary case: all same elements |
| `[-1, 0, 1, -1]` | `true` | Interesting case: negative numbers with duplicate |
