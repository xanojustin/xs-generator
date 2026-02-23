# Construct Binary Tree from Preorder and Inorder Traversal

## Problem
Given two integer arrays `preorder` and `inorder` where:
- `preorder` is the **preorder traversal** of a binary tree (root → left → right)
- `inorder` is the **inorder traversal** of the same binary tree (left → root → right)

Construct and return the binary tree as a nested object structure.

**Key Insight:**
- The first element in preorder is always the **root** of the tree (or subtree)
- In the inorder array, elements to the left of the root are in the **left subtree**, elements to the right are in the **right subtree**
- Use the size of the left subtree from inorder to determine the preorder range for the left subtree

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/build_tree.xs`):** Contains the solution logic using an iterative stack-based approach

## Function Signature
- **Input:**
  - `preorder` (int[]): Preorder traversal array where the first element is the root
  - `inorder` (int[]): Inorder traversal array where root divides left/right subtrees
- **Output:**
  - Object representing the root node with structure: `{ val: int, left: object|null, right: object|null }`
  - Returns `null` for empty input arrays

## Test Cases

| Preorder | Inorder | Expected Output |
|----------|---------|-----------------|
| `[3, 9, 20, 15, 7]` | `[9, 3, 15, 20, 7]` | `{ val: 3, left: { val: 9, left: null, right: null }, right: { val: 20, left: { val: 15, left: null, right: null }, right: { val: 7, left: null, right: null } } }` |
| `[-1]` | `[-1]` | `{ val: -1, left: null, right: null }` |
| `[]` | `[]` | `null` |
| `[1, 2, 3]` | `[3, 2, 1]` | `{ val: 1, left: { val: 2, left: { val: 3, left: null, right: null }, right: null }, right: null }` (skewed left tree) |

**Example Tree Visualization:**
```
    3
   / \
  9  20
    /  \
   15   7
```

**Algorithm Complexity:**
- Time: O(n) where n is the number of nodes
- Space: O(n) for the hashmap and stack

**Implementation Notes:**
- Uses an iterative approach with an explicit stack to simulate recursion
- Builds a hashmap for O(1) inorder index lookups
- Handles edge cases (empty arrays, single element)
