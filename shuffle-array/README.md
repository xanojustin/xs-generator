# Shuffle Array

## Problem
Given an integer array `nums`, shuffle the array randomly using the Fisher-Yates (Knuth) shuffle algorithm.

The Fisher-Yates shuffle works by iterating from the last element to the first, and for each element at index `i`, swapping it with a randomly chosen element from index `0` to `i` (inclusive). This ensures every permutation of the array is equally likely.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with a test array `[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]`
- **Function (`function/shuffle_array.xs`):** Contains the Fisher-Yates shuffle implementation

## Function Signature
- **Input:**
  - `nums` (int[]): The array of integers to shuffle
- **Output:**
  - int[]: A new array with all elements from the input in random order

## Algorithm
The Fisher-Yates shuffle algorithm:
1. Start from the last index `i = n - 1`
2. Generate a random index `j` between `0` and `i`
3. Swap elements at indices `i` and `j`
4. Decrement `i` and repeat until `i = 0`

This produces an unbiased shuffle where every permutation is equally likely.

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[1, 2, 3, 4, 5]` | Random permutation of `[1, 2, 3, 4, 5]` (e.g., `[3, 1, 5, 2, 4]`) |
| `[1]` | `[1]` (single element always returns itself) |
| `[]` | `[]` (empty array returns empty) |
| `[10, 20, 30]` | Random permutation like `[20, 30, 10]` or `[30, 10, 20]` |

## Complexity
- **Time Complexity:** O(n) - single pass through the array
- **Space Complexity:** O(1) - in-place shuffle (modifying the array copy)
