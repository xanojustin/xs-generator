# Convert Sorted List to Binary Search Tree

## Problem
Given the head of a singly linked list where elements are sorted in ascending order, convert it to a height-balanced Binary Search Tree (BST).

For this problem, a height-balanced binary tree is defined as a binary tree in which the depth of the two subtrees of every node never differs by more than 1.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/convert_sorted_list_to_bst.xs`):** Entry point that prepares inputs and calls the helper
- **Function (`function/build_bst_helper.xs`):** Recursive function that builds the balanced BST

## Function Signature
- **Input:** `head` (int[]) - An array of integers sorted in ascending order, representing the linked list values
- **Output:** Object representing the root of the BST, with structure `{ val: int, left: object|null, right: object|null }`

## Approach
The solution uses a recursive divide-and-conquer approach:
1. Find the middle element of the current range - this becomes the root
2. Recursively build the left subtree from elements before the middle
3. Recursively build the right subtree from elements after the middle
4. Combine into a tree node with `val`, `left`, and `right` properties

This approach ensures the tree is height-balanced because we always choose the middle element as the root.

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[]` | `null` (empty tree) |
| `[-10, -3, 0, 5, 9]` | Balanced BST with root `0` |
| `[1, 3]` | Tree with root `3`, left child `1` |
| `[0]` | Single node tree with value `0` |

### Explanation of Test Cases
- **Empty list:** Returns `null` (no nodes to build tree from)
- **Odd length list:** Middle element becomes root (0 in example)
- **Even length list:** Lower middle chosen due to integer division
- **Single element:** Returns a tree with just that node

## Complexity
- **Time:** O(n) - Each element is visited exactly once
- **Space:** O(log n) - Recursion stack for balanced tree (height = log n)
