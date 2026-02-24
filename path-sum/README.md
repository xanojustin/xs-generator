# Path Sum

## Problem
Given a binary tree and a target sum, determine if the tree has a root-to-leaf path such that adding up all the values along the path equals the given sum.

A leaf is a node with no children.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/path_sum.xs`):** Contains the solution logic using iterative DFS

## Function Signature
- **Input:** 
  - `tree` (json): Binary tree node with `val` (int), `left` (json), and `right` (json) properties
  - `target_sum` (int): The target sum to find on a root-to-leaf path
- **Output:** (bool) `true` if there exists a root-to-leaf path with sum equal to target_sum, `false` otherwise

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| Tree: `{val: 5, left: {val: 4, left: {val: 11, left: {val: 7}, right: {val: 2}}}, right: {val: 8, left: {val: 13}, right: {val: 4, right: {val: 1}}}}`, Target: 22 | `true` (Path: 5→4→11→2 = 22) |
| Tree: `{val: 1, left: {val: 2}, right: {val: 3}}`, Target: 5 | `false` (No path sums to 5) |
| Tree: `null`, Target: 0 | `false` (Empty tree) |
| Tree: `{val: 1}`, Target: 1 | `true` (Single node equals target) |
| Tree: `{val: 1}`, Target: 2 | `false` (Single node doesn't equal target) |

## Example Tree Structure
```
        5
       / \
      4   8
     /   / \
    11  13  4
   / \       \
  7   2       1
```

Target sum: 22
Path: 5 → 4 → 11 → 2 = 22 ✓
