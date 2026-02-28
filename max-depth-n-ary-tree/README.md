# Maximum Depth of N-ary Tree

## Problem

Given the root of an n-ary tree, return its maximum depth.

Maximum depth is the number of nodes along the longest path from the root node down to the farthest leaf node.

An n-ary tree is a tree where each node can have any number of children (0 or more), unlike a binary tree which has at most 2 children.

### N-ary Tree Node Structure
Each node has:
- `val`: The value stored in the node (integer)
- `children`: An array of child nodes (can be empty)

## Structure

- **Run Job (`run.xs`):** Calls the `max_depth_nary_tree_tests` function with no inputs
- **Function (`function/max_depth_nary_tree.xs`):** Contains the recursive solution for finding maximum depth
- **Test Function (`function/max_depth_nary_tree_tests.xs`):** Runs multiple test cases and validates results

## Function Signature

- **Input:**
  - `tree` (json): An n-ary tree node with `val` (int) and `children` (array of nodes), or `null` for an empty tree

- **Output:**
  - Returns an integer representing the maximum depth of the tree
  - Returns 0 for an empty tree (null)
  - Returns 1 for a single node with no children

## Algorithm

The solution uses a recursive approach:
1. **Base case:** If tree is null, return 0
2. **Leaf case:** If node has no children, return 1
3. **Recursive case:** 
   - Recursively calculate the depth of each child
   - Find the maximum depth among all children
   - Return 1 + max_child_depth

## Test Cases

| Test | Description | Tree Structure | Expected Output |
|------|-------------|----------------|-----------------|
| Empty tree | null input | `null` | 0 |
| Single node | One node, no children | `{val: 1, children: []}` | 1 |
| Depth 2 | Root with 3 children | `{val: 1, children: [{val: 2, children: []}, {val: 3, children: []}, {val: 4, children: []}]}` | 2 |
| Depth 3 | Mixed structure | Root with one node having 2 children | 3 |
| Depth 4 | Deep linear chain | Linear chain of 4 nodes | 4 |
| Unbalanced | Different depths per branch | Root with shallow and deep branches | 4 |

## Example Trees

### Depth 2
```
      1
    / | \
   2  3  4
```

### Depth 3
```
      1
    /   \
   2     3
  / \
 4   5
```

### Depth 4 (linear)
```
    1
   /
  2
 /
4
|
5
```
