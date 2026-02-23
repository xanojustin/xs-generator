# Binary Tree Right Side View

## Problem

Given the root of a binary tree, imagine yourself standing on the **right side** of it. Return the values of the nodes you can see ordered from top to bottom.

The right side view consists of the rightmost node at each level of the tree.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/binary_tree_right_side_view.xs`):** Contains the solution logic using BFS level-order traversal

## Function Signature

- **Input:**
  - `nodes` (json): Array of tree nodes where each node is an object with:
    - `value`: The node's value (int)
    - `left`: Index of the left child node (int or null)
    - `right`: Index of the right child node (int or null)
  - `root_index` (int): Index of the root node in the nodes array
- **Output:** `int[]` - Array of values visible from the right side, top to bottom

## Algorithm

Uses **Breadth-First Search (BFS)** with level-order traversal:
1. Process the tree level by level
2. At each level, the last node processed is the rightmost node
3. Add the rightmost node's value to the result
4. Continue until all levels are processed

Time Complexity: O(n) - visits each node once  
Space Complexity: O(w) - where w is the maximum width of the tree

## Test Cases

| Input | Expected Output | Description |
|-------|-----------------|-------------|
| `nodes: [{value:1,left:1,right:2},{value:2,left:null,right:3},{value:3,left:null,right:4},{value:5,left:null,right:null},{value:4,left:null,right:null}]`, `root_index: 0` | `[1, 3, 4]` | Standard tree with right-leaning nodes |
| `nodes: [{value:1,left:null,right:null}]`, `root_index: 0` | `[1]` | Single node tree |
| `nodes: []`, `root_index: 0` | `[]` | Empty tree |
| `nodes: [{value:1,left:1,right:null},{value:2,left:2,right:null},{value:3,left:null,right:null}]`, `root_index: 0` | `[1, 2, 3]` | Left-skewed tree (only left children) |

### Visual Test Case 1
```
       1        ← visible (root)
      / \
     2   3      ← 3 visible (rightmost at level 1)
      \   \
       5   4    ← 4 visible (rightmost at level 2)
```
Right side view: `[1, 3, 4]`

### Visual Test Case 3 (Left-skewed)
```
    1       ← visible
   /
  2         ← visible
 /
3           ← visible
```
Right side view: `[1, 2, 3]`
