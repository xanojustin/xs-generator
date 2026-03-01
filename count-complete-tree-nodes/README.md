# Count Complete Tree Nodes

## Problem

Given the root of a **complete binary tree**, return the number of nodes in the tree.

A **complete binary tree** is a binary tree in which every level, except possibly the last, is completely filled, and all nodes in the last level are as far left as possible.

Design an algorithm that runs in less than O(n) time complexity, leveraging the complete tree property.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/count_complete_tree_nodes.xs`):** Contains the solution logic

## Function Signature

- **Input:** 
  - `tree` (int[]) - A level-order array representation of the complete binary tree where:
    - Index 0 is the root
    - Left child of node at index i is at 2*i + 1
    - Right child of node at index i is at 2*i + 2
    - `null` values represent missing nodes
- **Output:** 
  - `count` (int) - The total number of nodes in the complete binary tree

## Algorithm

The optimal solution uses the complete tree property:

1. Calculate the left height (always go left)
2. Calculate the right height (always go right)
3. If left == right, the tree is perfectly full: return 2^height - 1
4. Otherwise: 1 + countNodes(left subtree) + countNodes(right subtree)

This achieves O(log² n) time complexity instead of O(n).

## Test Cases

| Input | Expected Output | Description |
|-------|-----------------|-------------|
 `[1,2,3,4,5,6]` | 6 | Complete tree with 3 levels |
 `[1,2,3,4,5]` | 5 | Complete tree with last level partially filled |
 `[]` | 0 | Edge case: empty tree |
 `[1]` | 1 | Edge case: single node |
 `[1,2,3,4,5,6,7,8,9,10]` | 10 | Perfectly balanced tree |
