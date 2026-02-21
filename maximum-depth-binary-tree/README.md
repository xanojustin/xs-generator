# Maximum Depth of Binary Tree

## Problem
Given the `root` of a binary tree, return its **maximum depth**.

A binary tree's **maximum depth** is the number of nodes along the longest path from the root node down to the farthest leaf node.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/maximum_depth_binary_tree.xs`):** Contains the solution logic

## Function Signature
- **Input:** 
  - `tree` (json): Binary tree node with `val`, `left`, and `right` properties. `null` represents an empty tree.
    - `val`: The value stored at the node
    - `left`: Left child subtree (json object or null)
    - `right`: Right child subtree (json object or null)
- **Output:** 
  - `int`: The maximum depth of the tree (number of nodes along the longest path)

## Approach
This solution uses **recursion**:
1. Base case: If the tree is `null`, return depth 0
2. Recursively calculate the maximum depth of the left subtree
3. Recursively calculate the maximum depth of the right subtree
4. Return 1 + the maximum of left and right depths

Time Complexity: O(n) where n is the number of nodes
Space Complexity: O(h) where h is the height of the tree (recursion stack)

## Test Cases

| Input | Expected Output | Description |
|-------|-----------------|-------------|
| `{val: 3, left: {val: 9, left: null, right: null}, right: {val: 20, left: {val: 15, left: null, right: null}, right: {val: 7, left: null, right: null}}}` | 3 | Balanced tree with 3 levels |
| `{val: 1, left: {val: 2, left: {val: 3, left: null, right: null}, right: null}, right: null}` | 3 | Left-skewed tree |
| `{val: 1, left: null, right: null}` | 1 | Single node tree |
| `null` | 0 | Empty tree |
| `{val: 1, left: {val: 2, left: null, right: null}, right: {val: 3, left: null, right: null}}` | 2 | Perfect binary tree of height 2 |

### Visual Representations

**Test Case 1 (Balanced, depth 3):**
```
      3
     / \
    9  20
      /  \
     15   7
```

**Test Case 2 (Left-skewed, depth 3):**
```
    1
   /
  2
 /
3
```

**Test Case 3 (Single node, depth 1):**
```
    1
```

**Test Case 4 (Empty, depth 0):**
```
    null
```
