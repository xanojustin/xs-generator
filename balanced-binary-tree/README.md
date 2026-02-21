# Balanced Binary Tree

## Problem

Given a binary tree, determine if it is **height-balanced**.

A height-balanced binary tree is defined as a binary tree in which the left and right subtrees of every node differ in height by no more than 1.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/is_balanced.xs`):** Contains the solution logic

## Function Signature

- **Input:** `root` (json) - The root node of the binary tree. Each node has:
  - `val` (int): The value of the node
  - `left` (json/null): The left child node
  - `right` (json/null): The right child node
- **Output:** `bool` - Returns `true` if the tree is height-balanced, `false` otherwise

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| Balanced tree (root: {val: 3, left: {val: 9}, right: {val: 20, left: {val: 15}, right: {val: 7}}}) | `true` |
| Unbalanced tree (root: {val: 1, left: {val: 2, left: {val: 3, left: {val: 4}, right: {val: 4}}, right: {val: 3}}, right: {val: 2}}) | `false` |
| Empty tree (root: null) | `true` |
| Single node (root: {val: 1, left: null, right: null}) | `true` |
| Two nodes (root: {val: 1, left: {val: 2}, right: null}) | `true` |

### Detailed Test Case Descriptions

**Test Case 1 - Balanced Tree:**
```
    3
   / \
  9  20
    /  \
   15   7
```
- Node 3: left height = 1, right height = 2, diff = 1 ✓
- Node 9: left height = 0, right height = 0, diff = 0 ✓
- Node 20: left height = 1, right height = 1, diff = 0 ✓
- Result: `true`

**Test Case 2 - Unbalanced Tree:**
```
        1
       /
      2
     /
    3
   /
  4
```
- Node 1: left height = 3, right height = 0, diff = 3 ✗
- Result: `false`

**Test Case 3 - Empty Tree:**
- No nodes to check
- Result: `true`

**Test Case 4 - Single Node:**
- Only root node, no children
- Result: `true`

**Test Case 5 - Two Nodes:**
```
  1
 /
2
```
- Node 1: left height = 1, right height = 0, diff = 1 ✓
- Result: `true`
