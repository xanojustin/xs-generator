# Path Sum II

## Problem
Given a binary tree and a target sum, find all root-to-leaf paths where each path's sum equals the given target sum.

A leaf is a node with no children. A root-to-leaf path is a path from the root node to any leaf node.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/path_sum_ii.xs`):** Contains the solution logic

## Function Signature
- **Input:**
  - `root` (object): Binary tree root node with properties:
    - `val` (int): Node value
    - `left` (object/null): Left child node
    - `right` (object/null): Right child node
  - `target_sum` (int): Target sum for root-to-leaf paths
- **Output:**
  - Array of arrays, where each inner array represents a root-to-leaf path whose sum equals `target_sum`

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| Tree: `[5,4,8,11,null,13,4,7,2,null,null,5,1]`, target: `22` | `[[5,4,11,2], [5,8,4,5]]` |
| Tree: `[1,2,3]`, target: `5` | `[]` |
| Tree: `[]` (empty), target: `0` | `[]` |
| Tree: `[1,2]`, target: `1` | `[]` |

### Test Case Details

**Basic Case:**
```
        5
       / \
      4   8
     /   / \
    11  13  4
   / \      / \
  7   2    5   1
```
Target: 22
Paths: 
- 5→4→11→2 = 22 ✓
- 5→8→4→5 = 22 ✓

**Edge Case - No valid paths:**
Single path sums don't match target.

**Edge Case - Empty tree:**
Returns empty array when root is null.

**Boundary Case - Single child:**
Only left child exists, path doesn't sum to target.
