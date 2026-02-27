# Binary Tree Maximum Path Sum

## Problem

Given the root of a binary tree, return the **maximum path sum** of any non-empty path.

A **path** is any sequence of nodes from some starting node to any node in the tree along parent-child connections. The path must contain at least one node and does not need to go through the root.

The path sum of a path is the sum of the node's values in the path.

### Example 1
```
     1
    / \
   2   3
```
Input: root = {val: 1, left: {val: 2}, right: {val: 3}}
Output: 6
Explanation: The optimal path is 2 → 1 → 3 with sum 2 + 1 + 3 = 6

### Example 2
```
    -10
    /  \
   9   20
      /  \
     15   7
```
Input: root = {val: -10, left: {val: 9}, right: {val: 20, left: {val: 15}, right: {val: 7}}}
Output: 42
Explanation: The optimal path is 15 → 20 → 7 with sum 15 + 20 + 7 = 42
```

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/binary_tree_maximum_path_sum.xs`):** Contains the main solution logic that invokes the helper
- **Function (`function/max_path_helper.xs`):** Recursive helper that computes max path sums

## Function Signature

### binary_tree_maximum_path_sum
- **Input:** `tree` (json) - Binary tree node with `val`, `left`, and `right` properties. Use `null` for empty tree.
- **Output:** (int) - The maximum path sum of any non-empty path in the tree

### max_path_helper
- **Input:** `tree` (json) - Binary tree node
- **Output:** (json object) - Object containing:
  - `max_ending_here`: Maximum path sum starting at current node and going downward (can extend to parent)
  - `max_overall`: Maximum path sum found anywhere in this subtree

## Algorithm

This solution uses a **post-order DFS (depth-first search)** approach:

1. For each node, recursively compute the maximum path sums from left and right subtrees
2. Calculate two values:
   - **max_ending_here**: Maximum sum of a path starting at current node and extending downward (can continue to parent). This is max(node, node + left, node + right) - negative gains are treated as 0.
   - **max_through_node**: Maximum sum of a path going through current node as the highest point (node + left + right). This cannot extend upward.
3. The maximum overall is the max of:
   - max_through_node (path using current node as peak)
   - max_overall from left subtree
   - max_overall from right subtree

## Complexity

- **Time Complexity:** O(n) where n is the number of nodes (visit each node once)
- **Space Complexity:** O(h) where h is the height of the tree (recursion stack)

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `{val: 1, left: {val: 2}, right: {val: 3}}` | 6 |
| `{val: -10, left: {val: 9}, right: {val: 20, left: {val: 15}, right: {val: 7}}}` | 42 |
| `{val: -3}` | -3 |
| `{val: 2, left: {val: -1}}` | 2 |
| `{val: 1, left: {val: -2, left: {val: 1}, right: {val: 3}}, right: {val: -3, left: {val: -2}}}` | 3 |

### Test Case Explanations:

1. **Basic case:** Path 2 → 1 → 3 = 6
2. **Mixed positive/negative:** Path 15 → 20 → 7 = 42 (avoids -10)
3. **Single negative node:** Must take the node itself = -3
4. **Negative child ignored:** Path is just root = 2 (avoids -1)
5. **Complex tree:** Path 3 → -2 → 1 = 3 (best path avoiding negatives)
