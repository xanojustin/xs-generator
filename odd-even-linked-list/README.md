# Odd Even Linked List

## Problem
Given the head of a singly linked list, group all the nodes with odd indices together followed by the nodes with even indices, and return the reordered list.

The **first** node is considered **odd**, and the **second** node is **even**, and so on.

Note that the relative order inside both the even and odd groups should remain as it was in the input.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/odd_even_linked_list.xs`):** Contains the solution logic

## Function Signature
- **Input:**
  - `nodes` (json): Array of node objects, each with `value` and `next` (index of next node or null)
  - `head_index` (int): Index of the head node in the array
- **Output:**
  - `nodes` (json): Reordered array of nodes
  - `head_index` (int): Index of the head node (unchanged)

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[1→2→3→4→5]` | `[1→3→5→2→4]` |
| `[2→1→3→5→6→4→7]` | `[2→3→6→7→1→5→4]` |
| `[1]` | `[1]` |
| `[]` | `[]` |

### Example Walkthrough
**Input:** `1 → 2 → 3 → 4 → 5`

Positions: 1(odd)→2(even)→3(odd)→4(even)→5(odd)

**Output:** `1 → 3 → 5 → 2 → 4`

Odd nodes (1,3,5) come first, then even nodes (2,4).

## Algorithm
1. Handle edge cases (empty list or single node)
2. Traverse the list, separating nodes into odd and even lists
3. Connect the end of the odd list to the head of the even list
4. Terminate the even list

## Complexity
- **Time:** O(n) - single pass through the list
- **Space:** O(1) - only using pointers, no extra data structures
