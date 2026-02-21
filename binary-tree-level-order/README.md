# Binary Tree Level Order Traversal

## Problem
Given a binary tree, return the level order traversal of its nodes' values. (i.e., from left to right, level by level).

Level order traversal visits nodes in breadth-first order, processing all nodes at the current depth before moving to nodes at the next depth level.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/binary_tree_level_order.xs`):** Contains the solution logic using BFS (Breadth-First Search)

## Function Signature
- **Input:**
  - `nodes` (json): Array of tree nodes where each node has:
    - `value` (int): The node's value
    - `left` (int|null): Index of left child in the nodes array, or null
    - `right` (int|null): Index of right child in the nodes array, or null
  - `root_index` (int): Index of the root node in the nodes array
- **Output:**
  - Returns an array of arrays, where each inner array contains the values of nodes at that level, ordered from root level to leaf level

## Algorithm
Uses a queue-based BFS approach:
1. Start with the root node in the queue
2. For each level, determine how many nodes are in the queue (level_size)
3. Process exactly `level_size` nodes, adding their values to the current level array
4. Enqueue any left/right children of processed nodes
5. Add the completed level array to the result
6. Repeat until queue is empty

## Test Cases
| Input | Expected Output |
|-------|-----------------|
| `nodes: [{value: 1, left: null, right: null}], root_index: 0` | `[[1]]` |
| `nodes: [{value: 1, left: 1, right: 2}, {value: 2, left: null, right: null}, {value: 3, left: null, right: null}], root_index: 0` | `[[1], [2, 3]]` |
| `nodes: [], root_index: 0` | `[]` |
| `nodes: [{value: 1, left: 1, right: 2}, {value: 2, left: 3, right: 4}, {value: 3, left: null, right: 5}, {value: 4, left: null, right: null}, {value: 5, left: null, right: null}, {value: 6, left: null, right: null}], root_index: 0` | `[[1], [2, 3], [4, 5, 6]]` |
| `nodes: [{value: 1, left: 1, right: null}, {value: 2, left: 2, right: null}, {value: 3, left: null, right: null}], root_index: 0` | `[[1], [2], [3]]` (skewed/linked list tree) |

## Complexity Analysis
- **Time Complexity:** O(n) - we visit each node exactly once
- **Space Complexity:** O(n) - for the queue and result storage
