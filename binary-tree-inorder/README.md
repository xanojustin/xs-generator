# Binary Tree In-Order Traversal

## Problem
Given a binary tree, return the in-order traversal of its node values.

In-order traversal visits nodes in the following order:
1. Left subtree (all nodes)
2. Root node
3. Right subtree (all nodes)

## Structure
- **Run Job (`run.xs`):** Calls the solution function with a sample binary tree
- **Function (`function/binary_tree_inorder.xs`):** Contains the iterative in-order traversal implementation

## Function Signature
- **Input:** 
  - `tree` (object): A binary tree node with:
    - `value` (int): The node's value
    - `left` (object | null): Left child node or null
    - `right` (object | null): Right child node or null
- **Output:** 
  - `int[]`: Array of values in in-order traversal order

## Example

Given this tree:
```
      1
     / \
    2   3
   / \
  4   5
```

In-order traversal visits: 4 → 2 → 5 → 1 → 3

Output: `[4, 2, 5, 1, 3]`

## Test Cases

| Input Tree | Expected Output |
|------------|-----------------|
| `{value: 1, left: null, right: null}` | `[1]` |
| `{value: 1, left: {value: 2, left: null, right: null}, right: null}` | `[2, 1]` |
| `{value: 1, left: null, right: {value: 3, left: null, right: null}}` | `[1, 3]` |
| Complex tree (see run.xs) | `[4, 2, 5, 1, 3]` |
| `null` (empty tree) | `[]` |

## Algorithm

This implementation uses an **iterative approach** with an explicit stack:

1. Initialize an empty result array and an empty stack
2. Start with the root node as current
3. While current is not null or stack is not empty:
   - Push all left children to stack (go as left as possible)
   - Pop a node from stack, add its value to result
   - Move to the right child and repeat

The iterative approach avoids potential stack overflow with deeply nested trees that a recursive solution might encounter.

## Complexity
- **Time:** O(n) where n is the number of nodes
- **Space:** O(h) where h is the height of the tree (for the stack)
