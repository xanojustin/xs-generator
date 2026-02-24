# Subtree of Another Tree

## Problem

Given two binary trees `root` and `subRoot`, return `true` if there is a subtree of `root` with the same structure and node values of `subRoot`, and `false` otherwise.

A subtree of a binary tree is a tree that consists of a node in `root` and all of this node's descendants. The tree `root` could also be considered as a subtree of itself.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/is_subtree.xs`):** Contains the main solution logic
- **Helper Function (`function/is_same_tree.xs`):** Helper function to check if two trees are identical

## Function Signature

### Main Function: `is_subtree`

- **Input:**
  - `root` (json): The main binary tree node with `val`, `left`, and `right` properties
  - `subRoot` (json): The subtree candidate to search for
- **Output:** (bool) `true` if `subRoot` is a subtree of `root`, `false` otherwise

### Helper Function: `is_same_tree`

- **Input:**
  - `tree1` (json): First binary tree
  - `tree2` (json): Second binary tree
- **Output:** (bool) `true` if both trees are identical, `false` otherwise

## Algorithm

1. Base cases:
   - If `subRoot` is null, return `true` (empty tree is a subtree of any tree)
   - If `root` is null, return `false` (non-empty tree can't be a subtree of empty tree)

2. Check if `root` and `subRoot` are identical trees using the helper function

3. If not identical, recursively check if `subRoot` is a subtree of `root.left` or `root.right`

## Test Cases

| Case | root | subRoot | Expected Output |
|------|------|---------|-----------------|
| Basic match | `{val: 3, left: {val: 4, left: {val: 1}, right: {val: 2}}, right: {val: 5}}` | `{val: 4, left: {val: 1}, right: {val: 2}}` | `true` |
| No match | `{val: 3, left: {val: 4, left: {val: 1}}, right: {val: 5, left: {val: 2}}}` | `{val: 4, left: {val: 1}, right: {val: 2}}` | `false` |
| Edge: Empty subRoot | `{val: 1, left: {val: 2}}` | `null` | `true` |
| Edge: Both empty | `null` | `null` | `true` |
| Edge: Empty root only | `null` | `{val: 1}` | `false` |
| Root is subtree of itself | `{val: 1, left: {val: 2}}` | `{val: 1, left: {val: 2}}` | `true` |
| Single node match | `{val: 1}` | `{val: 1}` | `true` |
| Single node no match | `{val: 1}` | `{val: 2}` | `false` |

## Complexity Analysis

- **Time Complexity:** O(m * n) in the worst case, where m is the number of nodes in `root` and n is the number of nodes in `subRoot`. For each node in `root`, we might call `is_same_tree` which takes O(n) time.
- **Space Complexity:** O(h) where h is the height of `root`, due to the recursion stack.
