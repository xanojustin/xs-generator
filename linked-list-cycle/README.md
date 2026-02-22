# Linked List Cycle Detection

## Problem
Given a linked list, determine if it contains a cycle.

A cycle exists in a linked list if some node in the list can be reached again by continuously following the `next` pointers. Internally, `next` is an index pointing to the position in the array of the next node. `-1` indicates the end of the list (null).

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/linked_list_cycle.xs`):** Contains the solution logic using Floyd's Tortoise and Hare algorithm

## Function Signature
- **Input:** 
  - `nodes` (object[]): Array of linked list nodes, where each node is an object with:
    - `value` (any): The data stored in the node
    - `next` (int): Index of the next node in the array, or `-1` if this is the tail
- **Output:** 
  - (bool): `true` if the linked list contains a cycle, `false` otherwise

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `nodes: [{value: 3, next: 1}, {value: 2, next: 2}, {value: 0, next: 3}, {value: -4, next: 1}]` | `true` (cycle: node 3 -> node 1) |
| `nodes: [{value: 1, next: 1}, {value: 2, next: -1}]` | `false` (no cycle, linear list) |
| `nodes: []` | `false` (edge case: empty list) |
| `nodes: [{value: 1, next: -1}]` | `false` (edge case: single node) |
| `nodes: [{value: 1, next: 1}]` | `true` (boundary: single node pointing to itself) |

## Algorithm
This solution uses **Floyd's Cycle-Finding Algorithm** (also known as the "Tortoise and Hare" algorithm):

1. Initialize two pointers, `slow` and `fast`, both starting at the head of the list (index 0)
2. Move `slow` pointer 1 step at a time
3. Move `fast` pointer 2 steps at a time
4. If there is a cycle, the `fast` pointer will eventually meet the `slow` pointer
5. If there is no cycle, the `fast` pointer will reach the end of the list (next = -1)

**Why it works:** If there's a cycle, the fast pointer (moving at 2x speed) will eventually lap the slow pointer and they will meet inside the cycle.

**Time Complexity:** O(n) - in the worst case, we traverse each node once  
**Space Complexity:** O(1) - only uses two pointers, no extra data structures

## Alternative Approaches
- **Hash Set:** Store visited nodes in a set and check for duplicates. O(n) time, O(n) space.
- **Modify Values:** Mark visited nodes by changing their values (destructive, not recommended).
