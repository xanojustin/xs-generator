# Minimum Depth of Binary Tree

## Problem

Given a binary tree, find its minimum depth.

The **minimum depth** is the number of nodes along the shortest path from the root node down to the nearest leaf node.

**Note:** A leaf is a node with no children.

### Example

```
    3
   / \
  9  20
    /  \
   15   7
```

In this tree:
- Node 9 is a leaf at depth 2
- Nodes 15 and 7 are leaves at depth 3
- The minimum depth is **2** (path: 3 → 9)

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/minimum_depth_binary_tree.xs`):** Contains the BFS solution logic

## Function Signature

- **Input:** `root` (json) - A binary tree node with properties:
  - `val`: The node's value
  - `left`: Left child node (or null)
  - `right`: Right child node (or null)
  
- **Output:** `int` - The minimum depth of the tree (0 for empty tree)

## Algorithm

This solution uses **Breadth-First Search (BFS)** with a queue:

1. If the tree is empty, return 0
2. Initialize a queue with the root node at depth 1
3. Process nodes level by level:
   - If a node has no children (leaf), return its depth
   - Otherwise, add its children to the queue with depth + 1
4. The first leaf found gives the minimum depth

**Why BFS?** BFS is optimal for this problem because it explores nodes level by level. The first leaf we encounter is at the minimum depth, so we can stop immediately without traversing the entire tree.

## Test Cases

| Input | Expected Output | Description |
|-------|-----------------|-------------|
| `null` | 0 | Empty tree edge case |
| `{ val: 1, left: null, right: null }` | 1 | Single node tree |
| `{ val: 3, left: { val: 9, left: null, right: null }, right: { val: 20, left: { val: 15, left: null, right: null }, right: { val: 7, left: null, right: null } } }` | 2 | Balanced tree with left leaf at depth 2 |
| `{ val: 1, left: { val: 2, left: { val: 4, left: null, right: null }, right: null }, right: { val: 3, left: null, right: null } }` | 2 | Left-skewed tree, right side has leaf at depth 2 |

### Test Case Details

**Test 1: Empty Tree**
- Input: `null`
- Expected: `0`
- A null tree has no nodes, so depth is 0

**Test 2: Single Node**
- Input: Root with no children
- Expected: `1`
- The root itself is a leaf, so depth is 1

**Test 3: Balanced Tree**
```
    3
   / \
  9  20
    /  \
   15   7
```
- Expected: `2`
- Node 9 is a leaf at depth 2, which is the minimum

**Test 4: Skewed Tree**
```
    1
   / \
  2   3
 /
4
```
- Expected: `2`
- Node 3 is a leaf at depth 2, even though node 4 is at depth 3
