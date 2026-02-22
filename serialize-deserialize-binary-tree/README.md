# Serialize and Deserialize Binary Tree

## Problem
Design an algorithm to serialize and deserialize a binary tree. Serialization is the process of converting a data structure or object into a sequence of bits so that it can be stored in a file or memory buffer, or transmitted across a network connection link to be reconstructed later in the same or another computer environment.

Design an algorithm to serialize a binary tree into a string and deserialize the string back to the original tree structure.

**Key Requirements:**
- Serialization format should be compact
- The deserialization should reconstruct the exact same tree structure
- Handle edge cases like empty trees and single nodes

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/serialize_deserialize_tree.xs`):** Contains the solution logic

## Function Signature
- **Input:** 
  - `tree` (optional json): A binary tree node object with properties:
    - `val` (int): The node's value
    - `left` (json, optional): Left child node (same structure)
    - `right` (json, optional): Right child node (same structure)
  
- **Output:** Object containing:
  - `original`: The original tree input
  - `serialized` (text): Comma-separated string representation of the tree using level-order (BFS) traversal with "null" for empty nodes (trailing nulls are trimmed)
  - `deserialized` (object): The reconstructed tree from the serialized string

## Algorithm

### Serialization (BFS/Level-Order)
1. Use a queue for level-order traversal
2. For each node, add its value to the result
3. Add both children (even if null) to the queue
4. Convert null nodes to "null" string
5. Trim trailing nulls from the result

### Deserialization
1. Split the serialized string by commas
2. Create node objects for non-null tokens
3. Use array indexing: for node at index `i`, left child is at `2*i+1`, right at `2*i+2`
4. Link children to parents and return root

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `{val: 1, left: {val: 2}, right: {val: 3, left: {val: 4}, right: {val: 5}}}` | Serialized: `"1,2,3,null,null,4,5"` |
| `null` (empty tree) | Serialized: `""` (empty string) |
| `{val: 1}` (single node) | Serialized: `"1"` |
| `{val: 1, left: {val: 2}}` | Serialized: `"1,2"` |

## Complexity Analysis
- **Serialization Time:** O(n) where n is the number of nodes
- **Serialization Space:** O(w) where w is the maximum width of the tree (queue size)
- **Deserialization Time:** O(n)
- **Deserialization Space:** O(n) for the nodes array

## Example Run

Input tree:
```
     1
    / \
   2   3
      / \
     4   5
```

Serialization: `"1,2,3,null,null,4,5"`

After deserialization, the tree structure is restored to match the original.