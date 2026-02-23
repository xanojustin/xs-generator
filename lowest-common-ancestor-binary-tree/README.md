# Lowest Common Ancestor of a Binary Tree

## Problem

Given a binary tree, find the **lowest common ancestor (LCA)** of two given nodes in the tree.

The lowest common ancestor is defined between two nodes `p` and `q` as the lowest (deepest) node in the tree that has both `p` and `q` as descendants (where we allow a node to be a descendant of itself).

### Definition

According to the definition of LCA on Wikipedia: "The lowest common ancestor of two nodes `p` and `q` in a tree `T` is the lowest (i.e., deepest) node that has both `p` and `q` as descendants (where we allow a node to be a descendant of itself)."

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/lowest_common_ancestor_binary_tree.xs`):** Contains the solution logic

## Function Signature

- **Input:**
  - `nodes` (json): Array of tree nodes where each node has:
    - `value` (int): The node's value
    - `left` (int | null): Index of the left child in the nodes array, or null
    - `right` (int | null): Index of the right child in the nodes array, or null
  - `root_index` (int): Index of the root node in the nodes array
  - `p_value` (int): Value of the first target node
  - `q_value` (int): Value of the second target node

- **Output:**
  - (json | null): The LCA node object, or null if not found. The node object contains `value`, `left`, and `right`.

## Algorithm

The solution uses a two-phase approach:

1. **Build Parent Mapping:** Traverse the tree from root to build a map of each node's value to its parent's value, along with a value-to-index mapping for quick lookups.

2. **Find LCA:** 
   - Build the path from node `p` up to the root
   - Walk up from node `q` to the root, checking at each step if the current node exists in `p`'s path
   - The first match is the LCA

**Time Complexity:** O(N) where N is the number of nodes (single traversal to build map + path walks)
**Space Complexity:** O(N) for the parent map and path storage

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| Tree with root=3, p=5, q=1 | Node with value 3 (root is LCA) |
| Tree with root=3, p=5, q=4 | Node with value 5 (5 is ancestor of 4) |
| Tree with root=3, p=6, q=4 | Node with value 5 (5 is LCA of 6 and 4) |
| Empty tree | null |
| p or q not in tree | null |

### Test Tree Structure

```
        3
       / \
      5   1
     / \   \
    6   2   0
       / \
      7   4
```

- **LCA(5, 1) = 3** (root is ancestor of both)
- **LCA(5, 4) = 5** (5 is ancestor of itself and 4)
- **LCA(6, 4) = 5** (5 is ancestor of both 6 and 4)
- **LCA(7, 0) = 3** (root is ancestor of both)
