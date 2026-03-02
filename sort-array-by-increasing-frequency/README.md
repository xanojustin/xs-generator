# Sort Array by Increasing Frequency

## Problem
Given an array of integers, sort the array by **increasing frequency** of elements. If multiple elements have the same frequency, sort them in **decreasing order** of their values.

### Example
- Input: `[1, 1, 2, 2, 2, 3]`
- Output: `[3, 1, 1, 2, 2, 2]`

**Explanation:**
- `3` appears once (frequency 1)
- `1` appears twice (frequency 2)
- `2` appears three times (frequency 3)

So the sorted order is: `[3, 1, 1, 2, 2, 2]`

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/sort_by_frequency.xs`):** Contains the solution logic

## Function Signature
- **Input:**
  - `nums` (`int[]`): Array of integers to sort
- **Output:**
  - `int[]`: Array sorted by increasing frequency (ties broken by descending value)

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[1, 1, 2, 2, 2, 3]` | `[3, 1, 1, 2, 2, 2]` | 3(freq 1), 1(freq 2), 2(freq 3) |
| `[2, 3, 1, 3, 2]` | `[1, 2, 2, 3, 3]` | 1(freq 1), 2(freq 2), 3(freq 2) - tie broken by value desc |
| `[-1, 1, -6, 4, 5, -6, 1, 4, 1]` | `[5, -1, 4, 4, -6, -6, 1, 1, 1]` | Mixed positive/negative values |
| `[]` | `[]` | Empty array edge case |
| `[1]` | `[1]` | Single element edge case |
| `[1, 1, 1, 1]` | `[1, 1, 1, 1]` | All same elements |
