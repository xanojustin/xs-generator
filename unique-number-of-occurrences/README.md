# Unique Number of Occurrences

## Problem
Given an array of integers `arr`, return `true` if the number of occurrences of each value in the array is unique, or `false` otherwise.

### Example
- Input: `[1, 2, 2, 1, 1, 3]`
  - 1 occurs 3 times
  - 2 occurs 2 times  
  - 3 occurs 1 time
  - All frequencies (3, 2, 1) are unique → return `true`

- Input: `[1, 2]`
  - 1 occurs 1 time
  - 2 occurs 1 time
  - Frequencies are NOT unique (both 1) → return `false`

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/unique_number_of_occurrences.xs`):** Contains the solution logic

## Function Signature
- **Input:** 
  - `arr` (int[]): Array of integers to analyze
- **Output:** 
  - Returns `bool`: `true` if all element frequencies are unique, `false` otherwise

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[1, 2, 2, 1, 1, 3]` | `true` | Frequencies: 1→3, 2→2, 3→1 (all unique) |
| `[1, 2]` | `false` | Frequencies: 1→1, 2→1 (duplicate frequency) |
| `[-3, 0, 1, -3, 1, 1, 1, -3, 10, 0]` | `true` | Frequencies: -3→3, 0→2, 1→4, 10→1 (all unique) |
| `[]` | `true` | Empty array has no frequencies to compare |
| `[5, 5, 5, 5]` | `true` | Single unique frequency (4) |

## Algorithm
1. Build a frequency map by iterating through the array
2. Extract all frequency values from the map
3. Compare the count of all frequencies vs. count of unique frequencies
4. Return `true` if they match (all frequencies are unique)
