# Largest BST Subtree

## Problem

Given a binary tree, find the size of the largest subtree that is a Binary Search Tree (BST).

A Binary Search Tree is defined as a binary tree where for every node:
- All values in the left subtree are less than the node's value
- All values in the right subtree are greater than the node's value
- Both left and right subtrees are also BSTs

A single node is considered a valid BST of size 1.

## Structure

- **Run Job (`run.xs`):** Calls the test runner function to execute all test cases
- **Function (`function/solution.xs`):** Contains the solution logic for finding the largest BST subtree
- **Function (`function/test_runner.xs`):** Runs test cases and logs results

## Function Signature

### `largest_bst_subtree`

**Input:**
- `tree` (json): A binary tree represented as nested JSON objects with `val` (int), `left` (object/null), and `right` (object/null) properties

**Output:**
- `int`: The size (number of nodes) of the largest subtree that is a valid BST

## Algorithm

The solution uses a post-order traversal approach:
1. Traverse the tree and collect all nodes
2. Process nodes from leaves to root (post-order)
3. For each node, check if it forms a valid BST with its children:
   - Both left and right subtrees must be BSTs
   - Left subtree's max value must be less than current node's value
   - Right subtree's min value must be greater than current node's value
4. Track the size of the largest valid BST found

## Test Cases

| Input | Expected Output | Description |
|-------|-----------------|-------------|
| `{"val": 10, "left": {"val": 5, "left": {"val": 1}, "right": {"val": 8}}, "right": {"val": 15, "right": {"val": 7}}}` | 3 | Partial BST - the left subtree (size 3) is the largest valid BST |
| `null` | 0 | Empty tree |
| `{"val": 5}` | 1 | Single node |
| `{"val": 5, "left": {"val": 3, "left": {"val": 1}}, "right": {"val": 8}}` | 4 | Full valid BST - entire tree is a BST |
| `{"val": 10, "left": {"val": 15}, "right": {"val": 20}}` | 1 | Invalid root - only leaf nodes are valid BSTs of size 1 |

## Complexity Analysis

- **Time Complexity:** O(n²) where n is the number of nodes (due to object comparison for finding child indices)
- **Space Complexity:** O(n) for storing all nodes and their results
