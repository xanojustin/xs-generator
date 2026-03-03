# Minimum Absolute Difference in BST

## Problem

Given the root of a Binary Search Tree (BST), return the minimum absolute difference between the values of any two different nodes in the tree.

In a BST:
- The left subtree of a node contains only nodes with keys less than the node's key
- The right subtree of a node contains only nodes with keys greater than the node's key
- Both the left and right subtrees must also be binary search trees

The key insight is that an in-order traversal of a BST yields values in sorted ascending order. Therefore, the minimum absolute difference must be between two adjacent values in this sorted sequence.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with a test BST
- **Function (`function/minimum_absolute_difference_in_bst.xs`):** Contains the solution logic using iterative in-order traversal

## Function Signature

- **Input:** 
  - `root` (object): The root node of the BST, where each node has:
    - `val` (int): The node's value
    - `left` (object, optional): Left child node
    - `right` (object, optional): Right child node
- **Output:** 
  - (int): The minimum absolute difference between any two node values

## Algorithm

1. Perform an in-order traversal of the BST to collect node values in sorted order
2. Iterate through the sorted values and find the minimum difference between adjacent elements
3. Return the minimum difference found

## Test Cases

| Input BST | Expected Output |
|-----------|-----------------|
| `{val: 4, left: {val: 2, left: {val: 1}, right: {val: 3}}, right: {val: 6}}` | 1 |
| `{val: 1, right: {val: 3, left: {val: 2}}}` | 1 |
| `{val: 5}` | N/A (single node) |
| `{val: 543, left: {val: 384, right: {val: 445}}, right: {val: 652, right: {val: 699}}}` | 47 |

### Explanation of Test Cases

1. **Basic case:** The in-order traversal gives [1, 2, 3, 4, 6]. Minimum difference is 1 (between 1-2, 2-3, or 3-4).

2. **Right-heavy tree:** The in-order traversal gives [1, 2, 3]. Minimum difference is 1.

3. **Single node:** A tree with only one node has no pairs to compare.

4. **Complex case:** The in-order traversal gives [384, 445, 543, 652, 699]. Minimum difference is 47 (between 445 and 384, or between 699 and 652).
