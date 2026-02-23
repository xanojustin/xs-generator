# Diameter of Binary Tree

## Problem

Given the root of a binary tree, return the **diameter** of the tree.

The **diameter** of a binary tree is the **length** of the longest path between any two nodes in the tree. This path may or may not pass through the root.

The **length** of a path between two nodes is represented by the number of edges between them.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/diameter_of_binary_tree.xs`):** Contains the solution logic

## Function Signature

- **Input:** 
  - `tree` (json): A binary tree node with `val`, `left`, and `right` properties. `null` represents an empty tree.
  
- **Output:** 
  - Returns an object with:
    - `diameter` (int): The length of the longest path between any two nodes
    - `height` (int): The height of the tree (used for internal calculations)

## Algorithm

The solution uses a post-order traversal approach:

1. For each node, recursively calculate:
   - The diameter and height of the left subtree
   - The diameter and height of the right subtree

2. The path through the current node = left_height + right_height

3. The diameter at the current node is the maximum of:
   - Path through the current node (left_height + right_height)
   - Diameter of the left subtree
   - Diameter of the right subtree

4. Return both the diameter and height to the parent call

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| Tree: `[1,2,3,4,5]` (root with two children, each with one child) | `{ diameter: 3, height: 3 }` |
| Tree: `[1,2,null,3,null,4]` (left-skewed tree) | `{ diameter: 3, height: 4 }` |
| Tree: `[1]` (single node) | `{ diameter: 0, height: 1 }` |
| Tree: `null` (empty tree) | `{ diameter: 0, height: 0 }` |
| Tree: `[1,2,3,4,5,6,7]` (complete binary tree) | `{ diameter: 4, height: 3 }` |

### Visual Examples

**Example 1:** Diameter = 3
```
      1
     / \
    2   3
   / \
  4   5
```
Path: 4 → 2 → 1 → 3 (3 edges)

**Example 2:** Diameter = 3
```
    1
   /
  2
 /
3
/
4
```
Path: 4 → 3 → 2 → 1 (3 edges)

**Example 3:** Diameter = 0
```
  1
```
Single node, no edges

## Complexity Analysis

- **Time Complexity:** O(n) where n is the number of nodes in the tree. Each node is visited exactly once.
- **Space Complexity:** O(h) where h is the height of the tree, due to the recursion stack. In the worst case (skewed tree), this is O(n).