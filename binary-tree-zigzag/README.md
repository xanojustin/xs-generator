# Binary Tree Zigzag Level Order Traversal

## Problem

Given the root of a binary tree, return the zigzag level order traversal of its nodes' values. The traversal should go level by level, alternating between left-to-right and right-to-left at each level.

- Level 1: left-to-right
- Level 2: right-to-left  
- Level 3: left-to-right
- And so on...

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/zigzag_level_order.xs`):** Contains the solution logic

## Function Signature

- **Input:** 
  - `tree` (object): The root node of a binary tree with structure `{ val: int?, left: object?, right: object? }`
- **Output:** 
  - `int[][]`: Array of arrays, where each inner array represents one level of the tree in zigzag order

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[3,9,20,null,null,15,7]` | `[[3],[20,9],[15,7]]` |
| `[1]` | `[[1]]` |
| `[]` (empty tree) | `[]` |
| `[1,2,3,4,null,null,5]` | `[[1],[3,2],[4,5]]` |

### Test Case Details

**Case 1: Standard 3-level tree**
```
    3
   / \
  9  20
    /  \
   15   7
```
- Level 0 (L→R): [3]
- Level 1 (R→L): [20, 9]
- Level 2 (L→R): [15, 7]
- Result: `[[3],[20,9],[15,7]]`

**Case 2: Single node**
- Result: `[[1]]`

**Case 3: Empty tree**
- Result: `[]`

**Case 4: Unbalanced tree**
```
      1
     / \
    2   3
   /       \
  4         5
```
- Level 0 (L→R): [1]
- Level 1 (R→L): [3, 2]
- Level 2 (L→R): [4, 5]
- Result: `[[1],[3,2],[4,5]]`

## Algorithm

The solution uses Breadth-First Search (BFS) with a queue:

1. Handle empty tree case (return empty array)
2. Initialize queue with root node and direction flag (`left_to_right = true`)
3. While queue is not empty:
   - Record current level size
   - Process all nodes at current level
   - Add values to current level array
   - Enqueue left and right children
   - Add current level to result (reversed if `left_to_right` is false)
   - Toggle direction flag
4. Return result array
