# Rod Cutting

## Problem

Given a rod of length `n` and a price list where `prices[i]` represents the price of a rod piece of length `i+1`, determine the maximum value obtainable by cutting up the rod and selling the pieces.

For example, given prices `[1, 5, 8, 9, 10, 17, 17, 20]` for lengths 1-8:
- A rod of length 4 can be cut as:
  - 4 (no cuts) → value 9
  - 1+3 → value 1+8 = 9
  - 2+2 → value 5+5 = 10 ✓ (optimal)
  - 1+1+2 → value 1+1+5 = 7
  - 1+1+1+1 → value 1+1+1+1 = 4

The maximum obtainable value is **10**.

This is a classic dynamic programming problem where we build up solutions to smaller subproblems to solve the larger problem efficiently.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/rod_cutting.xs`):** Contains the dynamic programming solution

## Function Signature

- **Input:**
  - `prices` (int[]): Array of prices where `prices[i]` is the price for a rod of length `i+1`
  - `rod_length` (int): The length of the rod to maximize value for
  
- **Output:**
  - Maximum obtainable value (int)

## Test Cases

| Prices | Rod Length | Expected Output | Explanation |
|--------|-----------|-----------------|-------------|
| `[1, 5, 8, 9]` | 4 | 10 | Cut into 2+2: 5+5 = 10 |
| `[1, 5, 8, 9]` | 0 | 0 | Zero length rod has no value |
| `[]` | 4 | 0 | Empty prices array |
| `[3]` | 2 | 6 | Two pieces of length 1: 3+3 = 6 |
| `[1, 5, 8, 9, 10, 17, 17, 20]` | 8 | 22 | Cut into 2+6: 5+17 = 22 |
