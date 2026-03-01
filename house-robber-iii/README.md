# House Robber III

## Problem
The thief has found himself a new place for thievery again. There is only one entrance to this area, called `root`.

Besides the `root`, each house has one and only one parent house. After a tour, the smart thief realized that all houses in this place form a binary tree. It will automatically contact the police if two directly-linked houses (parent-child) were broken into on the same night.

Given the `root` of the binary tree representing the houses, return the maximum amount of money the thief can rob without alerting the police.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/house-robber-iii.xs`):** Contains the solution logic

## Function Signature
- **Input:** `tree` (object) - A binary tree node with:
  - `val` (int): Value/money at this node
  - `left` (object?): Left child node (nullable)
  - `right` (object?): Right child node (nullable)
- **Output:** `int` - Maximum amount of money that can be robbed

## Algorithm
Use Depth-First Search (DFS) with dynamic programming. For each node, compute two values:
1. **Skip this node:** Maximum money if we don't rob this house = max(left child options) + max(right child options)
2. **Rob this node:** Maximum money if we rob this house = node value + skip left child + skip right child

The recurrence is:
- `rob(node) = node.val + skip(left) + skip(right)`
- `skip(node) = max(rob(left), skip(left)) + max(rob(right), skip(right))`

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| Tree [3,2,3,null,3,null,1] | 7 |
| Tree [3,4,5,1,3,null,1] | 9 |
| Empty tree (null) | 0 |
| Single node [1] | 1 |
| Two nodes [1,2] | 2 |

### Detailed Test Cases

**Case 1: Example 1**
```
      3
     / \
    2   3
     \   \
      3   1
```
- Optimal: Rob nodes with values 3 (root) + 3 (right child of 2) + 1 (right child of 3) = 7

**Case 2: Example 2**
```
      3
     / \
    4   5
   / \   \
  1   3   1
```
- Optimal: Rob nodes with values 4 + 5 = 9

**Case 3: Edge case - empty tree**
- Returns 0

**Case 4: Edge case - single node**
- Returns the node's value

**Case 5: Edge case - two nodes**
- Must choose the maximum of the two
