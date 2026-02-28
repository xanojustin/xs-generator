# Sort the People

## Problem
You are given an array of strings `names` and an array of integers `heights`, both of length `n`. Each person `i` has a name `names[i]` and a height `heights[i]`.

Return the names sorted in **descending order** by the people's heights.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/sort_the_people.xs`):** Contains the solution logic

## Function Signature
- **Input:** 
  - `names` (text[]): Array of person names
  - `heights` (int[]): Array of heights corresponding to names (same length)
- **Output:** 
  - `text[]`: Array of names sorted by height in descending order (tallest first)

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `names: ["Alice", "Bob", "Charlie", "David"]`<br>`heights: [165, 180, 175, 160]` | `["Bob", "Charlie", "Alice", "David"]` |
| `names: ["Mary", "John", "Emma"]`<br>`heights: [180, 165, 170]` | `["Mary", "Emma", "John"]` |
| `names: ["Single"]`<br>`heights: [150]` | `["Single"]` |
| `names: ["A", "B"]`<br>`heights: [100, 100]` | `["A", "B"]` (stable sort - same height, original order) |

## Algorithm
1. Combine the `names` and `heights` arrays into an array of person objects
2. Use bubble sort to sort the people by height in descending order
3. Extract and return just the names from the sorted array
