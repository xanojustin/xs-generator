# Linked List Reversal

## Problem
Reverse a singly linked list and return both the reversed list and the new head index.

Given a linked list represented as an array of nodes where each node has:
- `value`: The data stored in the node
- `next`: The index of the next node, or `null` if this is the tail

Return the reversed linked list with all `next` pointers updated to point in the reverse direction.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/reverse_linked_list.xs`):** Contains the solution logic

## Function Signature
- **Input:** 
  - `list` (object[]): Array of nodes, each with `value` (any type) and `next` (int or null)
  - `head_index` (int?, optional): Index of the head node (default: 0)
- **Output:** 
  - Object containing:
    - `nodes` (object[]): The reversed linked list with updated `next` pointers
    - `head_index` (int or null): Index of the new head node

## Test Cases

| Input List | Head Index | Expected Head Index | Expected List Order (values) |
|------------|------------|---------------------|------------------------------|
| `[{value:1,next:1}, {value:2,next:2}, {value:3,next:3}, {value:4,next:4}, {value:5,next:null}]` | 0 | 4 | 5 → 4 → 3 → 2 → 1 |
| `[{value:"A",next:null}]` | 0 | 0 | A (single node) |
| `[]` | 0 | null | empty list |
| `[{value:1,next:null}, {value:2,next:null}]` | null | null | unchanged (null head) |

### Example Walkthrough

Input:
```
Index:    0     1     2     3     4
Value:    1  →  2  →  3  →  4  →  5  →  null
Next:     1     2     3     4    null
Head: 0
```

Output:
```
Index:    0     1     2     3     4
Value:    1  ←  2  ←  3  ←  4  ←  5
Next:    null   0     1     2     3
Head: 4
```

The list is now: 5 → 4 → 3 → 2 → 1 → null

## Algorithm
This implementation uses the classic three-pointer approach:
1. `prev` - tracks the previous node (starts as null)
2. `current` - tracks the current node being processed (starts at head)
3. `next_node` - temporarily stores the next node before links are reversed

For each node:
1. Store the next node
2. Reverse the current node's pointer to point to prev
3. Move prev and current forward

Time Complexity: O(n) - we visit each node once
Space Complexity: O(1) - we only use a constant amount of extra space (modifying in-place)
