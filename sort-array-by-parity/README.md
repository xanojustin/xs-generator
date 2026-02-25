# Sort Array By Parity

## Problem
Given an integer array `nums`, move all the even integers to the front of the array followed by all the odd integers.

Return **any array** that satisfies this condition. The relative order among the even and odd integers does not matter.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/sort_by_parity.xs`):** Contains the solution logic

## Function Signature
- **Input:**
  - `nums` (int[]): An array of integers (can be empty)
- **Output:**
  - `int[]`: Array with all even numbers first, followed by all odd numbers

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[3, 1, 2, 4]` | `[2, 4, 3, 1]` (or any valid order like `[4, 2, 1, 3]`) |
| `[0]` | `[0]` |
| `[]` | `[]` |
| `[1, 3, 5, 7]` | `[1, 3, 5, 7]` (no evens, order preserved) |
| `[2, 4, 6, 8]` | `[2, 4, 6, 8]` (all evens, order preserved) |
| `[1, 2, 3, 4, 5, 6]` | `[2, 4, 6, 1, 3, 5]` (evens before odds) |
