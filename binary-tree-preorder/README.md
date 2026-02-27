# Binary Tree Pre-Order Traversal

## Problem
Given a binary tree, return the pre-order traversal of its node values.

Pre-order traversal visits nodes in the following order:
1. Root node
2. Left subtree (all nodes)
3. Right subtree (all nodes)

## Structure
- **Run Job (`run.xs`):** Calls the solution function with a sample binary tree
- **Function (`function/binary_tree_preorder.xs`):** Contains the iterative pre-order traversal implementation

## Function Signature
- **Input:** 
  - `nodes` (json[]): Array of tree nodes where each node has:
    - `value` (int): The node's value
    - `left` (int | null): Index of left child node or null
    - `right` (int | null): Index of right child node or null
  - `root_index` (int): Index of the root node in the nodes array
- **Output:** 
  - `int[]`: Array of values in pre-order traversal order

## Example

Given this tree:
```
      1
     / \
    2   3
   / \
  4   5
```

Pre-order traversal visits: 1 → 2 → 4 → 5 → 3

Output: `[1, 2, 4, 5, 3]`

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `nodes: [{value: 1, left: null, right: null}], root_index: 0` | `[1]` |
| `nodes: [{value: 1, left: 1, right: null}, {value: 2, left: null, right: null}], root_index: 0` | `[1, 2]` |
| `nodes: [{value: 1, left: null, right: 1}, {value: 3, left: null, right: null}], root_index: 0` | `[1, 3]` |
| Complex tree (see run.xs) | `[1, 2, 4, 5, 3]` |
| `nodes: [], root_index: 0` (empty tree) | `[]` |

## Algorithm

This implementation uses an **iterative approach** with an explicit stack:

1. Initialize an empty result array and a stack with the root index
2. While the stack is not empty:
   - Pop a node index from the stack
   - Add the node's value to the result (visit root first in pre-order)
   - Push the right child index onto the stack (if exists)
   - Push the left child index onto the stack (if exists)
   
Note: We push right before left because the stack is LIFO (Last In, First Out). Since we want to process the left subtree before the right subtree in pre-order traversal, we push right first so left is on top of the stack.

The iterative approach avoids potential stack overflow with deeply nested trees that a recursive solution might encounter.

## Complexity
- **Time:** O(n) where n is the number of nodes
- **Space:** O(h) where h is the height of the tree (for the stack)
