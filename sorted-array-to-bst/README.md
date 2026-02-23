# Sorted Array to BST

## Problem
Given an integer array `nums` where the elements are sorted in ascending order, convert it to a height-balanced binary search tree (BST).

A height-balanced binary tree is a binary tree in which the depth of the two subtrees of every node never differs by more than one.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test input `[-10, -3, 0, 5, 9]`
- **Function (`function/sorted_array_to_bst.xs`):** Contains the solution logic using an iterative post-order traversal approach

## Function Signature
- **Input:** `int[] nums` - A sorted array of integers in ascending order
- **Output:** `object` - The root node of the height-balanced BST, where each node has:
  - `val`: The integer value
  - `left`: Left child node (or null)
  - `right`: Right child node (or null)

## Approach
Since XanoScript doesn't support recursive function calls, this implementation uses an **iterative post-order traversal** with an explicit stack:

1. **Work Stack:** Tracks ranges `[left, right]` that need processing
2. **Results Map:** Caches completed subtrees using keys `"left,right"`
3. **Post-order Processing:** Children are processed before their parent
4. **Tree Construction:** Each node is built by combining its left and right subtrees from the cache

For each range `[left, right]`:
- Calculate middle index: `mid = (left + right) / 2`
- The middle element becomes the root
- Recursively build left subtree from `[left, mid-1]`
- Recursively build right subtree from `[mid+1, right]`

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[-10, -3, 0, 5, 9]` | `{ "val": 0, "left": { "val": -3, "left": { "val": -10, "left": null, "right": null }, "right": null }, "right": { "val": 9, "left": { "val": 5, "left": null, "right": null }, "right": null } }` |
| `[1, 3]` | `{ "val": 3, "left": { "val": 1, "left": null, "right": null }, "right": null }` or `{ "val": 1, "left": null, "right": { "val": 3, "left": null, "right": null } }` |
| `[]` | `null` |
| `[0]` | `{ "val": 0, "left": null, "right": null }` |
| `[1, 2, 3, 4, 5, 6, 7]` | Balanced BST with 4 as root |

## Complexity Analysis
- **Time Complexity:** O(n) - Each element is processed once
- **Space Complexity:** O(n) - For the results cache and explicit stack
