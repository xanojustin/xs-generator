# Flatten Binary Tree to Linked List

## Problem
Given the root of a binary tree, flatten the tree into a linked list in-place.

The "linked list" should use the same TreeNode structure where:
- The `right` child pointer points to the next node in the list
- The `left` child pointer is always `null`
- The order of nodes in the linked list should match the pre-order traversal of the binary tree

**Constraints:**
- The number of nodes in the tree is in the range `[0, 2000]`
- `-100 <= Node.val <= 100`
- Must be done **in-place** with O(1) extra space (Morris traversal approach)

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/flatten_tree.xs`):** Contains the Morris traversal solution logic

## Function Signature
- **Input:** 
  - `tree` (object) - Binary tree node with properties:
    - `val` (int) - Node value
    - `left` (object|null) - Left child
    - `right` (object|null) - Right child
- **Output:** 
  - (object) - The root of the flattened linked list (same node structure, left pointers null, right pointers form the list)

## Algorithm
This solution uses **Morris Traversal** to achieve O(1) space complexity:

1. Start at the root node
2. If the current node has a left child:
   - Find the rightmost node in the left subtree
   - Connect that rightmost node's right pointer to the current node's right child
   - Move the current node's left subtree to the right
   - Set the current node's left pointer to null
3. Move to the right child and repeat

This effectively "rotates" the left subtree to become the right subtree while maintaining pre-order order.

**Time Complexity:** O(n) - each node is visited at most twice
**Space Complexity:** O(1) - only uses a few pointers

## Test Cases

| Input Tree | Expected Output (as right-linked list) |
|-----------|----------------------------------------|
| `[1,2,5,3,4,null,6]` | `[1,null,2,null,3,null,4,null,5,null,6]` |
| `[]` (empty) | `[]` |
| `[0]` (single node) | `[0]` |
| `[1,2,null,3,null,4,null]` (skewed left) | `[1,null,2,null,3,null,4]` |

### Visual Example

**Input:**
```
    1
   / \
  2   5
 / \   \
3   4   6
```

**Output (as linked list):**
```
1
 \
  2
   \
    3
     \
      4
       \
        5
         \
          6
```

Which represents: `1 → 2 → 3 → 4 → 5 → 6`

## References
- [LeetCode 114 - Flatten Binary Tree to Linked List](https://leetcode.com/problems/flatten-binary-tree-to-linked-list/)
