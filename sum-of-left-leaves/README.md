# Sum of Left Leaves

## Problem
Given the root of a binary tree, return the sum of all left leaves.

A **leaf** is a node with no children. A **left leaf** is a leaf that is the left child of its parent.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/sum_of_left_leaves.xs`):** Contains the solution logic using iterative DFS

## Function Signature
- **Input:** 
  - `tree` (json): A binary tree node object with properties:
    - `val` (int): The value of the node
    - `left` (json/null): The left child node or null
    - `right` (json/null): The right child node or null
- **Output:** 
  - `sum` (int): The sum of all left leaf values in the tree

## Test Cases

| Input Tree | Expected Output | Explanation |
|------------|-----------------|-------------|
| `{val: 3, left: {val: 9, left: null, right: null}, right: {val: 20, left: {val: 15, left: null, right: null}, right: {val: 7, left: null, right: null}}}` | 24 | Left leaves are 9 and 15. Sum = 9 + 15 = 24 |
| `null` | 0 | Empty tree has no leaves |
| `{val: 1, left: null, right: null}` | 0 | Root is not a left child, so sum is 0 |
| `{val: 1, left: {val: 2, left: null, right: null}, right: null}` | 2 | Single left leaf with value 2 |
| `{val: 1, left: {val: 2, left: {val: 4, left: null, right: null}, right: {val: 5, left: null, right: null}}, right: {val: 3, left: null, right: null}}` | 4 | Only left leaf is 4 (node 2 is not a leaf because it has children) |

## Algorithm
The solution uses an iterative Depth-First Search (DFS) approach:
1. Use a stack to track nodes along with a flag indicating if they are left children
2. For each node, check if it's a left leaf (is_left=true AND no children)
3. If it's a left leaf, add its value to the sum
4. Push right child first, then left child (so left is processed first in DFS order)
5. Continue until stack is empty
