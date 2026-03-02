# Binary Tree Vertical Order Traversal

## Problem

Given a binary tree, return the **vertical order traversal** of its nodes' values.

For each node:
- Its position is determined by a column index (horizontal distance from root)
- Root has column 0
- Left child is at column - 1 from its parent
- Right child is at column + 1 from its parent

Return the node values grouped by their column, ordered from leftmost column to rightmost column. Within each column, nodes should appear from top to bottom (level by level).

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/vertical_order.xs`):** Contains the solution logic using BFS traversal

## Function Signature

- **Input:**
  - `root` (object): The root node of the binary tree with structure:
    - `val` (int): The node's value
    - `left` (object?, nullable): Left child node with same structure
    - `right` (object?, nullable): Right child node with same structure
- **Output:**
  - `int[][]`: Array of arrays where each inner array contains values for one vertical column, ordered left to right

## Algorithm

1. Use BFS (level-order) traversal to ensure top-to-bottom ordering
2. Track each node's column index during traversal
3. Use a hash map to group values by column
4. Track minimum and maximum column indices
5. Build result by iterating from min to max column

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `{ val: 3, left: { val: 9 }, right: { val: 20, left: { val: 15 }, right: { val: 7 } } }` | `[[9], [3, 15], [20], [7]]` |
| `{ val: 1 }` (single node) | `[[1]]` |
| `null` (empty tree) | `[]` |
| `{ val: 1, left: { val: 2, left: { val: 4 } }, right: { val: 3, right: { val: 5 } } }` | `[[4], [2], [1, 3], [5]]` |

### Test Case Explanations

**Example 1:** Tree with root 3, left child 9, right subtree (20 with children 15 and 7)
```
    3
   / \
  9  20
    /  \
   15   7
```
- Column -1: [9]
- Column 0: [3, 15] (3 at row 0, 15 at row 2)
- Column 1: [20]
- Column 2: [7]

**Example 2:** Single node returns single column with that value

**Example 3:** Empty tree returns empty array

**Example 4:** Deep left and right paths
```
    1
   / \
  2   3
 /     \
4       5
```
- Column -2: [4]
- Column -1: [2]
- Column 0: [1, 3]
- Column 1: [5]
