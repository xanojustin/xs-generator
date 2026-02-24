# Binary Tree Post-Order Traversal

## Problem
Given a binary tree, return the post-order traversal of its node values.

Post-order traversal visits nodes in the following order:
1. Left subtree (all nodes)
2. Right subtree (all nodes)
3. Root node

## Structure
- **Run Job (`run.xs`):** Calls the solution function with a sample binary tree
- **Function (`function/binary_tree_postorder.xs`):** Contains the iterative post-order traversal implementation

## Function Signature
- **Input:**
  - `nodes` (json): Array of tree nodes where each node is an object with:
    - `value` (int): The node's value
    - `left` (int | null): Index of left child in the array, or null
    - `right` (int | null): Index of right child in the array, or null
  - `root_index` (int): Index of the root node in the nodes array
- **Output:**
  - `int[]`: Array of values in post-order traversal order

## Example

Given this tree:
```
      1
     / \
    2   3
   / \
  4   5
```

Post-order traversal visits: 4 → 5 → 2 → 3 → 1

Output: `[4, 5, 2, 3, 1]`

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `nodes: [{value: 1, left: null, right: null}], root_index: 0` | `[1]` |
| `nodes: [{value: 1, left: 1, right: null}, {value: 2, left: null, right: null}], root_index: 0` | `[2, 1]` |
| `nodes: [{value: 1, left: null, right: 1}, {value: 3, left: null, right: null}], root_index: 0` | `[3, 1]` |
| Complex tree (see run.xs) | `[4, 5, 2, 3, 1]` |
| Empty tree: `nodes: [], root_index: 0` | `[]` |

## Algorithm

This implementation uses an **iterative two-stack approach**:

1. Initialize an empty result array, a processing stack, and an output stack
2. Push the root index onto the processing stack
3. While the processing stack is not empty:
   - Pop a node index from the processing stack
   - Push it onto the output stack
   - Push the left child onto the processing stack (if exists)
   - Push the right child onto the processing stack (if exists)
4. Process the output stack in reverse order to get post-order traversal

The key insight is that by pushing left before right onto the processing stack, and then reversing the output stack, we achieve the post-order: left → right → root.

## Complexity
- **Time:** O(n) where n is the number of nodes
- **Space:** O(n) for the two stacks in the worst case
