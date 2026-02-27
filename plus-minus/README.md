# Plus Minus

## Problem
Given an array of integers, calculate the ratios of positive, negative, and zero elements. Return the ratios as decimal values with their respective counts.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/plus-minus.xs`):** Contains the solution logic

## Function Signature
- **Input:** `arr` (int[]) - An array of integers to analyze
- **Output:** Object containing:
  - `positive_ratio` (decimal) - Ratio of positive numbers
  - `negative_ratio` (decimal) - Ratio of negative numbers
  - `zero_ratio` (decimal) - Ratio of zeros
  - `positive_count` (int) - Count of positive numbers
  - `negative_count` (int) - Count of negative numbers
  - `zero_count` (int) - Count of zeros
  - `total` (int) - Total number of elements

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[-4, 3, -9, 0, 4, 1]` | positive_ratio: 0.5, negative_ratio: 0.333333, zero_ratio: 0.166667, counts: 3/2/1 |
| `[1, 2, 3, 4, 5]` | positive_ratio: 1.0, negative_ratio: 0.0, zero_ratio: 0.0, counts: 5/0/0 |
| `[]` | All ratios 0.0, all counts 0 (empty array edge case) |
| `[0, 0, 0]` | positive_ratio: 0.0, negative_ratio: 0.0, zero_ratio: 1.0, counts: 0/0/3 |
| `[-1, -2, -3]` | positive_ratio: 0.0, negative_ratio: 1.0, zero_ratio: 0.0, counts: 0/3/0 |
