# Permutations

## Problem
Given an array of **distinct** integers, return all possible permutations. You can return the answer in any order.

A permutation is an arrangement of all the elements of a set into a sequence or order. For an array of n distinct elements, there are n! (n factorial) possible permutations.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/permutations.xs`):** Contains the backtracking solution logic

## Function Signature
- **Input:** 
  - `nums` (int[]): Array of distinct integers to permute
- **Output:** 
  - Returns a JSON array containing all possible permutations, where each permutation is an array of integers

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[1, 2, 3]` | `[[1,2,3], [1,3,2], [2,1,3], [2,3,1], [3,1,2], [3,2,1]]` (6 permutations) |
| `[0, 1]` | `[[0,1], [1,0]]` |
| `[1]` | `[[1]]` |

## Algorithm Explanation

This solution uses an **iterative backtracking approach** (simulating recursion with a manual stack):

1. **State Tracking**: Each stack frame tracks:
   - `current`: The partial permutation being built
   - `used`: A map tracking which input elements have been used

2. **Process**:
   - Pop a state from the stack
   - If the current permutation is complete (same length as input), add it to results
   - Otherwise, for each unused element, create a new state with that element added and push to stack

3. **Complexity**:
   - Time: O(n × n!) where n is the array length
   - Space: O(n × n!) for storing all permutations

## Example Walkthrough

For input `[1, 2, 3]`:
1. Start with empty permutation `[]`
2. Add 1: `[1]`, then recursively add 2: `[1,2]`, then add 3: `[1,2,3]` → save
3. Backtrack, try 3: `[1,3]`, then add 2: `[1,3,2]` → save
4. Backtrack to root, try 2: `[2]`, then add 1: `[2,1]`, then add 3: `[2,1,3]` → save
5. Continue until all 6 permutations are found
