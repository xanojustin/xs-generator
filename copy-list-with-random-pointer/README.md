# Copy List with Random Pointer

## Problem

A linked list of length `n` is given such that each node contains an additional **random pointer**, which could point to any node in the list, or `null`.

Construct a **deep copy** of the list. The deep copy should consist of exactly `n` brand new nodes, where each new node has its value set to the value of its corresponding original node. Both the `next` and `random` pointers of the new nodes should point to new nodes in the copied list such that the pointers in the original list and copied list represent the same list state. **None of the pointers in the new list should point to nodes in the original list.**

For example, if there are two nodes `X` and `Y` in the original list, where `X.random` → `Y`, then for the corresponding two nodes `x` and `y` in the copied list, `x.random` → `y`.

Return the head of the copied linked list.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/copy_list_with_random_pointer.xs`):** Contains the solution logic

## Function Signature

- **Input:**
  - `nodes` (json): An array of node objects, where each node has:
    - `value` (any): The data value of the node
    - `next` (int|null): Index of the next node in the array, or `null` if end of list
    - `random` (int|null): Index of a random node in the array, or `null`
  - `head_index` (int|null, optional): Index of the head node, defaults to 0

- **Output:**
  - `nodes` (json): The new array of copied nodes with mapped `next` and `random` pointers
  - `head_index` (int|null): Index of the head node in the new array

## Algorithm

The solution uses a two-pass approach:

1. **First Pass:** Create a mapping from old node indices to new node indices, and build the new nodes array with values but null pointers.

2. **Second Pass:** Iterate through the original nodes again and use the mapping to set the correct `next` and `random` pointers in the copied nodes.

This approach ensures O(n) time complexity and O(n) space complexity.

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[{value:7,next:1,random:null},{value:13,next:2,random:0},{value:11,next:3,random:4},{value:10,next:4,random:2},{value:1,next:null,random:0}]` with head=0 | Copied list with same structure, all pointers mapped to new indices |
| Empty list `[]` | Empty list `[]` with `head_index: null` |
| Single node `[{value:1,next:null,random:null}]` | Single copied node with null pointers |
| Node with self-referencing random `[{value:1,next:null,random:0}]` | Copied node with random pointing to itself (index 0) |
| `head_index: null` | Empty list with `head_index: null` |

### Example Walkthrough

**Input:**
```
Index 0: { value: 7, next: 1, random: null }
Index 1: { value: 13, next: 2, random: 0 }     // random points to node 0
Index 2: { value: 11, next: 3, random: 4 }     // random points to node 4
Index 3: { value: 10, next: 4, random: 2 }     // random points to node 2
Index 4: { value: 1, next: null, random: 0 }   // random points to node 0
Head: 0
```

**Output:**
```
Index 0: { value: 7, next: 1, random: null }
Index 1: { value: 13, next: 2, random: 0 }     // random now points to new node 0
Index 2: { value: 11, next: 3, random: 4 }     // random now points to new node 4
Index 3: { value: 10, next: 4, random: 2 }     // random now points to new node 2
Index 4: { value: 1, next: null, random: 0 }   // random now points to new node 0
Head: 0
```

Note: The copied list has the same structure but is a completely independent copy.
