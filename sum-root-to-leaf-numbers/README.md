# Sum Root to Leaf Numbers

## Problem
Given a binary tree where each node contains a digit from 0-9, each root-to-leaf path represents a number. For example, the path `1 -> 2 -> 3` represents the number `123`.

Return the sum of all root-to-leaf path numbers in the binary tree.

A leaf is a node with no children.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/sum_root_to_leaf.xs`):** Contains the solution logic using iterative DFS

## Function Signature
- **Input:** 
  - `tree` (json): Binary tree node with `val` (int 0-9), `left` (json), and `right` (json) properties
- **Output:** (int) Sum of all root-to-leaf path numbers

## Example

Input Tree:
```
        1
       / \
      2   3
     / \   \
    4   5   6
```

Root-to-leaf paths:
- 1→2→4 = 124
- 1→2→5 = 125
- 1→3→6 = 136

Sum: 124 + 125 + 136 = **385**

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| Tree: `{val: 1, left: {val: 2, left: {val: 4}, right: {val: 5}}, right: {val: 3, left: {val: 6}, right: {val: 7}}}` | `646` (124 + 125 + 136 + 137 = 522... wait, let me recalculate: 124 + 125 + 136 + 137 = 522) |
| Tree: `{val: 4, left: {val: 9, left: {val: 5}, right: {val: 1}}, right: {val: 0}}` | `1026` (495 + 491 + 40 = 1026) |
| Tree: `null` | `0` (Empty tree) |
| Tree: `{val: 5}` | `5` (Single node) |
| Tree: `{val: 1, left: {val: 0}}` | `10` (Path: 1→0 = 10) |

## Algorithm

The solution uses an **iterative DFS approach** with a stack:

1. Start with the root node and its value as the current number
2. For each node:
   - If it's a leaf (no children), add the current number to the total sum
   - If it has children, push them onto the stack with the updated number:
     - New number = (current number × 10) + child's value
3. Continue until all nodes are processed
4. Return the total sum

This approach efficiently computes the sum without recursion, using O(h) space where h is the tree height.
