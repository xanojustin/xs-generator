# Find Mode in Binary Search Tree

## Problem
Given the root of a binary search tree (BST) with duplicates, return all the mode(s) (i.e., the most frequently occurring element) in it.

If the tree has more than one mode, return them in any order.

Assume a BST is defined as follows:
- The left subtree of a node contains only nodes with keys less than or equal to the node's key.
- The right subtree of a node contains only nodes with keys greater than or equal to the node's key.
- Both the left and right subtrees must also be binary search trees.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/find_mode_in_bst.xs`):** Contains the solution logic

## Function Signature
- **Input:**
  - `root` (object): Root node of the binary search tree with structure:
    - `val` (int): The node's value
    - `left` (object, optional): Left child node
    - `right` (object, optional): Right child node
- **Output:** 
  - (int[]): Array of mode value(s) - the most frequently occurring element(s) in the BST

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `root = [1,null,2,2]` | `[2]` |
| `root = [0]` | `[0]` |
| `root = [2,1,2]` | `[2]` |
| `root = [1,1,2,2]` | `[1,2]` (both appear twice) |
| `root = []` (empty) | `[]` |
| `root = [5,3,6,2,3,6,6]` | `[3,6]` (both appear twice) |

## Algorithm
The solution uses an iterative in-order traversal to visit all nodes in the BST:

1. **Handle edge case:** Return empty array if root is null
2. **In-order traversal:** Use a stack to traverse the tree iteratively (left -> root -> right)
3. **Frequency counting:** Build a frequency map counting occurrences of each value
4. **Track maximum:** Keep track of the highest frequency encountered
5. **Collect modes:** After traversal, collect all values that have the maximum frequency

The iterative approach avoids potential stack overflow issues with deep recursion on large trees.

## Complexity
- **Time Complexity:** O(n) where n is the number of nodes - we visit each node once
- **Space Complexity:** O(n) for the frequency map and stack
