# Symmetric Tree

## Problem
Given the root of a binary tree, check whether it is a mirror of itself (i.e., symmetric around its center).

A binary tree is symmetric if the left subtree is a mirror reflection of the right subtree. Two trees are mirrors of each other if:
1. Their two roots have the same value
2. The right subtree of each tree is a mirror reflection of the left subtree of the other tree

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/is_symmetric.xs`):** Contains the solution logic

## Function Signature
- **Input:** `tree` (int[]) - Array representation of binary tree where index i has children at positions 2i+1 (left) and 2i+2 (right). `null` represents a missing node.
- **Output:** `result` (boolean) - `true` if the tree is symmetric, `false` otherwise

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[1, 2, 2, 3, 4, 4, 3]` | `true` | Symmetric tree - root 1, left and right subtrees are mirrors |
| `[1, 2, 2, null, 3, null, 3]` | `false` | Not symmetric - structure differs |
| `[]` | `true` | Empty tree is symmetric by definition |
| `[1]` | `true` | Single node tree is symmetric |
| `[1, 2, 2, 3, null, null, 3]` | `true` | Symmetric with some null children |
| `[1, 2, 3]` | `false` | Root's left and right children have different values |

## Algorithm

The solution uses an iterative approach with a manual stack to avoid recursion limits:

1. Start by comparing the root with itself
2. For each pair of nodes being compared:
   - If both are null, they're symmetric
   - If only one is null, not symmetric
   - If values differ, not symmetric
   - If values match, push their cross children onto the stack:
     - Left child's left vs Right child's right
     - Left child's right vs Right child's left
3. Continue until stack is empty or asymmetry is found

## Complexity
- **Time Complexity:** O(n) where n is the number of nodes
- **Space Complexity:** O(h) where h is the height of the tree (stack size)
