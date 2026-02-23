# Validate Binary Search Tree

## Problem
Given the root of a binary tree, determine if it is a valid binary search tree (BST).

A **valid BST** is defined as follows:
- The left subtree of a node contains only nodes with keys **less than** the node's key.
- The right subtree of a node contains only nodes with keys **greater than** the node's key.
- Both the left and right subtrees must also be binary search trees.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/validate_bst.xs`):** Contains the solution logic using iterative in-order traversal

## Function Signature
- **Input:** `tree` (object) — A binary tree represented as nested objects with properties:
  - `val` (int): The node's value
  - `left` (object, optional): The left child node
  - `right` (object, optional): The right child node
- **Output:** `boolean` — `true` if the tree is a valid BST, `false` otherwise

## Test Cases

| Input | Expected Output | Description |
|-------|-----------------|-------------|
| `{val: 5, left: {val: 3}, right: {val: 7}}` | `true` | Simple valid BST |
| `{val: 5, left: {val: 6}, right: {val: 7}}` | `false` | Left child > parent |
| `{}` (empty tree) | `true` | Edge case: empty tree is valid |
| `{val: 1}` (single node) | `true` | Edge case: single node is valid |
| `{val: 5, left: {val: 1}, right: {val: 4, left: {val: 3}, right: {val: 6}}}` | `false` | Boundary: right child's left is valid but right child's right (6) < 5 |

## Algorithm
The solution uses **iterative in-order traversal** to validate the BST property:
1. Traverse the tree in-order (left → node → right)
2. Keep track of the previously visited node's value
3. For each node, verify its value is greater than the previous value
4. If any node violates this property, the tree is not a valid BST

## Complexity
- **Time Complexity:** O(n) where n is the number of nodes
- **Space Complexity:** O(h) where h is the height of the tree (stack space)
