# Permutations II

## Problem
Given a collection of numbers that might contain duplicates, return all possible unique permutations.

For example, given `[1, 1, 2]`, the unique permutations are:
- `[1, 1, 2]`
- `[1, 2, 1]`
- `[2, 1, 1]`

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/permutations_ii.xs`):** Contains the solution logic using backtracking with duplicate skipping

## Function Signature
- **Input:**
  - `nums` (int[]): Array of integers (may contain duplicates)
- **Output:**
  - (int[][]): Array of all unique permutations, where each permutation is an array of integers

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `nums: [1, 1, 2]` | `[[1, 1, 2], [1, 2, 1], [2, 1, 1]]` |
| `nums: [1, 2, 3]` | `[[1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 1, 2], [3, 2, 1]]` |
| `nums: []` | `[[]]` (edge case: empty array) |
| `nums: [1]` | `[[1]]` (edge case: single element) |
| `nums: [1, 1, 1]` | `[[1, 1, 1]]` (edge case: all duplicates) |
| `nums: [1, 2, 2]` | `[[1, 2, 2], [2, 1, 2], [2, 2, 1]]` |

## Algorithm
This solution uses **backtracking with duplicate skipping**:
1. **Sort the input array** to group identical elements together
2. **Use a used[] array** to track which elements are in the current permutation
3. **Skip duplicates:** For each position, if the current element is the same as the previous element AND the previous element hasn't been used yet, skip it. This ensures we only generate permutations where duplicates appear in their original sorted order.
4. **Build permutations iteratively** using a manual stack to simulate recursion

**Time Complexity:** O(n × n!) in the worst case, where n is the number of elements. We generate n! permutations and each takes O(n) time to build.

**Space Complexity:** O(n) for the recursion stack and used array, plus O(n × n!) to store all permutations.

## Key Insight
The duplicate-skipping rule is crucial: when we have duplicates like `[1, 1, 2]`, we only use the second `1` if the first `1` has already been used. This prevents generating duplicate permutations like `[1, 1, 2]` twice (once for each `1` in the first position).
