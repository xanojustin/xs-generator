# Reverse Nodes in k-Group

## Problem

Given the head of a linked list, reverse the nodes of the list k at a time, and return the modified list.

k is a positive integer and is less than or equal to the length of the linked list. If the number of nodes is not a multiple of k, then left-out nodes in the end should remain as they are.

You may not alter the values in the list's nodes, only the nodes themselves may be changed.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/reverse_k_group.xs`):** Contains the solution logic

## Function Signature

- **Input:**
  - `list` (json): Array of nodes where each node is an object with `val` (the value) and `next` (index of next node, or null)
  - `head_index` (int, optional): Index of the head node in the list (defaults to 0)
  - `k` (int): Number of nodes to reverse at a time
- **Output:**
  - Object containing:
    - `nodes`: The modified array of nodes
    - `head_index`: Index of the new head node after reversal

## Test Cases

### Linked List Representation

Nodes are represented as objects with:
- `val`: The node's value
- `next`: The index of the next node (null for tail)

Example: `[{val: 1, next: 1}, {val: 2, next: null}]` represents `1 -> 2`

| Input List | k | Expected Output (as list) |
|------------|---|---------------------------|
| `[1,2,3,4,5]` | 2 | `[2,1,4,3,5]` |
| `[1,2,3,4,5]` | 3 | `[3,2,1,4,5]` |
| `[1,2]` | 2 | `[2,1]` |
| `[1]` | 1 | `[1]` |
| `[]` | 2 | `[]` |

### Detailed Test Cases

1. **Basic case (k=2):** List `1->2->3->4->5` becomes `2->1->4->3->5`
   - First group (1,2) reversed: 2->1
   - Second group (3,4) reversed: 4->3
   - Last node (5) remains: 5

2. **Partial group (k=3):** List `1->2->3->4->5` becomes `3->2->1->4->5`
   - First group (1,2,3) reversed: 3->2->1
   - Remaining nodes (4,5) not reversed

3. **Exact fit (k=2):** List `1->2` becomes `2->1`
   - Exactly one group of 2, fully reversed

4. **Edge case (k=1):** List `[1]` remains `[1]`
   - k=1 means no reversal needed

5. **Edge case (empty list):** Empty list remains empty
