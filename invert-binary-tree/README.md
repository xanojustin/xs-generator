# Invert Binary Tree

## Problem
Invert a binary tree by swapping the left and right children of every node.

Given the root of a binary tree, invert the tree and return its root. Inverting means that for every node, its left and right subtrees are swapped.

### Example

Original tree:
```
     4
   /   \
  2     7
 / \   / \
1   3 6   9
```

Inverted tree:
```
     4
   /   \
  7     2
 / \   / \
9   6 3   1
```

## Structure
- **Run Job (`run.xs`):** Calls the solution function with a sample binary tree
- **Function (`function/invert_binary_tree.xs`):** Contains the recursive solution logic

## Function Signature
- **Input:** 
  - `tree` (json): A binary tree node object with the following structure:
    - `val`: The node's value (any type)
    - `left`: Left child node (json or null)
    - `right`: Right child node (json or null)
- **Output:** 
  - (json): The root of the inverted binary tree with the same structure

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `{val: 4, left: {val: 2, left: {val: 1}, right: {val: 3}}, right: {val: 7, left: {val: 6}, right: {val: 9}}}` | `{val: 4, left: {val: 7, left: {val: 9}, right: {val: 6}}, right: {val: 2, left: {val: 3}, right: {val: 1}}}` |
| `null` | `null` |
| `{val: 1}` | `{val: 1}` |
| `{val: 1, left: {val: 2}, right: {val: 3}}` | `{val: 1, left: {val: 3}, right: {val: 2}}` |

### Test Case Descriptions
1. **Full tree:** A complete binary tree with multiple levels - all children should be swapped at every level
2. **Empty tree:** Null input should return null
3. **Single node:** A tree with just one node should return the same node
4. **Simple tree:** A tree with just root and two children - children should be swapped

## Algorithm
The solution uses a **recursive approach**:
1. **Base case:** If the input tree is `null`, return `null`
2. **Recursive case:**
   - Store the current node's value
   - Recursively invert the left subtree
   - Recursively invert the right subtree
   - Return a new node with the original value, but with left and right swapped

## Time & Space Complexity
- **Time Complexity:** O(n) where n is the number of nodes in the tree - we visit each node once
- **Space Complexity:** O(h) where h is the height of the tree - due to recursion stack
